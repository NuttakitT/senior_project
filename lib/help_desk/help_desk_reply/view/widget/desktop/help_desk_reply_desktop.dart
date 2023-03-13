import 'package:flutter/material.dart';
import 'package:senior_project/core/template_desktop/view/page/template_desktop.dart';
import 'package:senior_project/help_desk/help_desk_reply/view/widget/desktop/body_reply_desktop.dart';

class HelpDeskReplyDesktop extends StatelessWidget {
  const HelpDeskReplyDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    return const TemplateDesktop(
        faqmenu: false,
        faqmenuadmin: false,
        helpdesk: false,
        helpdeskadmin: false,
        home: false,
        useTemplatescroll: true,
        content: BodyReplyDesktop());
  }
}
