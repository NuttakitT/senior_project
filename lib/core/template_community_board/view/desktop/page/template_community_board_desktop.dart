import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senior_project/assets/color_constant.dart';
import 'package:senior_project/core/template_community_board/view/desktop/widget/community_content_desktop.dart';
import 'package:senior_project/core/template_desktop/view/page/template_desktop.dart';

import '../../../../view_model/app_view_model.dart';

class TemplateCommunityBoardDesktop extends StatelessWidget {
  const TemplateCommunityBoardDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    bool isLogin = context.watch<AppViewModel>().isLogin;
    double screenHeight = MediaQuery.of(context).size.height;
    if (isLogin = true) {
      return TemplateDesktop(
          faqmenu: false,
          faqmenuadmin: false,
          helpdesk: false,
          helpdeskadmin: false,
          home: true,
          useTemplatescroll: true,
          content: Container(
              alignment: AlignmentDirectional.topCenter,
              // height: screenHeight,
              child: Column(
                children: const [
                  CommunityContentDesktop(),
                  CommunityContentDesktop(),
                ],
              )));
    } else {
      return TemplateDesktop(
          faqmenu: false,
          faqmenuadmin: false,
          helpdesk: false,
          helpdeskadmin: false,
          home: true,
          useTemplatescroll: true,
          content: Container(
              alignment: AlignmentDirectional.topCenter,
              // height: screenHeight,
              child: Column(
                children: const [
                  CommunityContentDesktop(),
                  CommunityContentDesktop(),
                ],
              )));
    }
  }
}
