import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senior_project/core/template_desktop/view/page/template_desktop.dart';
import 'package:senior_project/core/template_mobile/view/template_menu_mobile.dart';
import 'package:senior_project/core/view_model/app_view_model.dart';
import 'package:senior_project/help_desk/help_desk_main/view/admin/widget/desktop_widget.dart';
import 'package:senior_project/help_desk/help_desk_main/core/widget/mobile/mobile_widget.dart';

class HelpDeskAdminPage extends StatefulWidget {
  final List<Map<String, dynamic>> data;
  const HelpDeskAdminPage({super.key, required this.data});

  @override
  State<HelpDeskAdminPage> createState() => _HelpDeskAdminPageState();
}

class _HelpDeskAdminPageState extends State<HelpDeskAdminPage> {
  @override
  Widget build(BuildContext context) {
    context.read<AppViewModel>().selectView(MediaQuery.of(context).size.width);
    bool isMobileSite = context.watch<AppViewModel>().getMobileSiteState;

    if (isMobileSite) {
      return const TemplateMenuMobile(
          content: MobileWidget(
        isAdmin: true,
      ));
    }
    return TemplateDesktop(
        faqmenu: false,
        faqmenuadmin: false,
        helpdesk: false,
        helpdeskadmin: true,
        home: false,
        useTemplatescroll: false,
        content: Align(
            alignment: AlignmentDirectional.topCenter,
            child: DesktopWidget(
              data: widget.data,
            )));
  }
}
