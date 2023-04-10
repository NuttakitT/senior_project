import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senior_project/help_desk/help_desk_main/view/desktop/content_loader/content.dart';
import 'package:senior_project/help_desk/help_desk_main/view_model/help_desk_view_model.dart';

class GenerateContent {
  static List<Widget> generateContent(BuildContext context, List<Map<String, dynamic>> details, double contentSize) {
    List<Widget> list = [];
    for (int i = 0; i < details.length; i++) {
      list.add(
        Content(size: contentSize, 
          detail: details[i], 
          index: i + context.read<HelpDeskViewModel>().getStartTicket!.toInt(),
        )
      );
    }
    return list;
  }
}