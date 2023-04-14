import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senior_project/assets/color_constant.dart';
import 'package:senior_project/core/template/template_desktop/view_model/template_desktop_view_model.dart';
import 'package:senior_project/core/view_model/app_view_model.dart';
import 'package:senior_project/core/view_model/text_search.dart';
import 'package:senior_project/help_desk/help_desk_main/view/desktop/content_loader/generate_content.dart';
import 'package:senior_project/help_desk/help_desk_main/view/widget/loader_status.dart';
import 'package:senior_project/help_desk/help_desk_main/view_model/help_desk_view_model.dart';

class TextSearchResult extends StatefulWidget {
  final double contentSize;
  const TextSearchResult({super.key, required this.contentSize});

  @override
  State<TextSearchResult> createState() => _TextSearchResultState();
}

class _TextSearchResultState extends State<TextSearchResult> {
  @override
  void initState() {
    context.read<TextSearch>().initHitSearcher("ticket");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    context.read<HelpDeskViewModel>().setIsSafeLoad = false;
    context.read<TextSearch>().getHitsSearcher.query(
      context.watch<TextSearch>().getSearchText
    );
    
    return StreamBuilder(
      stream: context.watch<TextSearch>().getHitsSearcher.responses,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Container(
            height: widget.contentSize,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Colors.white,
              border: Border(
                bottom: BorderSide(color: ColorConstant.whiteBlack30),
              )
            ),
            alignment: Alignment.center,
            child: const LoaderStatus(text: "Error occurred")
          );
        }
        if (snapshot.connectionState == ConnectionState.active) {
          List hits = snapshot.data!.hits.toList();
          if (hits.isNotEmpty) {
            context.read<HelpDeskViewModel>().setPageNumber = 1;
            context.read<HelpDeskViewModel>().clearModel();
            context.read<HelpDeskViewModel>().reconstructSearchResult(hits);
            List<Map<String, dynamic>> data = context.watch<HelpDeskViewModel>().getTask;
            context.read<HelpDeskViewModel>().setIsSafeLoad = true;
            return SizedBox(
              width: double.infinity,
              child: Column(
                children: GenerateContent.generateContent(context, data, widget.contentSize),
              )
            );
          }
          context.read<HelpDeskViewModel>().setIsSafeLoad = true;
          context.read<HelpDeskViewModel>().setPageNumber = 1;
          return Container(
            height: widget.contentSize,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Colors.white,
              border: Border(
                bottom: BorderSide(color: ColorConstant.whiteBlack30),
              )
            ),
            alignment: Alignment.center,
            child: const LoaderStatus(text: "No result")
          );
        }
        return Container(
          height: widget.contentSize,
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
}