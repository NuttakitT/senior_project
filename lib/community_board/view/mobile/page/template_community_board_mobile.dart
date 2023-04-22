import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senior_project/community_board/view/mobile/widget/community_board_home_mobile.dart';
import 'package:senior_project/community_board/view_model/community_board_view_model.dart';
import '../../../../core/template/template_mobile/view/template_menu_mobile.dart';

class TemplateCommunityBoardMobile extends StatefulWidget {
  const TemplateCommunityBoardMobile({super.key});

  @override
  State<TemplateCommunityBoardMobile> createState() =>
      _TemplateCommunityBoardMobileState();
}

class _TemplateCommunityBoardMobileState
    extends State<TemplateCommunityBoardMobile> {
  @override
  Widget build(BuildContext context) {
    context.read<CommunityBoardViewModel>().setIsShowPostDetail(true, false, {});
    return const TemplateMenuMobile(
        content:
            CommunityBoardHomeMobile());
  }
}
