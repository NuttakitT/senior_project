import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senior_project/assets/color_constant.dart';
import 'package:senior_project/help_desk/help_desk_reply/view/widget/mobile/body_reply_mobile.dart';
import 'package:senior_project/help_desk/help_desk_reply/view/widget/mobile/description_mobile.dart';
import 'package:senior_project/help_desk/help_desk_reply/view_model/reply_channel_view_model.dart';

class HelpDeskReplyMobile extends StatefulWidget {
  const HelpDeskReplyMobile({super.key});

  @override
  State<HelpDeskReplyMobile> createState() => _HelpDeskReplyMobileState();
}

class _HelpDeskReplyMobileState extends State<HelpDeskReplyMobile> {
  @override
  Widget build(BuildContext context) {
    String taskTitle =
        context.watch<ReplyChannelViewModel>().getTaskData["title"];

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: ColorConstant.whiteBlack80,
          ),
        ),
        backgroundColor: ColorConstant.white,
        title:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Expanded(
            // width: 200,
            child: Text(
              taskTitle,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                  color: ColorConstant.whiteBlack80, fontSize: 24),
            ),
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
