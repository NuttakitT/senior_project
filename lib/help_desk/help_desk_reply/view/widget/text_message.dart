import 'package:flutter/material.dart';
import 'package:senior_project/assets/color_constant.dart';

class TextMessage extends StatelessWidget {
  final String text;
  final bool isSender;
  final bool isMobile;
  const TextMessage({
    Key? key,
    required this.text,
    required this.isSender,
    required this.isMobile
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxWidth: isMobile ? 160 : 420),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
          color:
              ColorConstant.orange30.withOpacity(isSender ? 1 : 0.4),
          borderRadius: BorderRadius.circular(24)),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: text,
              style: const TextStyle(color: ColorConstant.whiteBlack80, fontSize: 16)
            )
          ]
        ),
      )
    );
  }
}