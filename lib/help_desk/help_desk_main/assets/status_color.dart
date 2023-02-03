import 'package:flutter/material.dart';
import 'package:senior_project/assets/color_constant.dart';

class StatusColor {
  static final List<Color> _desktopCompleteColor = [
    ColorConstant.success5,
    ColorConstant.success30,
    ColorConstant.success50,
  ];

  static final List<Color> _desktopPendingColor = [
    ColorConstant.warning5,
    ColorConstant.warning30,
    ColorConstant.warning50,
  ];

  static final List<Color> _desktopNotStartColor = [
    ColorConstant.whiteBlack5,
    ColorConstant.whiteBlack15,
    ColorConstant.whiteBlack60,
  ];

  static final List<Color> _mobileCompleteColor = [
    ColorConstant.success10,
    ColorConstant.success40,
  ];

  static final List<Color> _mobilePendingColor = [
    ColorConstant.warning10,
    ColorConstant.warning50,
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