import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senior_project/assets/color_constant.dart';
import 'package:senior_project/help_desk/help_desk_reply/view_model/reply_channel_view_model.dart';

class DescriptionMobile extends StatelessWidget {
  const DescriptionMobile({super.key});

  @override
  Widget build(BuildContext context) {
    String taskDetail = context.watch<ReplyChannelViewModel>().getTaskData["detail"];

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Description",
              style: TextStyle(
                  color: ColorConstant.whiteBlack80,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            InkWell(
              child: const Icon(
                Icons.cancel_rounded,
                color: ColorConstant.whiteBlack80,
              ),
              onTap: () {
                Navigator.pop(context);
              },
            )
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Container(
            width: 400,
            decoration: BoxDecoration(
              border: Border.all(width: 1, color: ColorConstant.whiteBlack20),
              color: ColorConstant.whiteBlack5,
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            child: Text(
              taskDetail,
              style: const TextStyle(color: ColorConstant.whiteBlack70, fontSize: 16),
            ),
          ),
        )
      ],
    );
  }
}
