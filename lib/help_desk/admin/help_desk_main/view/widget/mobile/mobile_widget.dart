import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:senior_project/help_desk/admin/help_desk_main/view/widget/mobile/task_card.dart';

class MobileWidget extends StatelessWidget {
  const MobileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO edit to provider
    final data = [
      {
        "id": "#123",
        "username": "Runnnnnnnnnnnnasdasdnnnnnnnnnnnn",
        "email": "runn@gmail.com",
        "taskHeader": "Lorem ipsu n n nnnnnasdnnnnnnnnnnnnnnnnnnnasdnnnnnnm",
        "taskDetail": "Lorem ipsum dolor sit amet, consectetur adiwfefef cwcececqscasaaa sadasdsa s ad asd sa sad sa as asd asasdasd asas asdas aaaaaaaaaaaaaaaaaaaaaaaaa.",
        "priority": 0, // 0-3 (low, medium, high, urgent)
        "status": 2, // 0-2 (not start, pending, complete)
        "category": "Register, Modcom, Camp, aaaaa, maaaaaaaa,aaaaaaaaa,aaaaaaaaa",
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
        "priority": 1, // 0-3 (low, medium, high, urgent)
        "status": 0, // 0-2 (not start, pending, complete)
        "category": "Register, Modcom, Camp",
        "time": DateFormat('hh:mm a').format(DateTime.now())
      },
    ];

    // TODO edit templete
    return Column(
      children: [

        TaskCard(detail: data[0]),
        TaskCard(detail: data[1]),
        TaskCard(detail: data[2]),
      ],
    );
  }
}