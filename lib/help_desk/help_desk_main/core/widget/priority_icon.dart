import 'package:flutter/material.dart';

class PriorityIcon {
  static IconData getIcon(int priority) {
    switch (priority) {
      case 0:
        return Icons.keyboard_arrow_down_rounded;
      case 1:
        return Icons.remove_rounded;
      case 2: 
        return Icons.keyboard_arrow_up_rounded;
      default:
        return Icons.keyboard_double_arrow_up_rounded;
    }
  }
}