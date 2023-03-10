import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senior_project/assets/color_constant.dart';
import 'package:senior_project/core/view_model/app_view_model.dart';
import 'package:senior_project/help_desk/help_desk_reply/view_model/reply_channel_view_model.dart';

class ChatInputMobile extends StatelessWidget {
  const ChatInputMobile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String userId = context.watch<AppViewModel>().app.getUser.getId;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      decoration: BoxDecoration(color: ColorConstant.white, boxShadow: [
        BoxShadow(
          offset: const Offset(0, 4),
          color: ColorConstant.black.withOpacity(0.08),
          blurRadius: 100,
        ),
      ]),
      child: SafeArea(
          child: Row(
        children: [
          InkWell(
            child: Container(
              padding: const EdgeInsets.all(8),
              //Todo fill color
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(360)),
              child: const Icon(
                Icons.add,
                color: ColorConstant.orange40,
              ),
            ),
            //TODO Send image or video
          ),
          Expanded(
              child: Container(
            alignment: Alignment.centerLeft,
            height: 40,
            decoration: BoxDecoration(
                color: ColorConstant.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: ColorConstant.orange40)),
            child: Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: TextField(
                decoration: const InputDecoration.collapsed(
                    hintText: "Type message...", border: InputBorder.none),
                style:
                    const TextStyle(color: ColorConstant.whiteBlack50, fontSize: 14),
                onSubmitted: (value) {
                  context.read<ReplyChannelViewModel>().createMessage(
                    context.read<ReplyChannelViewModel>().getTaskData["docId"], 
                    {
                      "ownerId": userId,
                      "message": value,
                      "time": DateTime.now(),
                      "seen": false
                    }
                  );
                },
              ),
            ),
          )),
          const InkWell(
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(Icons.sentiment_satisfied_alt_rounded),
            ),
            //Todo Emoji
          )
        ],
      )),
    );
  }
}
