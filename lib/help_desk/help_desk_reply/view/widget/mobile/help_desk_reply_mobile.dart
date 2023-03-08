import 'package:flutter/material.dart';
import 'package:senior_project/assets/color_constant.dart';
import 'package:senior_project/help_desk/help_desk_reply/view/widget/mobile/body_reply_mobile.dart';
import 'package:senior_project/help_desk/help_desk_reply/view/widget/mobile/description_mobile.dart';

class HelpDeskReplyMobile extends StatefulWidget {
  const HelpDeskReplyMobile({super.key});

  @override
  State<HelpDeskReplyMobile> createState() => _HelpDeskReplyMobileState();
}

class _HelpDeskReplyMobileState extends State<HelpDeskReplyMobile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConstant.white,
        title:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          InkWell(
            child: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: ColorConstant.whiteBlack80,
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          //TODO pull name from back-end
          const Text(
            "Lorem Ipsum",
            style: TextStyle(color: ColorConstant.whiteBlack80, fontSize: 24),
          ),
          InkWell(
            child: const Icon(
              Icons.info_rounded,
              color: ColorConstant.whiteBlack40,
            ),
            onTap: () {
              showDialog(
                  context: context,
                  builder: ((context) {
                    return const AlertDialog(
                      alignment: Alignment.topLeft,
                      content: DescriptionMobile(),
                    );
                  }));
            },
          )
        ]),
      ),
      body: const BodyReplyMobile(),
    );
  }
}
