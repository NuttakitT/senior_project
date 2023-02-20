import 'package:flutter/material.dart';

import 'color_constant.dart';

extension AppFontStyle on FontStyle {
  static const font = "Roboto";
  static const interFont = "Inter";

  // white
  static const whiteR14 = TextStyle(
      fontFamily: font,
      fontWeight: AppFontWeight.regular,
      color: Colors.white,
      fontSize: 14.0);
  static const whiteR16 = TextStyle(
      fontFamily: font,
      fontWeight: AppFontWeight.regular,
      fontSize: 16,
      color: Colors.white);
  static const whiteSemiB14 = TextStyle(
      fontFamily: font,
      fontWeight: AppFontWeight.semiBold,
      color: Colors.white,
      fontSize: 14.0);
  static const whiteSemiB16 = TextStyle(
      fontFamily: font,
      fontWeight: AppFontWeight.semiBold,
      color: Colors.white,
      fontSize: 16.0);
  static const whiteSemiB18 = TextStyle(
      fontFamily: font,
      fontWeight: AppFontWeight.semiBold,
      color: Colors.white,
      fontSize: 18.0);
  static const whiteSemiB20 = TextStyle(
      fontFamily: font,
      fontWeight: AppFontWeight.semiBold,
      color: Colors.white,
      fontSize: 20.0);
  static const whiteB14 = TextStyle(
      fontFamily: font,
      fontWeight: AppFontWeight.bold,
      color: Colors.white,
      fontSize: 14.0);
  static const whiteB16 = TextStyle(
      fontFamily: font,
      fontWeight: AppFontWeight.bold,
      fontSize: 16,
      color: Colors.white);
  static const whiteB18 = TextStyle(
      fontFamily: font,
      fontWeight: AppFontWeight.bold,
      fontSize: 18,
      color: Colors.white);

  // black
  static const blackL20 = TextStyle(
      fontWeight: AppFontWeight.light,
      color: Color(0xFF000000),
      fontSize: 20.0);
  static const blackMd18 = TextStyle(
      fontWeight: AppFontWeight.medium,
      color: Color(0xFF000000),
      fontSize: 18.0);
  static const blackMd20 = TextStyle(
      fontWeight: AppFontWeight.medium,
      color: Color(0xFF000000),
      fontSize: 20.0);
  static const blackMd24 = TextStyle(
      fontWeight: AppFontWeight.medium,
      color: Color(0xFF000000),
      fontSize: 24.0);
  static const blackMd38 = TextStyle(
      fontWeight: AppFontWeight.medium,
      color: Color(0xFF000000),
      fontSize: 38.0);

