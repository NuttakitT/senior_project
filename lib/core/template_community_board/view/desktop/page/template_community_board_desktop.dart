import 'package:flutter/material.dart';
import 'package:senior_project/core/template_desktop/view/page/template_desktop.dart';

class TemplateCommunityBoardDesktop extends StatelessWidget {
  const TemplateCommunityBoardDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    return const TemplateDesktop(
        faqmenu: false,
        faqmenuadmin: false,
        helpdesk: false,
        helpdeskadmin: false,
        home: true,
        useTemplatescroll: true,
        content: TemplateCommunityBoardDesktop());
  }
}
