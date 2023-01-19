import 'package:flutter/material.dart';
import 'package:senior_project/assets/constant.dart';

// TODO check size when has templete
class BackPlateWidgetDesktop {
  static Widget widget(BuildContext context, Map<String, double> size, Widget child) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: size["height"] as double,
        maxWidth:  size["width"] as double
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
        decoration: BoxDecoration(
          color: Constant.orange5,
          border: Border.all(color: Constant.orange70),
          borderRadius: const BorderRadius.all(Radius.circular(16))
        ),
        child: SingleChildScrollView(child: child), // TODO check scrollable again w/ templete
      ),
    );
  }
}