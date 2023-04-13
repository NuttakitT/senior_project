import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
  final List<dynamic> admin;
  const HelpDeskReplyPage({
    super.key, 
    required this.docId,
    required this.id,
    required this.title,
    required this.detail,
    required this.priority,
    required this.status,
    required this.category,
    required this.time,
    required this.admin
  });

  @override
  State<HelpDeskReplyPage> createState() => _HelpDeskReplyPageState();
}

class _HelpDeskReplyPageState extends State<HelpDeskReplyPage> {
  @override
  Widget build(BuildContext context) {
    bool isMobile = context.watch<AppViewModel>().getMobileSiteState(MediaQuery.of(context).size.width);
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
      "admin": widget.admin
    };

    if (isMobile) {
      return FutureBuilder(
        future: context.read<HelpDeskViewModel>().changeSeenStatus(
          widget.docId,
          uid, 
          isAdmin
        ),
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
        }
      );
    }
    return HelpDeskMainView(isAdmin: isAdmin,);
  }
}