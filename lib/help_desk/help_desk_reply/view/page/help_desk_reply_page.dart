import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senior_project/core/view_model/app_view_model.dart';
import 'package:senior_project/help_desk/help_desk_reply/view/widget/desktop/help_desk_reply_desktop.dart';
import 'package:senior_project/help_desk/help_desk_reply/view/widget/mobile/help_desk_reply_mobile.dart';

class HelpDeskReplyPage extends StatefulWidget {
  const HelpDeskReplyPage({super.key});

  @override
  State<HelpDeskReplyPage> createState() => _HelpDeskReplyPageState();
}

class _HelpDeskReplyPageState extends State<HelpDeskReplyPage> {
  @override
  Widget build(BuildContext context) {
    bool isMobile = context.watch<AppViewModel>().getMobileSiteState(MediaQuery.of(context).size.width);
    if (isMobile) {
      return const HelpDeskReplyMobile();
    }
    return const HelpDeskReplyDesktop();
  }
}