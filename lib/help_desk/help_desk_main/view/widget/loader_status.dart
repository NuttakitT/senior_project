import 'package:flutter/material.dart';
import 'package:senior_project/assets/color_constant.dart';
import 'package:senior_project/assets/font_style.dart';

class LoaderStatus extends StatelessWidget {
  final String text;
  const LoaderStatus({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Text(
        text,
        style: const TextStyle(
          fontFamily: AppFontStyle.font,
          fontWeight: FontWeight.w400,
          fontSize: 20,
          color: ColorConstant.whiteBlack60
        ),
      ),
    );
  }
}