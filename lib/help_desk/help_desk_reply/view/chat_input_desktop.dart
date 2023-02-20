import 'package:flutter/material.dart';
import 'package:senior_project/assets/color_constant.dart';

class ChatInputDesktop extends StatelessWidget {
  const ChatInputDesktop({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      decoration: BoxDecoration(
          color: ColorConstant.white,
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 4),
              color: ColorConstant.black.withOpacity(0.08),
              blurRadius: 100,
            ),
          ],
          borderRadius: BorderRadius.circular(16)),
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
              child: const TextField(
                decoration: InputDecoration(
                    hintText: "Type message...", border: InputBorder.none),
                style:
                    TextStyle(color: ColorConstant.whiteBlack50, fontSize: 14),
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
