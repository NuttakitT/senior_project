import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senior_project/assets/color_constant.dart';
import 'package:senior_project/core/view_model/app_view_model.dart';
import 'package:senior_project/help_desk/help_desk_reply/view_model/reply_channel_view_model.dart';

class ChatInput extends StatefulWidget {
  const ChatInput({
    Key? key,
  }) : super(key: key);

  @override
  State<ChatInput> createState() => _ChatInputState();
}

class _ChatInputState extends State<ChatInput> {
  String text = "";

  @override
  Widget build(BuildContext context) {
    String userId = context.watch<AppViewModel>().app.getUser.getId;

    return ConstrainedBox(
      constraints: const BoxConstraints(maxHeight: 64),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: ColorConstant.white,
            boxShadow: [
              BoxShadow(
                offset: const Offset(0, 4),
                color: ColorConstant.black.withOpacity(0.08),
                blurRadius: 100,
              ),
            ],
            borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16))),
        child: Row(
          children: [
            InkWell(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                //Todo fill color
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(360)),
                child: const Icon(
                  Icons.add,
                  color: ColorConstant.blue40,
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
                  border: Border.all(color: ColorConstant.whiteBlack40)),
              child: Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: TextField(
                  decoration: const InputDecoration.collapsed(
                      hintText: "Type message...", border: InputBorder.none),
                  style: const TextStyle(
                      color: ColorConstant.whiteBlack50, fontSize: 14),
                  onChanged: (value) {
                    text = value;
                  },
                ),
              ),
            )),
            InkWell(
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: Icon(
                  Icons.sentiment_satisfied_alt_rounded,
                  color: ColorConstant.blue40,
                ),
              ),
              onTap: () {
                //Todo Emoji
              },
            ),
            InkWell(
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: Icon(
                  Icons.send_rounded,
                  color: ColorConstant.blue40,
                ),
              ),
              onTap: () {
                if (text.isNotEmpty) {
                  context.read<ReplyChannelViewModel>().createMessage(
                    context.read<ReplyChannelViewModel>().getTaskData["docId"], 
                    {
                      "ownerId": userId,
                      "message": text,
                      "time": DateTime.now(),
                      "seen": false
                    }
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
