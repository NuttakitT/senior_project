import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senior_project/community_board/view/desktop/page/template_community_board.dart';
import 'package:senior_project/community_board/view/mobile/page/template_community_board_mobile.dart';
import 'package:senior_project/core/view_model/app_view_model.dart';

class CommunityBoardView extends StatefulWidget {
  const CommunityBoardView({super.key});

  @override
  State<CommunityBoardView> createState() => _CommunityBoardViewState();
}

class _CommunityBoardViewState extends State<CommunityBoardView> {
  @override
  Widget build(BuildContext context) {
    bool isMobileSite = context.watch<AppViewModel>().getMobileSiteState(MediaQuery.of(context).size.width);
    if (isMobileSite) {
      return const TemplateCommunityBoardMobile();
    }
    return const TemplateCommunityBoard();
  }
}