  // wb
  static const wb30R14 = TextStyle(
      fontFamily: font,
      fontWeight: AppFontWeight.regular,
      fontSize: 14,
      color: ColorConstant.whiteBlack30);
  static const wb30R16 = TextStyle(
      fontFamily: font,
      fontWeight: AppFontWeight.regular,
      fontSize: 16,
      color: ColorConstant.whiteBlack30);
  static const wb40R12 = TextStyle(
      fontFamily: font,
      fontWeight: AppFontWeight.regular,
      fontSize: 12,
      color: ColorConstant.whiteBlack40);
  static const wb40R14 = TextStyle(
      fontFamily: font,
      fontWeight: AppFontWeight.regular,
      fontSize: 14,
      color: ColorConstant.whiteBlack40);
  static const wb40R16 = TextStyle(
      fontFamily: font,
      fontWeight: AppFontWeight.regular,
      fontSize: 16,
      color: ColorConstant.whiteBlack40);
  static const wb50R12 = TextStyle(
      fontFamily: font,
      fontWeight: AppFontWeight.regular,
      color: ColorConstant.whiteBlack50,
      fontSize: 12.0);
  static const wb50R16 = TextStyle(
      fontFamily: font,
      fontWeight: AppFontWeight.regular,
      color: ColorConstant.whiteBlack50,
      fontSize: 16.0);
  static const wb50Md16 = TextStyle(
      fontFamily: font,
      fontWeight: AppFontWeight.medium,
      color: ColorConstant.whiteBlack50,
      fontSize: 16.0);
  static const wb60L14 = TextStyle(
      fontFamily: font,
      fontWeight: AppFontWeight.light,
      fontSize: 14,
      color: ColorConstant.whiteBlack60);
  static const wb60L18 = TextStyle(
      fontFamily: font,
      fontWeight: AppFontWeight.light,
      fontSize: 18,
      color: ColorConstant.whiteBlack60);
  static const wb60R14 = TextStyle(
      fontFamily: font,
      fontWeight: AppFontWeight.regular,
      fontSize: 14,
      color: ColorConstant.whiteBlack60);
  static const wb60R16 = TextStyle(
      fontFamily: font,
      fontWeight: AppFontWeight.regular,
      fontSize: 16,
      color: ColorConstant.whiteBlack60);
  static const wb60R18 = TextStyle(
      fontFamily: font,
      fontWeight: AppFontWeight.regular,
      fontSize: 18,
      color: ColorConstant.whiteBlack60);
  static const wb60R20 = TextStyle(
      fontFamily: font,
      fontWeight: AppFontWeight.regular,
      fontSize: 20,
      color: ColorConstant.whiteBlack60);
  static const wb60Md16 = TextStyle(
      fontFamily: font,
      fontWeight: AppFontWeight.medium,
      fontSize: 16,
      color: ColorConstant.whiteBlack60);
  static const wb80L14 = TextStyle(
      fontFamily: font,
      fontWeight: AppFontWeight.light,
      fontSize: 14,
      color: ColorConstant.whiteBlack80);
  static const wb80L20 = TextStyle(
      fontFamily: font,
      fontWeight: AppFontWeight.light,
      fontSize: 20,
      color: ColorConstant.whiteBlack80);
  static const wb80L24 = TextStyle(
      fontFamily: font,
      fontWeight: AppFontWeight.light,
      fontSize: 24,
      color: ColorConstant.whiteBlack80);
  static const wb80R14 = TextStyle(
      fontFamily: font,
      fontWeight: AppFontWeight.regular,
      color: ColorConstant.whiteBlack80,
      fontSize: 14);
  static const wb80R16 = TextStyle(
      fontFamily: font,
      fontWeight: AppFontWeight.regular,
      color: ColorConstant.whiteBlack80,
      fontSize: 16);
  static const wb80R18 = TextStyle(
      fontFamily: font,
      fontWeight: AppFontWeight.regular,
      color: ColorConstant.whiteBlack80,
      fontSize: 18);
  static const wb80R20 = TextStyle(
      fontFamily: font,
      fontWeight: AppFontWeight.regular,
      color: ColorConstant.whiteBlack80,
      fontSize: 20);
  static const wb80R24 = TextStyle(
      fontFamily: font,
      fontWeight: AppFontWeight.regular,
      color: ColorConstant.whiteBlack80,
      fontSize: 24);
  static const wb80Md20 = TextStyle(
      fontFamily: font,
      fontWeight: AppFontWeight.medium,
      fontSize: 20,
      color: ColorConstant.whiteBlack80);
  static const wb80Md24 = TextStyle(
      fontFamily: font,
      fontWeight: AppFontWeight.medium,
      fontSize: 24,
      color: ColorConstant.whiteBlack80);
  static const wb80Md28 = TextStyle(
      fontFamily: font,
      fontWeight: AppFontWeight.medium,
      fontSize: 28,
      color: ColorConstant.whiteBlack80);
  static const wb80Md32 = TextStyle(
      fontFamily: font,
      fontWeight: AppFontWeight.medium,
      fontSize: 32,
      color: ColorConstant.whiteBlack80);
  static const wb80SemiB20 = TextStyle(
      fontFamily: font,
      color: ColorConstant.whiteBlack80,
      fontWeight: AppFontWeight.semiBold,
      fontSize: 20);
  static const wb80B20 = TextStyle(
      fontFamily: font,
      color: ColorConstant.whiteBlack80,
      fontWeight: AppFontWeight.bold,
      fontSize: 20);
  static const wb80B28 = TextStyle(
      fontFamily: font,
      color: ColorConstant.whiteBlack80,
      fontWeight: AppFontWeight.bold,
      fontSize: 28);
  static const wb90L16 = TextStyle(
      fontFamily: font,
      color: ColorConstant.whiteBlack90,
      fontWeight: AppFontWeight.light,
      fontSize: 16);
  static const wb90L18 = TextStyle(
      fontFamily: font,
      color: ColorConstant.whiteBlack90,
      fontWeight: AppFontWeight.light,
      fontSize: 18);

