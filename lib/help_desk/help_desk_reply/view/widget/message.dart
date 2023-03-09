import 'package:flutter/material.dart';
import 'package:senior_project/assets/color_constant.dart';
import 'package:senior_project/help_desk/help_desk_reply/view/widget/message_status_dot.dart';
import 'package:senior_project/help_desk/help_desk_reply/view/widget/text_message.dart';

class Message extends StatelessWidget {
  final String text;
  final bool isSender;
  final bool isMobile;
  const Message({
    Key? key,
    required this.text,
    required this.isSender,
    required this.isMobile
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
            //TODO Pull image profile sender
            const Icon(
              Icons.face_rounded,
              color: ColorConstant.red40,
            )
          ],
          const SizedBox(width: 8),
          TextMessage(
            text: text,
            isSender: isSender,
            isMobile: isMobile,
          ),
          //status
          if (isSender) const MessageStatusDot()
        ],
      ),
    );
  }
}