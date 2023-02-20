import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senior_project/assets/color_constant.dart';
import 'package:senior_project/assets/font_style.dart';
import 'package:senior_project/core/datasource/firebase_services.dart';
import 'package:senior_project/core/template_desktop/view_model/template_desktop_view_model.dart';
import 'package:senior_project/help_desk/help_desk_main/view/user/widget/help_desk_card_widget.dart';
import 'package:senior_project/help_desk/help_desk_main/view_model/help_desk_view_model.dart';

Stream? query(String id, int type) {
  final FirebaseServices service = FirebaseServices("task");
  switch (type) {
      case 0:
        return service.listenToDocumentByKeyValuePair(["ownerId"], [id]);
      case 1:
        return service.listenToDocumentByKeyValuePair(["ownerId", "status"], [id, 0]);
      case 2:
        return service.listenToDocumentByKeyValuePair(["ownerId", "status"], [id, 1]);
      case 3:
        return service.listenToDocumentByKeyValuePair(["ownerId", "status"], [id, 2]);
      default:
        return null;
    }
}

class HelpDeskDesktopBody extends StatefulWidget {
  const HelpDeskDesktopBody({super.key});

  @override
  State<HelpDeskDesktopBody> createState() => _HelpDeskDesktopBodyState();
}

class _HelpDeskDesktopBodyState extends State<HelpDeskDesktopBody> {
  Stream? _stream;

  List<Widget> generateContent(List<Map<String, dynamic>> data) {
    List<Widget> content = [];
    for (int i = 0; i < data.length; i++) {
      content.add(HelpDeskCardWidget(card: data[i],context: context).widget());
    }
    return content;
  }

  @override
  void didChangeDependencies() {
    int tagBarSelected = context.watch<TemplateDesktopViewModel>().selectedTagBar(4);
    context.read<HelpDeskViewModel>().cleanModel();
    // TODO listen to user id
    _stream = query("test23", tagBarSelected);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    var bodyPadding = const EdgeInsets.fromLTRB(77, 40, 20, 0);

    return Padding(
      padding: bodyPadding,
      child: 
      StreamBuilder(
        stream: _stream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text(
              "Error occurred",
              style: TextStyle(
                fontFamily: AppFontStyle.font,
                fontWeight: FontWeight.w400,
                fontSize: 20,
                color: ColorConstant.whiteBlack60
              ),
            );
          } 
          if (snapshot.connectionState == ConnectionState.active) {
            if (snapshot.data!.docs.isNotEmpty) {
              context.read<HelpDeskViewModel>().reconstructQueryData(snapshot.data as QuerySnapshot);
              List<Map<String, dynamic>> data = context.watch<HelpDeskViewModel>().getTask;
              return SizedBox(
                width: double.infinity,
                child: Column(
                  children: generateContent(data),
                )
              );
            } else {
              context.read<HelpDeskViewModel>().cleanModel();
              return  const Center(
                child: Text(
                  "No task in this section",
                  style: TextStyle(
                    fontFamily: AppFontStyle.font,
                    fontWeight: FontWeight.w400,
                    fontSize: 20,
                    color: ColorConstant.whiteBlack60
                  ),
                ),
              );
            }      
          } else {
            return const Center(
              child: Text(
                "Loading...",
                style: TextStyle(
                  fontFamily: AppFontStyle.font,
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                  color: ColorConstant.whiteBlack60
                ),
              ),
            );
          }
        },
      )
    );
  }
}
