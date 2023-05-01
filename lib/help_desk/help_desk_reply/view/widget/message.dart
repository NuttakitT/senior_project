import 'package:flutter/material.dart';
import 'package:senior_project/assets/color_constant.dart';
import 'package:senior_project/assets/font_style.dart';
import 'package:senior_project/help_desk/help_desk_reply/view/widget/text_message.dart';

class Message extends StatelessWidget {
  final String text;
  final String time;
  final bool isSender;
  final bool isMobile;
  final String? imageUrl;
  const Message({
    Key? key,
    required this.text,
    required this.isSender,
    required this.isMobile,
    required this.time, 
    this.imageUrl
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: Row(
        mainAxisAlignment:
            isSender ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!isSender) ...[
            const Icon(
              Icons.face_rounded,
              color: ColorConstant.blue70,
            )
          ],
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: !isSender ? CrossAxisAlignment.start : CrossAxisAlignment.end,
            children: [
              TextMessage(
                text: text,
                isSender: isSender,
                isMobile: isMobile,
                imageUrl: imageUrl,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(
                  time,
                  style: const TextStyle(
                    fontFamily: AppFontStyle.font,
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    color: ColorConstant.whiteBlack70
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}