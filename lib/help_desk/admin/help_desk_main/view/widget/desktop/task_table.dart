import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:senior_project/help_desk/admin/help_desk_main/view/widget/desktop/header_table.dart';
import 'package:senior_project/help_desk/admin/help_desk_main/view/widget/desktop/table_detail.dart';

class TaskTable extends StatefulWidget {
  const TaskTable({super.key});

  @override
  State<TaskTable> createState() => _TaskTableState();
}

class _TaskTableState extends State<TaskTable> {
  // TODO edit to provider
  final data = [
    {
      "id": "#123",
      "username": "Runn",
      "email": "runn@gmail.com",
      "taskHeader": "Lorem ipsum",
      "taskDetail": "Lorem ipsum dolor sit amet, consectetur adiwfefef cwcececqsc.",
      "priority": 3, // 0-3 (low, medium, high, urgent)
      "status": 2, // 0-2 (not start, pending, complete)
      "category": "Register, Modcom, Camp",
      "time": DateFormat('hh:mm a').format(DateTime.now())
    },
    {
      "id": "#456",
      "username": "Runn",
      "email": "runn@gmail.com",
      "taskHeader": "Lorem ipsum",
      "taskDetail": "Lorem ipsum dolor sit amet, consectetur adiwfefef cwcececqsc.",
      "priority": 1, // 0-3 (low, medium, high, urgent)
      "status": 1, // 0-2 (not start, pending, complete)
      "category": "Register, Modcom, Camp",
      "time": DateFormat('hh:mm a').format(DateTime.now())
    },
    {
      "id": "#456",
      "username": "Runn",
      "email": "runn@gmail.com",
      "taskHeader": "Lorem ipsum",
      "taskDetail": "Lorem ipsum dolor sit amet, consectetur adiwfefef cwcececqsc.",
      "priority": 0, // 0-3 (low, medium, high, urgent)
      "status": 0, // 0-2 (not start, pending, complete)
      "category": "Register, Modcom, Camp",
      "time": DateFormat('hh:mm a').format(DateTime.now())
    },
  ];

  final _vController = ScrollController();

  Widget detail(BuildContext context, Map<String, dynamic> detail) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      color: Colors.white,
      height: 80,
      child: Row(
        children: TableDetail.widget(context, detail),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        HeaderTable.widget(),
        SizedBox(
          height: 807,
          child: Scrollbar(
            controller: _vController,
            thumbVisibility: true,
            child: SingleChildScrollView(
              controller: _vController,
              child: Column(
                children: [
                  detail(context, data[0]),
                  detail(context ,data[1]),
                  detail(context, data[2]),
                ],
              ),
            ),
          )
        ),
      ],
    );
  }
}