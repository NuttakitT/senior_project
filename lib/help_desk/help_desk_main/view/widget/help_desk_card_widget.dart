import 'dart:html';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senior_project/assets/color_constant.dart';
import 'package:senior_project/help_desk/help_desk_main/model/help_desk_main_model.dart';

class HelpDeskCardWidget {
  final HelpDeskCard card;
  const HelpDeskCardWidget({required this.card});
  static TextStyle titleTextStyle() => const TextStyle(
      fontFamily: ColorConstant.font,
      fontWeight: FontWeight.w200,
      color: Color(0xFF393E42),
      fontSize: 20.0);
  static TextStyle categoryTextStyle() => const TextStyle(
      fontFamily: ColorConstant.font,
      fontWeight: FontWeight.w400,
      color: Color(0xFF393E42),
      fontSize: 20.0);
  static TextStyle titleDetailTextStyle() => const TextStyle(
      fontFamily: ColorConstant.font,
      fontWeight: FontWeight.w400,
      color: Color(0xFF393E42),
      fontSize: 24.0);
  static TextStyle timeTextStyle() => const TextStyle(
      fontFamily: ColorConstant.font,
      fontWeight: FontWeight.w400,
      color: Color(0xFF393E42),
      fontSize: 18.0);
  static TextStyle priorityTextStyle() => const TextStyle(
      fontFamily: ColorConstant.font,
      fontWeight: FontWeight.w500,
      color: Color(0xFF6B6E71),
      fontSize: 16.0);
  static TextStyle detailTextStyle() => const TextStyle(
      fontFamily: ColorConstant.font,
      fontWeight: FontWeight.w400,
      color: Color(0xFF838689),
      fontSize: 16.0);
  static TextStyle messageButtonTextStyle() => const TextStyle(
      fontFamily: ColorConstant.font,
      fontWeight: FontWeight.w600,
      color: Color(0xFFFFFFFF),
      fontSize: 14.0);

  static Widget widget(BuildContext context, {required HelpDeskCard card}) {
    double screenWidth = MediaQuery.of(context).size.width;

    return ConstrainedBox(
      constraints: BoxConstraints(
          maxWidth: double.infinity, maxHeight: 300, minHeight: 152),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 5,
            height: double.infinity,
            child: DecoratedBox(
              decoration: BoxDecoration(color: Colors.red),
            ),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(color: Color(0xFFF3F3F3)),
              child: Table(
                // border: TableBorder.all(),
                columnWidths: const <int, TableColumnWidth>{
                  0: FixedColumnWidth(120),
                  1: FlexColumnWidth(),
                  2: FixedColumnWidth(240)
                },
                children: <TableRow>[
                  TableRow(children: <Widget>[
                    TableCell(
                        verticalAlignment: TableCellVerticalAlignment.middle,
                        child: Padding(
                          padding:
                              const EdgeInsets.only(top: 24.0, bottom: 8.0),
                          child: Container(
                            alignment: Alignment.centerRight,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: const Color(0xFFDADBDC), width: 2.0),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(16, 6, 16, 6),
                              child: Center(
                                child: DefaultTextStyle(
                                    style: priorityTextStyle(),
                                    child: Text(card.priority ?? "")),
                              ),
                            ),
                          ),
                        )),
                    TableCell(
                        verticalAlignment: TableCellVerticalAlignment.middle,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 24.0, left: 8.0),
                          child: DefaultTextStyle(
                              style: titleDetailTextStyle(),
                              child: Text(card.title ?? "")),
                        )),
                    TableCell(
                        verticalAlignment: TableCellVerticalAlignment.middle,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 24.0, left: 16.0),
                          child: DefaultTextStyle(
                              style: timeTextStyle(),
                              child: const Text("Time")),
                        )),
                  ]),
                  TableRow(children: <Widget>[
                    TableCell(
                        child: Padding(
                      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                      child: DefaultTextStyle(
                          style: titleTextStyle(),
                          child: const Text("Category: ",
                              textAlign: TextAlign.end)),
                    )),
                    TableCell(
                        child: Padding(
                      padding: const EdgeInsets.only(
                          top: 8.0, bottom: 8.0, left: 24.0),
                      child: DefaultTextStyle(
                          style: categoryTextStyle(),
                          child: Text(card.category ?? "")),
                    )),
                    TableCell(child: Container()),
                  ]),
                  TableRow(children: <Widget>[
                    TableCell(
                        child: Padding(
                      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                      child: DefaultTextStyle(
                          style: titleTextStyle(),
                          child:
                              const Text("Detail: ", textAlign: TextAlign.end)),
                    )),
                    TableCell(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 8.0, left: 14.0, right: 8.0, bottom: 8.0),
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: const Color(0xFFDADBDC), width: 2.0),
                              borderRadius: BorderRadius.circular(8.0),
                              color: Colors.white),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(8, 16, 8, 16),
                            child: DefaultTextStyle(
                                style: detailTextStyle(),
                                child: Text(card.detail ?? "")),
                          ),
                        ),
                      ),
                    ),
                    TableCell(
                      verticalAlignment: TableCellVerticalAlignment.bottom,
                      child: Container(
                        padding: const EdgeInsets.only(
                            left: 16, bottom: 8.0, right: 8.0),
                        height: 40.0,
                        child: TextButton(
                          onPressed: () {
                            // perform pop-up create Task
                          },
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  ColorConstant.orange40),
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8)))),
                          child: Text(
                            "Message",
                            style: messageButtonTextStyle(),
                          ),
                        ),
                      ),
                    ),
                  ])
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}