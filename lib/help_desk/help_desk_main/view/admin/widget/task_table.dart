import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senior_project/assets/color_constant.dart';
import 'package:senior_project/assets/font_style.dart';
import 'package:senior_project/core/datasource/firebase_services.dart';
import 'package:senior_project/core/template_desktop/view_model/template_desktop_view_model.dart';
import 'package:senior_project/help_desk/help_desk_main/view/admin/widget/header_table.dart';
import 'package:senior_project/help_desk/help_desk_main/view/admin/widget/table_detail.dart';
import 'package:senior_project/help_desk/help_desk_main/view_model/help_desk_view_model.dart';

Stream? query(int type) {
  final FirebaseServices service = FirebaseServices("task");
  switch (type) {
    case 0:
      return service.listenToDocument();
    case 1:
      return service.listenToDocumentByKeyValuePair(["status"], [0]);
    case 2: 
      return service.listenToDocumentByKeyValuePair(["status"], [1]);
    case 3:
      return service.listenToDocumentByKeyValuePair(["status"], [2]);
    case 4:
      return service.listenToDocumentByKeyValuePair(["priority"], [3]);
    case 5:
      return service.listenToDocumentByKeyValuePair(["priority"], [2]);
    case 6:
      return service.listenToDocumentByKeyValuePair(["priority"], [1]);
    case 7:
      return service.listenToDocumentByKeyValuePair(["priority"], [0]);
    default:
      return null;
  }
}

class TaskTable extends StatefulWidget {
  const TaskTable({super.key});

  @override
  State<TaskTable> createState() => _TaskTableState();
}

class _TaskTableState extends State<TaskTable> {
  final _vController = ScrollController();
  Stream? _stream;

  Widget detail(Map<String, dynamic> detail) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(
              bottom: BorderSide(width: 2, color: ColorConstant.whiteBlack5))),
      height: 80,
      child: Row(
        children: TableDetail.widget(context, detail),
      ),
    );
  }

  List<Widget> generateContent(List<Map<String, dynamic>> content) {
    List<Widget> list = [];
    for (int i = 0; i < content.length; i++) {
      list.add(detail(content[i]));
    }
    return list;
  }

  @override
  void didChangeDependencies() {
    int tagBarSelected = context.watch<TemplateDesktopViewModel>().selectedTagBar(4);
    context.read<HelpDeskViewModel>().cleanModel();
    _stream = query(tagBarSelected);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Column(
      children: [
        HeaderTable.widget(),
        StreamBuilder(
          stream: _stream,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Padding(
                padding: EdgeInsets.only(top: 8.0),
                child: Text(
                  "Error occurred",
                  style: TextStyle(
                    fontFamily: AppFontStyle.font,
                    fontWeight: FontWeight.w400,
                    fontSize: 20,
                    color: ColorConstant.whiteBlack60
                  ),
                ),
              );
            } 
            if (snapshot.connectionState == ConnectionState.active) {
              if (snapshot.data!.docs.isNotEmpty) {
                context.read<HelpDeskViewModel>().reconstructQueryData(snapshot.data as QuerySnapshot);
                List<Map<String, dynamic>> data = context.watch<HelpDeskViewModel>().getTask;
                return SizedBox(
                  height: 680 + (screenHeight - 960),
                  child: Scrollbar(
                    controller: _vController,
                    thumbVisibility: true,
                    child: SingleChildScrollView(
                      controller: _vController,
                      child: Column(
                        children: generateContent(data)
                      ),
                    ),
                  )
                );
              } else {
                context.read<HelpDeskViewModel>().cleanModel();
                return const Padding(
                  padding: EdgeInsets.only(top: 8.0),
                  child: Text(
                    "No task in this scction",
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
              return const Padding(
                padding: EdgeInsets.only(top: 8.0),
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
      ],
    );
  }
}
