import 'package:flutter/material.dart';
import 'package:senior_project/assets/color_constant.dart';
import 'package:senior_project/help_desk/admin/help_desk_main/view/widget/desktop/header_table.dart';
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
      "priority": "Medium", // 0-3 (low, medium, high, urgent)
      "status": "In Progress", // 0-2 (not start, pending, complete)
      "category": "Register, Modcom, Camp",
      "time": "${DateTime.now().hour}:${DateTime.now().minute}"
    },
  ];

  final _vController = ScrollController();

  Widget detail(Map<String, dynamic> detail) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      color: Colors.white,
      height: 80,
      child: Row(
        children: TableDetail.widget(detail),
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
                  detail(data[0]),
                  detail(data[1]),
                ],
              ),
            ),
          )
        ),
      ],
    );
  }
}