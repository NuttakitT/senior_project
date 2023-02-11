import 'package:flutter/material.dart';
import 'package:senior_project/assets/color_constant.dart';

class CardTextStyle {
  static TextStyle headerStyle(bool isMobileSite) => TextStyle(
    fontFamily: ColorConstant.font,
    fontWeight: FontWeight.w500,
    fontSize: isMobileSite ? 20 : 24,
    color: ColorConstant.whiteBlack80
  );
  static TextStyle subStyle(bool isMobileSite) => TextStyle(
    fontFamily: ColorConstant.font,
    fontWeight: FontWeight.w300,
    fontSize: isMobileSite ? 16 : 18,
    color: ColorConstant.whiteBlack90
  );
}