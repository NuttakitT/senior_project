import 'package:flutter/material.dart';
import 'package:senior_project/assets/color_constant.dart';

class BackPlateWidgetDesktop {
  static Widget widget(BuildContext context, Map<String, double> size, Widget child) {
    return Container(
      width: size["width"] as double,
      height: size["height"] as double,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: ColorConstant.orange70),
        borderRadius: const BorderRadius.all(Radius.circular(16))
      ),
      child: child, 
    );
  }
}