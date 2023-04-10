import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:senior_project/help_desk/help_desk_main/view_model/help_desk_view_model.dart';
import 'package:senior_project/help_desk/help_desk_reply/view_model/reply_channel_view_model.dart';

class SetReply {
  static void setReplyPageData(BuildContext context, int limit) {
    int selectedTicket = context.watch<HelpDeskViewModel>().getSelectedTicket!;
    int calculatedPage = (selectedTicket / (limit)).ceil();
    int calculateSelected = selectedTicket - (calculatedPage-1) * limit;
    List<Map<String, dynamic>> allTicket = context.watch<HelpDeskViewModel>().getTask;
    Map<String, dynamic> ticket = allTicket[calculateSelected - 1];
    context.read<ReplyChannelViewModel>().setTaskData = {
      "docId": ticket["docId"],
      "id": ticket["id"],
      "title": ticket["title"],
      "detail": ticket["detail"],
      "priority": ticket["priority"],
      "status": ticket["status"],
      "category": ticket["category"],
      "time": ticket["time"],
      "name": ticket["name"],
      "admin": ticket["admin"],
    };
  }
}