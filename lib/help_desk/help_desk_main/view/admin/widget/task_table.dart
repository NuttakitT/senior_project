import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senior_project/assets/color_constant.dart';
import 'package:senior_project/help_desk/help_desk_main/view/admin/widget/header_table.dart';
import 'package:senior_project/help_desk/help_desk_main/view/admin/widget/table_detail.dart';
import 'package:senior_project/help_desk/help_desk_main/view_model/help_desk_view_model.dart';

class TaskTable extends StatefulWidget {
  const TaskTable({super.key});

  @override
  State<TaskTable> createState() => _TaskTableState();
}

class _TaskTableState extends State<TaskTable> {
  final _vController = ScrollController();

  Widget detail(Map<String, dynamic> detail) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            width: 2,
            color: ColorConstant.whiteBlack5
          )
        )
      ),
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
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    List<Map<String, dynamic>> data = context.watch<HelpDeskViewModel>().getTask;

    return Column(
      children: [
        HeaderTable.widget(),
        Builder(
          builder: (context) {
            if (data.isEmpty) {
              return const Padding(
                padding: EdgeInsets.only(top: 8.0),
                child: Text(
                  "Task Complete",
                  style: TextStyle(
                    fontFamily: ColorConstant.font,
                    fontWeight: FontWeight.w400,
                    fontSize: 20,
                    color: ColorConstant.whiteBlack60
                  ),
                ),
              );
            }
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
          }
        ),
      ],
    );
  }
}