import 'package:flutter/material.dart';
import 'package:senior_project/assets/constant.dart';

class CardTextStyle {
  static double _scaleText(double breakpointPixel) {
    if (breakpointPixel > 610) {
      return 18;
    }
    if (breakpointPixel <= 610 && breakpointPixel > 560) {
      return 16;
    }
    if (breakpointPixel <= 560 && breakpointPixel > 430) {
      return 14;
    }
    if (breakpointPixel <= 430 && breakpointPixel > 360) {
      return 13;
    } 
    if (breakpointPixel <= 360 && breakpointPixel > 335) {
      return 12;
    } 
    return 11;
  }

  static TextStyle headerStyle(bool isMobileSite) => TextStyle(
    fontFamily: Constant.font,
    fontWeight: FontWeight.w500,
    fontSize: isMobileSite ? 20 : 24,
    color: Constant.whiteBlack80
  );
  static TextStyle subStyle(double breakpointPixel) => TextStyle(
    fontFamily: Constant.font,
    fontWeight: FontWeight.w300,
    fontSize:  _scaleText(breakpointPixel),
    color: Constant.whiteBlack90
  );
}