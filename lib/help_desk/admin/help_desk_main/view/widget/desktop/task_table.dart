import 'package:flutter/material.dart';
import 'package:senior_project/assets/color_constant.dart';
import 'package:senior_project/help_desk/admin/help_desk_main/view/widget/desktop/table_detail.dart';

class TaskTable extends StatefulWidget {
  const TaskTable({super.key});

  @override
  State<TaskTable> createState() => _TaskTableState();
}

class _TaskTableState extends State<TaskTable> {
  // * Test data
  final data = [
    {
      "username": "Runn",
      "email": "runn@gmail.com",
      "taskHeader": "Lorem ipsum",
      "taskDetail": "Lorem ipsum dolor sit amet, consectetur adiwfefef cwcececqsc.",
      "priority": "Urgent", // 0-3 (low, medium, high, urgent)
      "status": "Complete", // 0-2 (not start, pending, complete)
      "category": "Register, Modcom, Camp",
      "time": "${DateTime.now().hour}:${DateTime.now().minute}"
    },
    {
      "username": "Runn",
      "email": "runn@gmail.com",
      "taskHeader": "Lorem ipsum",
      "taskDetail": "Lorem ipsum dolor sit amet, consectetur adiwfefef cwcececqsc.",
      "priority": "Urgent", // 0-3 (low, medium, high, urgent)
      "status": "Complete", // 0-2 (not start, pending, complete)
      "category": "Register, Modcom, Camp",
      "time": "${DateTime.now().hour}:${DateTime.now().minute}"
    },
  ];

  static const _headerTextStyle = TextStyle(
      fontFamily: ColorConstant.font,
      fontSize: 18,
      fontWeight: FontWeight.w700,
      color: Colors.white
  );

  final _vController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 807,
      child: Scrollbar(
        controller: _vController,
        thumbVisibility: true,
        child: SingleChildScrollView(
          controller: _vController,
          child: DataTable(
            headingRowHeight: 69,
            headingRowColor: MaterialStateProperty.all(ColorConstant.orange30),
            headingTextStyle: _headerTextStyle,
            dataRowHeight: 80,
            dataRowColor: MaterialStateProperty.all(Colors.white),
            columns: TableDetail.headerWidget(),
            rows: [
              TableDetail.detailWidget(data[0]),
              TableDetail.detailWidget(data[0]),
              TableDetail.detailWidget(data[0]),
              TableDetail.detailWidget(data[0]),
              TableDetail.detailWidget(data[0]),
              TableDetail.detailWidget(data[0]),
              TableDetail.detailWidget(data[0]),
              TableDetail.detailWidget(data[0]),
              TableDetail.detailWidget(data[0]),
              TableDetail.detailWidget(data[0]),
            ],
          ),
        ),
      ),
    );
  }
}