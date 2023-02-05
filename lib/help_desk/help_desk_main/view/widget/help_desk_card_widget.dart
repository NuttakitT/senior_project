import 'dart:html';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senior_project/assets/color_constant.dart';
import 'package:senior_project/help_desk/help_desk_main/model/help_desk_main_model.dart';

class HelpDeskCardWidget {
  final HelpDeskCard card;
  const HelpDeskCardWidget({required this.card});

  static Widget widget(BuildContext context, {required HelpDeskCard card}) {
    double screenWidth = MediaQuery.of(context).size.width;

    return ConstrainedBox(
      constraints: BoxConstraints(
          maxWidth: double.infinity, maxHeight: 700, minHeight: 152),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            width: 5,
            height: double.infinity,
            child: DecoratedBox(
              decoration: BoxDecoration(color: Colors.red),
            ),
          ),
          SizedBox(
            width: screenWidth,
            height: double.infinity,
            child: Container(
              decoration: BoxDecoration(color: Color(0xFFF3F3F3)),
              child: Table(
                columnWidths: const <int, TableColumnWidth>{
                  0: FixedColumnWidth(120),
                  1: FlexColumnWidth(),
                  2: FixedColumnWidth(240)
                },
                children: const <TableRow>[
                  TableRow(children: <Widget>[
                    TableCell(
                        child: DefaultTextStyle(
                            style: TextStyle(), child: Text("000000000"))),
                    TableCell(
                        child: DefaultTextStyle(
                            style: TextStyle(), child: Text("000000012"))),
                    TableCell(
                        child: DefaultTextStyle(
                            style: TextStyle(), child: Text("000000034"))),
                  ]),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
