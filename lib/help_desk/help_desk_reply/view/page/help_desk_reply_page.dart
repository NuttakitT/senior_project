import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senior_project/core/datasource/firebase_services.dart';
import 'package:senior_project/core/view_model/app_view_model.dart';
import 'package:senior_project/help_desk/help_desk_main/view/page/help_desk_main_view.dart';
import 'package:senior_project/help_desk/help_desk_main/view_model/help_desk_view_model.dart';
import 'package:senior_project/help_desk/help_desk_reply/view/widget/mobile/help_desk_reply_mobile.dart';
import 'package:senior_project/help_desk/help_desk_reply/view_model/reply_channel_view_model.dart';

class HelpDeskReplyPage extends StatefulWidget {
  final String docId;
  final String id;
  final String title;
  final String detail;
  final int priority;
  final int status;
  final String category;
  final DateTime time;
  final List<dynamic> adminId;
  final String ownerId;
  const HelpDeskReplyPage(
      {super.key,
      required this.docId,
      required this.id,
      required this.title,
      required this.detail,
      required this.priority,
      required this.status,
      required this.category,
      required this.time,
      required this.adminId,
      required this.ownerId});

  @override
  State<HelpDeskReplyPage> createState() => _HelpDeskReplyPageState();
}

class _HelpDeskReplyPageState extends State<HelpDeskReplyPage> {
  bool isMobile = kIsWeb &&
      (defaultTargetPlatform == TargetPlatform.iOS ||
          defaultTargetPlatform == TargetPlatform.android);
  @override
  Widget build(BuildContext context) {
    // bool isMobile = context.watch<AppViewModel>().getMobileSiteState(MediaQuery.of(context).size.width);
    bool isAdmin = context.watch<AppViewModel>().app.getUser.getRole == 0;
    String uid = context.watch<AppViewModel>().app.getUser.getId;
    context.read<ReplyChannelViewModel>().setTaskData = {
      "docId": widget.docId,
      "id": widget.id,
      "title": widget.title,
      "detail": widget.detail,
      "priority": widget.priority,
      "status": widget.status,
      "category": widget.category,
      "time": widget.time,
      "adminId": widget.adminId,
    };

    if (isMobile) {
      return Builder(builder: (context) {
        return StreamBuilder(
            stream:
                FirebaseServices("ticket").listenToSubDocumentByKeyValuePair(
              widget.docId,
              "replyChannel",
              ["seen"],
              [false],
            ),
            builder: (context, stream) {
              if (stream.connectionState == ConnectionState.active) {
                context.read<HelpDeskViewModel>().clearReplyDocId();
                for (var item in stream.data!.docs) {
                  if (!isAdmin && item.get("ownerId") != widget.ownerId) {
                    context.read<HelpDeskViewModel>().addReplyDocId(item.id);
                  } else if (isAdmin && item.get("ownerId") == widget.ownerId) {
                    context.read<HelpDeskViewModel>().addReplyDocId(item.id);
                  }
                }
                return FutureBuilder(
                    future: context
                        .read<HelpDeskViewModel>()
                        .changeSeenStatus(widget.docId, uid, isAdmin),
                    builder: (contex, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        return const HelpDeskReplyMobile();
                      }
                      return const Scaffold(
                        body: Center(
                          child: SizedBox(
                            width: 50,
                            height: 50,
                            child: CircularProgressIndicator(),
                          ),
                        ),
                      );
                    });
              }
              return const Scaffold(
                body: Center(
                  child: SizedBox(
                    width: 50,
                    height: 50,
                    child: CircularProgressIndicator(),
                  ),
                ),
              );
            });
      });
    }
    return HelpDeskMainView(
      isAdmin: isAdmin,
    );
  }
}
