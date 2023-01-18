import 'package:flutter/material.dart';
import 'package:senior_project/assets/constant.dart';

class SelectionIdicator {
  static Widget widget(bool isSelected) {
    return Container(
      width: 24,
      height: 24,
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        border: Border.all(
          color: Constant.orange40,
          width: 2
        )
      ),
      child: Container(
        width: 12,
        height: 12,
        decoration: BoxDecoration(
          color: isSelected ? Constant.orange40 : Colors.white,
          shape: BoxShape.circle
        ),
      ),
    );
  }
}