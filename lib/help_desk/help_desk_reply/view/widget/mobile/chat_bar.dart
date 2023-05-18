import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senior_project/core/view_model/app_view_model.dart';

import '../../../../../core/datasource/firebase_services.dart';
import '../chat_input.dart';

class ChatBar extends StatefulWidget {
  final String docId;
  final String userId;
  const ChatBar({super.key, required this.docId, required this.userId});

  @override
  State<ChatBar> createState() => _ChatBarState();
}

class _ChatBarState extends State<ChatBar> {
  @override
  Widget build(BuildContext context) {
    bool isAdmin = context.read<AppViewModel>().app.getUser.getRole == 0;
    return StreamBuilder(
      stream: FirebaseServices("ticket").listenToDocument(widget.docId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          dynamic adminId = snapshot.data!.get("adminId");
          if (snapshot.data!.get("status") < 2 || (isAdmin && (adminId == widget.userId || adminId == null) && snapshot.data!.get("status") < 2)) {
            return const ChatInput();
          }
        }
        return Container();
      });
  }
}