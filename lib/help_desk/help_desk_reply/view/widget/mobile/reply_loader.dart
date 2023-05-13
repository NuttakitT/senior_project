import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senior_project/core/datasource/firebase_services.dart';
import 'package:senior_project/help_desk/help_desk_reply/view/widget/message.dart';
import 'package:senior_project/help_desk/help_desk_reply/view_model/reply_channel_view_model.dart';

Stream? query(String docId) {
  return FirebaseServices("ticket").listenToSubDocument(docId, "replyChannel");
}

class ReplyLoader extends StatefulWidget {
  final String docId;
  final String userId;
  const ReplyLoader({super.key, required this.docId, required this.userId});

  @override
  State<ReplyLoader> createState() => _ReplyLoaderState();
}

class _ReplyLoaderState extends State<ReplyLoader> {
  @override
  Widget build(BuildContext context) {
    context.read<ReplyChannelViewModel>().clearModel();
    return StreamBuilder(
      stream: query(widget.docId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          if (snapshot.data.docs.isNotEmpty) {
            context.read<ReplyChannelViewModel>().reconstructData(snapshot.data);
            List<Map<String, dynamic>> data = context.watch<ReplyChannelViewModel>().getReply(widget.userId);
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
    );
  }
}