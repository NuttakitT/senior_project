import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:senior_project/help_desk/help_desk_main/view/admin/page/help_desk_admin_page.dart';
import 'package:senior_project/help_desk/help_desk_main/view/user/page/help_desk_main_desktop_widget.dart';

class HelpDeskMainView extends StatefulWidget {
  final bool isAdmin;
  const HelpDeskMainView({super.key, required this.isAdmin});

  @override
  State<HelpDeskMainView> createState() => _HelpDeskMainViewState();
}

class _HelpDeskMainViewState extends State<HelpDeskMainView> {
  // TODO edit to provider
  final List<Map<String, dynamic>> data = [
    {
      "id": "#123",
      "username": "Runn",
      "email": "runn@gmail.com",
      "taskHeader": "Lorem ipsum",
      "taskDetail": "Lorem ipsum dolor sit amet, consectetur adiwfefef cwcececqsc.",
      "priority": 3, // 0-3 (low, medium, high, urgent)
      "status": 2, // 0-2 (not start, pending, complete)
      "category": "Register, Modcom, Camp",
      "time": DateFormat('dd/MM/yyyy hh:mm a').format(DateTime.now())
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

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isAdmin) {
      return HelpDeskAdminPage(data: data,);
    } else {
      return HelpDeskMainDesktopWidget(cards: data);
    }
  }
}
