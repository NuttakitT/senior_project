import 'package:flutter/material.dart';
import 'package:senior_project/community_board/view/desktop/widget/community_board_content.dart';
import 'package:senior_project/core/template_desktop/view/page/template_desktop.dart';

class TemplateCommunityBoard extends StatefulWidget {
  const TemplateCommunityBoard({super.key});

  @override
  State<TemplateCommunityBoard> createState() => _TemplateCommunityBoardState();
}

class _TemplateCommunityBoardState extends State<TemplateCommunityBoard> {
  @override
  Widget build(BuildContext context) {
    return const TemplateDesktop(
        helpdesk: false,
        helpdeskadmin: false,
        home: true,
        useTemplatescroll: true,
        content: CommunityBoardContent());
  }
}
