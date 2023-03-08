import 'package:flutter/material.dart';
import 'package:senior_project/assets/color_constant.dart';

class TextMessage extends StatelessWidget {
  final String text;
  final bool isSender;
  const TextMessage({
    Key? key,
    required this.text,
    required this.isSender
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
            color:
                ColorConstant.orange30.withOpacity(isSender ? 1 : 0.4),
            borderRadius: BorderRadius.circular(24)),
        child: Text(
          text,
          style:
              const TextStyle(color: ColorConstant.whiteBlack80, fontSize: 16),
        ));
  }
}