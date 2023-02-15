import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:senior_project/help_desk/help_desk_main/view/admin/page/help_desk_admin_page.dart';
import 'package:senior_project/help_desk/help_desk_main/view/user/page/help_desk_main_desktop_widget.dart';
import 'package:senior_project/help_desk/help_desk_main/view_model/help_desk_view_model.dart';

class HelpDeskMainView extends StatelessWidget {
  final bool isAdmin;
  const HelpDeskMainView({super.key, required this.isAdmin});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: context.read<HelpDeskViewModel>().initHelpDesk(isAdmin ? "" : "test23"),
      builder:  (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Scaffold(
            body: Center(
              child: Text("Loading..."),
            ),
          );
        }
        if (isAdmin) {
          return const HelpDeskAdminPage();
        } else {
          return const HelpDeskMainDesktopWidget();
        }
      }
    );
  }
}