  // orange
  static const orange40SemiB16 = TextStyle(
      fontFamily: font,
      fontWeight: AppFontWeight.semiBold,
      color: ColorConstant.orange40,
      fontSize: 16.0);
  static const orange40SemiB18 = TextStyle(
      fontFamily: font,
      fontWeight: AppFontWeight.semiBold,
      color: ColorConstant.orange40,
      fontSize: 18.0);
  static const orange40B16 = TextStyle(
      fontFamily: font,
      fontWeight: AppFontWeight.bold,
      color: ColorConstant.orange40,
      fontSize: 16.0);
  static const orange50R16 = TextStyle(
      fontFamily: font,
      fontWeight: AppFontWeight.medium,
      fontSize: 16,
      color: ColorConstant.orange50);
  static const orange50B16 = TextStyle(
      fontFamily: font,
      fontWeight: AppFontWeight.bold,
      color: ColorConstant.orange50,
      fontSize: 16.0);
  static const orange70SemiB28 = TextStyle(
      fontFamily: font,
      color: ColorConstant.orange70,
      fontSize: 28,
      fontWeight: AppFontWeight.semiBold);
  static const orange70B32 = TextStyle(
      fontFamily: font,
      color: ColorConstant.orange70,
      fontSize: 32,
      fontWeight: AppFontWeight.bold);
  static const orange90Md12 = TextStyle(
      fontFamily: font,
      color: ColorConstant.orange90,
      fontSize: 12,
      fontWeight: AppFontWeight.medium);
  static const orange90Md14 = TextStyle(
      fontFamily: font,
      color: ColorConstant.orange90,
      fontSize: 14,
      fontWeight: AppFontWeight.medium);
  static const orange90SemiB40 = TextStyle(
      fontFamily: font,
      color: ColorConstant.orange90,
      fontSize: 40,
      fontWeight: AppFontWeight.semiBold);
  static const orange90B28 = TextStyle(
      fontFamily: font,
      color: ColorConstant.orange90,
      fontSize: 28,
      fontWeight: AppFontWeight.bold);
  static const orange90B36 = TextStyle(
      fontFamily: font,
      fontWeight: AppFontWeight.bold,
      color: ColorConstant.orange90,
      fontSize: 36);

  // red
  static const red40R14 = TextStyle(
      fontFamily: font,
      fontWeight: AppFontWeight.medium,
      color: ColorConstant.red40,
      fontSize: 14);

  // blue
  static const blue90B36 = TextStyle(
      fontFamily: font,
      fontWeight: AppFontWeight.bold,
      color: ColorConstant.blue90,
      fontSize: 36);
  static const blue90B28 = TextStyle(
      fontFamily: font,
      color: ColorConstant.blue90,
      fontSize: 28,
      fontWeight: AppFontWeight.bold);
}

extension AppFontWeight on FontWeight {
  static const light = FontWeight.w300;
  static const regular = FontWeight.w400;
  static const medium = FontWeight.w500;
  static const semiBold = FontWeight.w600;
  static const bold = FontWeight.w700;
}
