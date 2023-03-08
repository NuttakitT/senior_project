import 'package:flutter/material.dart';
import 'package:senior_project/help_desk/help_desk_reply/view/mobile/widget/chat_input_mobile.dart';
import 'package:senior_project/help_desk/help_desk_reply/view/widget/message.dart';

class BodyReplyMobile extends StatefulWidget {
  const BodyReplyMobile({super.key});

  @override
  State<BodyReplyMobile> createState() => _BodyReplyMobileState();
}

class _BodyReplyMobileState extends State<BodyReplyMobile> {
  List<Map<String, dynamic>> data = [
    {
      "text": "Hi people",
      "isSender": true
    },
    {
      "text": "Okay, How r u?",
      "isSender": false
    },
    {
      "text": "Fine",
      "isSender": true
    },
    {
      "text": "asddsssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssss",
      "isSender": false
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) => Message(
                isSender:  data[index]["isSender"],
                text: data[index]["text"],
                isMobile: true,
              ),
            ),
          ),
        ),
        const ChatInputMobile(),
      ],
    );
  }
}