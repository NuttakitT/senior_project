import 'package:flutter/material.dart';
import 'package:senior_project/assets/color_constant.dart';

class StatusColor {
  static final List<Color> _desktopCompleteColor = [
    ColorConstant.green5,
    ColorConstant.green30,
    ColorConstant.green50,
  ];

  static final List<Color> _desktopPendingColor = [
    ColorConstant.yellow5,
    ColorConstant.yellow30,
    ColorConstant.yellow50,
  ];

  static final List<Color> _desktopNotStartColor = [
    ColorConstant.whiteBlack5,
    ColorConstant.whiteBlack15,
    ColorConstant.whiteBlack60,
  ];

  static final List<Color> _mobileCompleteColor = [
    ColorConstant.green10,
    ColorConstant.green40,
  ];

  static final List<Color> _mobilePendingColor = [
    ColorConstant.yellow10,
    ColorConstant.yellow50,
  ];

  static final List<Color> _mobileNotStartColor = [
    ColorConstant.whiteBlack15,
    ColorConstant.whiteBlack60,
  ];

  static List<Color> getColor(bool isMobileSite, int status) {
    switch (status) {
      case 0:
        return isMobileSite ? StatusColor._mobileNotStartColor : _desktopNotStartColor;
      case 1:
        return isMobileSite ? StatusColor._mobilePendingColor : _desktopPendingColor;
      default:
        return isMobileSite ? StatusColor._mobileCompleteColor : _desktopCompleteColor;
    }
  }
}