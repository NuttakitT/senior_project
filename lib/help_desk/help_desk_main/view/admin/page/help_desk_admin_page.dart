import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senior_project/core/view_model/app_view_model.dart';
import 'package:senior_project/help_desk/help_desk_main/view/admin/widget/desktop/desktop_widget.dart';
import 'package:senior_project/help_desk/help_desk_main/view/widget/mobile/mobile_widget.dart';

class HelpDeskAdminPage extends StatefulWidget {
  const HelpDeskAdminPage({super.key});

  @override
  State<HelpDeskAdminPage> createState() => _HelpDeskAdminPageState();
}

class _HelpDeskAdminPageState extends State<HelpDeskAdminPage> {
  @override
  Widget build(BuildContext context) {
    // TODO templete

    context.read<AppViewModel>().selectView(MediaQuery.of(context).size.width);
    bool isMobileSite = context.watch<AppViewModel>().getMobileSiteState;
    if (isMobileSite) {
      return const MobileWidget();
    }
    return const DesktopWidget();
  }
}