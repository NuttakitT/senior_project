import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senior_project/assets/color_constant.dart';
import 'package:senior_project/core/datasource/firebase_services.dart';
import 'package:senior_project/core/template/template_desktop/view_model/template_desktop_view_model.dart';
import 'package:senior_project/core/view_model/app_view_model.dart';
import 'package:senior_project/core/view_model/text_search.dart';
import 'package:senior_project/help_desk/help_desk_main/view/desktop/content_loader/content_loader.dart';
import 'package:senior_project/help_desk/help_desk_main/view/desktop/content_loader/text_search_result.dart';
import 'package:senior_project/help_desk/help_desk_main/view/widget/loader_status.dart';
import 'package:senior_project/help_desk/help_desk_main/view_model/help_desk_view_model.dart';

Stream? query(
  String id, 
  int type, 
  bool isAdmin, 
  {
    DocumentSnapshot? startDoc, 
    bool isReverse = false,
    int? limit,
    String? category
  }) {
  final FirebaseServices service = FirebaseServices("ticket");
  bool descending = true;
  limit ??= 5;
  if (type == 0) {
    return service.listenToDocumentByKeyValuePair(
      category == null ? [isAdmin ? "relateAdmin" : "ownerId"] : [isAdmin ? "relateAdmin" : "ownerId", "category"], 
      category == null ? [id] : [id, category],
      limit: limit, orderingField: 'dateCreate', descending: descending,
      startDoc: startDoc,
      isReverse: isReverse
    );
  } 
  if (type > 3){
    return service.listenToDocumentByKeyValuePair(
      category == null ? [isAdmin ? "relateAdmin" : "ownerId", "priority"] : [isAdmin ? "relateAdmin" : "ownerId", "priority", "category"], 
      category == null ? [id, (type-7).abs()] : [id, (type-7).abs(), category],
      limit: limit, orderingField: 'dateCreate', descending: descending,
      startDoc: startDoc,
      isReverse: isReverse
    );
  }
  return service.listenToDocumentByKeyValuePair(
    category == null ? [isAdmin ? "relateAdmin" : "ownerId", "status"] : [isAdmin ? "relateAdmin" : "ownerId", "status", "category"], 
    category == null ? [id, type-1] : [id, type-1, category],
    limit: limit, orderingField: 'dateCreate', descending: descending,
    startDoc: startDoc,
    isReverse: isReverse
  );
}

class TicketList extends StatefulWidget {
  final String? selectedCategory;
  final int? limit;
  const TicketList({super.key, required this.limit, this.selectedCategory});

  @override
  State<TicketList> createState() => _TicketListState();
}

class _TicketListState extends State<TicketList> {
  double contentSize = 56;
  Stream? _firestPageStream;
  Stream? _loadOlderStream;
  ScrollController controller = ScrollController();
  int pageStateNumber = 1;

  @override
  void didChangeDependencies() {
    int tagBarSelected = context.watch<TemplateDesktopViewModel>().selectedTagBar(4);
    String uid = context.watch<AppViewModel>().app.getUser.getId;
    bool isAdmin = context.watch<AppViewModel>().app.getUser.getRole == 0;
    _firestPageStream = query(uid, tagBarSelected, isAdmin, limit: widget.limit, category: widget.selectedCategory);
    _loadOlderStream = query(
      uid, 
      tagBarSelected, 
      isAdmin, 
      startDoc: context.watch<HelpDeskViewModel>().getLastDoc,
      limit: widget.limit,
      category: widget.selectedCategory
    );
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    context.read<HelpDeskViewModel>().clearModel();

    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: screenHeight < 500 ? 500 : screenHeight - 376
      ),
      child: Scrollbar(
        controller: controller,
        thumbVisibility: true,
        child: SingleChildScrollView(
          controller: controller,
          scrollDirection: Axis.vertical,
          child: Builder(
            builder: (context) {
              String searchText = context.watch<TextSearch>().getSearchText;
              if (searchText.isEmpty) {
                return Builder(
                  builder: (context) {
                    int pageNumber = context.watch<HelpDeskViewModel>().getPageNumber;
                    bool isReverse = context.watch<HelpDeskViewModel>().getIsReverse;
                    if (pageNumber > 1 && !isReverse) {
                      return ContentLoader(
                        contentSize: contentSize, 
                        stream: _loadOlderStream, 
                      );
                    } else if (pageNumber > 1 && isReverse) {
                      return FutureBuilder(
                        future: context.read<HelpDeskViewModel>().getPreviousFirst,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.done) {
                            int tagBarSelected = context.watch<TemplateDesktopViewModel>().selectedTagBar(4);
                            String uid = context.watch<AppViewModel>().app.getUser.getId;
                            bool isAdmin = context.watch<AppViewModel>().app.getUser.getRole == 0;
                            return ContentLoader(
                              contentSize: contentSize, 
                              stream: query(
                                uid, 
                                tagBarSelected, 
                                isAdmin, 
                                startDoc: snapshot.data, 
                                isReverse: true,
                                limit: widget.limit,
                                category: widget.selectedCategory
                              ), 
                            );
                          }
                          return Container(
                            height: contentSize,
                            width: double.infinity,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              border: Border(
                                bottom: BorderSide(color: ColorConstant.whiteBlack30),
                              )
                            ),
                            alignment: Alignment.center,
                            child: const LoaderStatus(text: "Loading...")
                          );
                        },
                      );
                    } 
                    return ContentLoader(
                      contentSize: contentSize, 
                      stream: _firestPageStream, 
                    );
                  }
                );
              }
              return TextSearchResult(contentSize: contentSize);
            },
          ),
        ),
      ),
    );
  }
}