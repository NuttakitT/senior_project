import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senior_project/assets/color_constant.dart';
import 'package:senior_project/core/datasource/firebase_services.dart';
import 'package:senior_project/core/template_desktop/view_model/template_desktop_view_model.dart';
import 'package:senior_project/core/view_model/app_view_model.dart';
import 'package:senior_project/help_desk/help_desk_main/view/desktop/content.dart';
import 'package:senior_project/help_desk/help_desk_main/view/widget/loader_status.dart';
import 'package:senior_project/help_desk/help_desk_main/view_model/help_desk_view_model.dart';

Stream? query(String id, int type, bool isAdmin, {DocumentSnapshot? doc}) {
  final FirebaseServices service = FirebaseServices("ticket");
  int limit = 5;
  bool descending = true;
  if (type == 0) {
    return service.listenToDocumentByKeyValuePair(
      [isAdmin ? "adminId" : "ownerId"], 
      [id],
      limit: limit, orderingField: 'dateCreate', descending: descending,
      afterDoc: doc
    );
  } 
  if (type > 3){
    return service.listenToDocumentByKeyValuePair(
      [isAdmin ? "adminId" : "ownerId", "priority"], 
      [id, (type-7).abs()],
      limit: limit, orderingField: 'dateCreate', descending: descending,
      afterDoc: doc
    );
  }
  return service.listenToDocumentByKeyValuePair(
    [isAdmin ? "adminId" : "ownerId", "status"], 
    [id, type-1],
    limit: limit, orderingField: 'dateCreate', descending: descending,
    afterDoc: doc
  );
}

class TicketList extends StatefulWidget {
  const TicketList({super.key});

  @override
  State<TicketList> createState() => _TicketListState();
}

class _TicketListState extends State<TicketList> {
  double contentSize = 56;
  Stream? _stream;
  Stream? _stream2;
  ScrollController controller = ScrollController();

  List<Widget> _generateContent(List<Map<String, dynamic>> details) {
    List<Widget> list = [];
    for (int i = 0; i < details.length; i++) {
      list.add(Content(size: contentSize, detail: details[i], index: i,));
    }
    return list;
  }

  @override
  void initState() {
    print("init");
    context.read<HelpDeskViewModel>().cleanModel();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    int tagBarSelected = context.watch<TemplateDesktopViewModel>().selectedTagBar(4);
    String uid = context.watch<AppViewModel>().app.getUser.getId;
    bool isAdmin = context.watch<AppViewModel>().app.getUser.getRole == 0;
    context.read<HelpDeskViewModel>().cleanModel();
    _stream = query(uid, tagBarSelected, isAdmin);
    _stream2 = query(uid, tagBarSelected, isAdmin, doc: context.watch<HelpDeskViewModel>().getLasDoc);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

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
              // * test chunk loader
              print(context.watch<HelpDeskViewModel>().getIsLoadMore);
              if (context.watch<HelpDeskViewModel>().getIsLoadMore) {
                return StreamBuilder(
                  stream: _stream2,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.active) {
                      if (snapshot.data!.docs.isNotEmpty) {
                        context.read<HelpDeskViewModel>().setLastDoc(snapshot.data.docs.last);
                        print(context.read<HelpDeskViewModel>().getLasDoc!.id);
                        return FutureBuilder(
                          future: context.read<HelpDeskViewModel>().reconstructQueryData(snapshot.data as QuerySnapshot),
                          builder: (context, futureSnapshot) {
                            if (futureSnapshot.connectionState == ConnectionState.done) {
                              return FutureBuilder(
                                future: context.read<HelpDeskViewModel>().formatTaskDetail(),
                                builder: (context, _) {
                                  List<Map<String, dynamic>> content = context.watch<HelpDeskViewModel>().getTask;
                                  if (_.connectionState == ConnectionState.done) {
                                    return Column(
                                      children: _generateContent(content)
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
                            return Container();
                          },
                        );
                      }
                    }
                    return Container();
                  },
                );
              }


              return StreamBuilder(
                stream: _stream,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return const LoaderStatus(text: "Error occurred");
                  } 
                  if (snapshot.connectionState == ConnectionState.active) {
                    if (snapshot.data!.docs.isNotEmpty) {
                      context.read<HelpDeskViewModel>().setLastDoc(snapshot.data.docs.last);
                      print(context.read<HelpDeskViewModel>().getLasDoc!.id);
                      return FutureBuilder(
                        future: context.read<HelpDeskViewModel>().reconstructQueryData(snapshot.data as QuerySnapshot),
                        builder: (context, futureSnapshot) {
                          if (futureSnapshot.connectionState == ConnectionState.done) {
                            return FutureBuilder(
                              future: context.read<HelpDeskViewModel>().formatTaskDetail(),
                              builder: (context, _) {
                                List<Map<String, dynamic>> content = context.watch<HelpDeskViewModel>().getTask;
                                if (_.connectionState == ConnectionState.done) {
                                  return Column(
                                    children: _generateContent(content)
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
                          return Container();
                        },
                      );
                    } else {
                      context.read<HelpDeskViewModel>().cleanModel();
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
                        child: const LoaderStatus(text: "No task in this section")
                      );
                    }      
                  } else {
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
                  }
                },
              );
            }
          ),
        ),
      ),
    );
  }
}