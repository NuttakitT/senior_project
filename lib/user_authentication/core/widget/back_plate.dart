import 'package:flutter/material.dart';
import 'package:senior_project/assets/constant.dart';

class BackPlateWidget {
  static Widget widget(Widget child) {
    return Container(
      width: 502,
      height: 739,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      decoration: BoxDecoration(
        color: Constant.orange5,
        border: Border.all(color: Constant.orange70),
        borderRadius: const BorderRadius.all(Radius.circular(16))
      ),
      child: child,
    );
  }
}