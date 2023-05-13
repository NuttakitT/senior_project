import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senior_project/core/view_model/app_view_model.dart';
import 'package:senior_project/help_desk/help_desk_reply/view/widget/mobile/chat_bar.dart';
import 'package:senior_project/help_desk/help_desk_reply/view/widget/mobile/reply_loader.dart';
import 'package:senior_project/help_desk/help_desk_reply/view_model/reply_channel_view_model.dart';
class BodyReplyMobile extends StatefulWidget {
  const BodyReplyMobile({super.key});

  @override
  State<BodyReplyMobile> createState() => _BodyReplyMobileState();
}

class _BodyReplyMobileState extends State<BodyReplyMobile> {
  @override
  Widget build(BuildContext context) {
    String docId = context.read<ReplyChannelViewModel>().getTaskData["docId"];
    String userId = context.read<AppViewModel>().app.getUser.getId;

    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ReplyLoader(docId: docId, userId: userId)
          ),
        ),
        ChatBar(docId: docId, userId: userId)
      ],
    );
  }
}