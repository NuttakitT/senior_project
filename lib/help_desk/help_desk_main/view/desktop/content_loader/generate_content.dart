import 'package:flutter/material.dart';
import 'package:senior_project/help_desk/help_desk_main/view/desktop/content.dart';

class GenerateContent {
  static List<Widget> generateContent(List<Map<String, dynamic>> details, double contentSize) {
    List<Widget> list = [];
    for (int i = 0; i < details.length; i++) {
      list.add(Content(size: contentSize, detail: details[i], index: i,));
    }
    return list;
  }
}