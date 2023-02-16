import 'package:flutter/material.dart';
import 'package:senior_project/assets/color_constant.dart';
import 'package:senior_project/assets/font_style.dart';

class CardTextStyle {
  static TextStyle headerStyle(bool isMobileSite) {
    return isMobileSite ? AppFontStyle.wb80Md20 : AppFontStyle.wb80Md24;
  }

  static TextStyle subStyle(bool isMobileSite) {
    return isMobileSite ? AppFontStyle.wb90L16 : AppFontStyle.wb90L18;
  }
}
