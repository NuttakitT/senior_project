import 'package:flutter/material.dart';
import 'package:senior_project/assets/color_constant.dart';

class MessageStatusDot extends StatelessWidget {
  const MessageStatusDot({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 8),
      height: 12,
      width: 12,
      decoration: const BoxDecoration(
          color: ColorConstant.green40, shape: BoxShape.circle),
      child: const Icon(
        Icons.done_rounded,
        size: 8,
        color: ColorConstant.white,
      ),
    );
  }
}