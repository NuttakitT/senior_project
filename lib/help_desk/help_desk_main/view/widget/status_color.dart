import 'package:flutter/material.dart';
import 'package:senior_project/assets/color_constant.dart';

class StatusColor {
  // bg, text, border
  static List<Color>? statusColor(int status) {
    switch (status) {
      case 0:
        return [ColorConstant.whiteBlack10, ColorConstant.whiteBlack70, ColorConstant.whiteBlack30];
      case 1:
        return [ColorConstant.yellow50, ColorConstant.yellow5, ColorConstant.yellow60];
      case 2:
        return [ColorConstant.green40, ColorConstant.green5, ColorConstant.green60];
      default:
        return null;
    }
  }
}