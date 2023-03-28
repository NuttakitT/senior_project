import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senior_project/assets/color_constant.dart';
import 'package:senior_project/core/template_desktop/view_model/template_desktop_view_model.dart';
import 'package:senior_project/core/view_model/app_view_model.dart';
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
  Widget build(BuildContext context) {
    String email = context.watch<AppViewModel>().app.getUser.getEmail;
    int tagBarSelected = context.watch<TemplateDesktopViewModel>().selectedTagBar(4);
    
    return StreamBuilder(
      stream: context.watch<HelpDeskViewModel>().getHitsSearcher.responses,
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
            List<String> docs = [];
            for (var item in hits) {
              if (tagBarSelected > 3) {
                if (!docs.contains(item["docId"]) 
                  && item["email"] == email 
                  && item["priority"] == (tagBarSelected-7).abs()) {
                  docs.add(item["docId"]);
                }
              } else if (tagBarSelected > 0 && tagBarSelected < 4) {
                if (!docs.contains(item["docId"]) 
                  && item["email"] == email 
                  && item["status"] == tagBarSelected-1) {
                  docs.add(item["docId"]);
                }
              } else {
                if (!docs.contains(item["docId"]) && item["email"] == email) {
                  docs.add(item["docId"]);
                }
              }
            }
            if (docs.isEmpty) {
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
            context.read<HelpDeskViewModel>().cleanModel();
            return FutureBuilder(
              future: context.read<HelpDeskViewModel>().reconstructSearchResult(docs),
              builder: ((context, futureSnapshot) {
                if (futureSnapshot.connectionState == ConnectionState.done) {
                  List<Map<String, dynamic>> data = context.watch<HelpDeskViewModel>().getTask;
                  return FutureBuilder(
                  future: context.read<HelpDeskViewModel>().formatTaskDetail(),
                  builder: (context, _) {
                    if (_.connectionState == ConnectionState.done) {
                        return SizedBox(
                        width: double.infinity,
                        child: Column(
                          children: GenerateContent.generateContent(data, widget.contentSize),
                        )
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
                return Container();
              }),
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