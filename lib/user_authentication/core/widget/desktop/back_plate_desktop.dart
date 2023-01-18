import 'package:flutter/material.dart';
import 'package:senior_project/assets/constant.dart';

// TODO check size when has templete
class BackPlateWidgetDesktop {
  static Widget widget(BuildContext context, Widget child) {
    return Container(
      width: 502,
      height: MediaQuery.of(context).size.height * 0.83,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
      decoration: BoxDecoration(
        color: Constant.orange5,
        border: Border.all(color: Constant.orange70),
        borderRadius: const BorderRadius.all(Radius.circular(16))
      ),
      child: SingleChildScrollView(child: child), 
    );
  }
}