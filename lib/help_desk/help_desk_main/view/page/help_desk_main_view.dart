import 'package:flutter/material.dart';
import 'package:senior_project/help_desk/help_desk_main/view/admin/page/help_desk_admin_page.dart';
import 'package:senior_project/help_desk/help_desk_main/view/user/page/help_desk_main_desktop_widget.dart';

class HelpDeskMainView extends StatelessWidget {
  final bool isAdmin;
  const HelpDeskMainView({super.key, required this.isAdmin});

  @override
  Widget build(BuildContext context) {
    if (isAdmin) {
      return const HelpDeskAdminPage();
    } else {
      return const HelpDeskMainDesktopWidget();
    }
  }
}
