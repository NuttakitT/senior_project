import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senior_project/core/view_model/app_view_model.dart';
import 'package:senior_project/help_desk/help_desk_reply/view/widget/desktop/help_desk_reply_desktop.dart';
import 'package:senior_project/help_desk/help_desk_reply/view/widget/mobile/help_desk_reply_mobile.dart';
import 'package:senior_project/help_desk/help_desk_reply/view_model/reply_channel_view_model.dart';

class HelpDeskReplyPage extends StatefulWidget {
  final String docId;
  final String taskId;
  final String taskTitle;
  final String taskDetail;
  final int priority;
  final int status;
  const HelpDeskReplyPage({
    super.key, 
    required this.docId,
    required this.taskId,
    required this.taskTitle,
    required this.taskDetail,
    required this.priority,
    required this.status
  });

  @override
  State<HelpDeskReplyPage> createState() => _HelpDeskReplyPageState();
}

class _HelpDeskReplyPageState extends State<HelpDeskReplyPage> {
  @override
  Widget build(BuildContext context) {
    bool isMobile = context.watch<AppViewModel>().getMobileSiteState(MediaQuery.of(context).size.width);
    context.read<ReplyChannelViewModel>().setTaskData = {
      "docId": widget.docId,
      "id": widget.taskId,
      "title": widget.taskTitle,
      "detail": widget.taskDetail,
      "priority": widget.priority,
      "status": widget.status
    };

    if (isMobile) {
      return const HelpDeskReplyMobile();
    }
    return const HelpDeskReplyDesktop();
  }
}