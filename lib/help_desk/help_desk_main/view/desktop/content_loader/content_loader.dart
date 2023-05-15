import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senior_project/assets/color_constant.dart';
import 'package:senior_project/help_desk/help_desk_main/view/desktop/content_loader/generate_content.dart';
import 'package:senior_project/help_desk/help_desk_main/view/widget/loader_status.dart';
import 'package:senior_project/help_desk/help_desk_main/view_model/help_desk_view_model.dart';

class ContentLoader extends StatefulWidget {
  final double contentSize;
  final Stream? stream;
  const ContentLoader({
    super.key, 
    required this.contentSize, 
    required this.stream,
  });

  @override
  State<ContentLoader> createState() => _ContentLoaderState();
}

class _ContentLoaderState extends State<ContentLoader> {

  @override
  Widget build(BuildContext context) {
    context.read<HelpDeskViewModel>().setIsSafeClick = false;
    if (!context.watch<HelpDeskViewModel>().getIsSafeLoad) {
      context.read<HelpDeskViewModel>().setIsSafeClick = true;
      List<Map<String, dynamic>> content = context.watch<HelpDeskViewModel>().getTask;
      return Column(
        children: GenerateContent.generateContent(context, content, widget.contentSize)
      );
    }
    return StreamBuilder(
      stream: widget.stream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const LoaderStatus(text: "Error occurred");
        } 
        if (snapshot.connectionState == ConnectionState.active) {
          if (snapshot.data!.docs.isNotEmpty) {
            context.read<HelpDeskViewModel>().setLastDoc(snapshot.data.docs.last);
            context.read<HelpDeskViewModel>().setFirstDoc(snapshot.data.docs.first);
            context.read<HelpDeskViewModel>().addPreviousFirst = context.read<HelpDeskViewModel>().getFirstDoc!.id;
            context.read<HelpDeskViewModel>().clearModel();
            return FutureBuilder(
              future: context.read<HelpDeskViewModel>().reconstructQueryData(snapshot.data as QuerySnapshot),
              builder: (context, futureSnapshot) {
                if (futureSnapshot.connectionState == ConnectionState.done) {
                  return FutureBuilder(
                    future: context.read<HelpDeskViewModel>().formatTaskDetail(),
                    builder: (context, _) {
                      List<Map<String, dynamic>> content = context.watch<HelpDeskViewModel>().getTask;
                      if (_.connectionState == ConnectionState.done) {
                        context.read<HelpDeskViewModel>().setIsSafeClick = true;
                        context.read<HelpDeskViewModel>().setIsSafeLoad = false;
                        return Column(
                          children: GenerateContent.generateContent(context, content, widget.contentSize)
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
              },
            );
          } else {
            context.read<HelpDeskViewModel>().setIsSafeClick = true;
            context.read<HelpDeskViewModel>().setIsSafeLoad = true;
            context.read<HelpDeskViewModel>().clearModel();
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
              child: const LoaderStatus(text: "No ticket in this section")
            );
          }      
        } else {
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
        }
      },
    );
  }
}