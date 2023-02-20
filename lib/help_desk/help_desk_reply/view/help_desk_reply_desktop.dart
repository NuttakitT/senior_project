import 'package:flutter/material.dart';
import 'package:senior_project/assets/color_constant.dart';
import 'package:senior_project/help_desk/help_desk_reply/view/body_reply_desktop.dart';

class HelpDeskReplyDesktop extends StatelessWidget {
  const HelpDeskReplyDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: RichText(
            text: const TextSpan(children: [
          TextSpan(
              text: "Help ",
              style: TextStyle(
                  color: ColorConstant.blue90,
                  fontSize: 36,
                  fontWeight: FontWeight.bold)),
          TextSpan(
              text: "Desk",
              style: TextStyle(
                  color: ColorConstant.orange90,
                  fontSize: 36,
                  fontWeight: FontWeight.bold))
        ])),
        backgroundColor: ColorConstant.white,
        toolbarHeight: 90,
      ),
      body: const BodyReplyDesktop(),
    );
  }
}
