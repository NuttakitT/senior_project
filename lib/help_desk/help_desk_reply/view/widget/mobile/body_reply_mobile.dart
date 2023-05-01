import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senior_project/core/datasource/firebase_services.dart';
import 'package:senior_project/core/view_model/app_view_model.dart';
import 'package:senior_project/help_desk/help_desk_reply/view/widget/chat_input.dart';
import 'package:senior_project/help_desk/help_desk_reply/view/widget/message.dart';
import 'package:senior_project/help_desk/help_desk_reply/view_model/reply_channel_view_model.dart';

Stream? query(String docId) {
  return FirebaseServices("ticket").listenToSubDocument(docId, "replyChannel");
}
class BodyReplyMobile extends StatefulWidget {
  const BodyReplyMobile({super.key});

  @override
  State<BodyReplyMobile> createState() => _BodyReplyMobileState();
}

class _BodyReplyMobileState extends State<BodyReplyMobile> {
  @override
  Widget build(BuildContext context) {
    context.read<ReplyChannelViewModel>().clearModel();
    String docId = context.watch<ReplyChannelViewModel>().getTaskData["docId"];
    String userId = context.watch<AppViewModel>().app.getUser.getId;

    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: StreamBuilder(
              stream: query(docId),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.active) {
                  if (snapshot.data.docs.isNotEmpty) {
                    context.read<ReplyChannelViewModel>().reconstructData(snapshot.data);
                    List<Map<String, dynamic>> data = context.watch<ReplyChannelViewModel>().getReply(userId);
                    return ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context, index) => Message(
                        isSender:  data[index]["isSender"],
                        text: data[index]["text"],
                        isMobile: true,
                        time: data[index]["time"],
                        imageUrl: data[index]["imageUrl"],
                      ),
                    );
                  }
                  return const Padding(
                    padding: EdgeInsets.only(top: 16),
                    child: Text("No messages in this ticket"),
                  );
                }
                return Center(
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle
                    ),
                    child: const CircularProgressIndicator()
                  )
                );
              },
            )
          ),
        ),
        const ChatInput(),
      ],
    );
  }
}