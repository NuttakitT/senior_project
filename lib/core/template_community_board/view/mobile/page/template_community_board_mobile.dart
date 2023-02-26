import 'package:flutter/material.dart';
import 'package:senior_project/core/template_community_board/view/mobile/widget/community_content_mobile.dart';
import 'package:senior_project/core/template_mobile/view/template_menu_mobile.dart';

class TemplateCommunityBoardMobile extends StatelessWidget {
  const TemplateCommunityBoardMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return const TemplateMenuMobile(content: CommunityContentMobile());
  }
}
