import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senior_project/community_board/view/desktop/widget/community_board_content.dart';
import 'package:senior_project/community_board/view/desktop/widget/in_detail_content.dart';
import 'package:senior_project/community_board/view_model/community_board_view_model.dart';

import '../../../../core/template/template_desktop/view/page/template_desktop.dart';

class TemplateCommunityBoard extends StatefulWidget {
  const TemplateCommunityBoard({super.key});

  @override
  State<TemplateCommunityBoard> createState() => _TemplateCommunityBoardState();
}

class _TemplateCommunityBoardState extends State<TemplateCommunityBoard> {
  @override
  Widget build(BuildContext context) {
    return TemplateDesktop(
        helpdesk: false,
        helpdeskadmin: false,
        home: true,
        useTemplatescroll: true,
        content: Builder(
          builder: (context) {
            bool isShowPostDetail = context.watch<CommunityBoardViewModel>().getIsShowPostDetail;
            if (isShowPostDetail) {
              return const InDetailContent();
            }
            return const CommunityBoardContent();
          }
        )
    );
  }
}
