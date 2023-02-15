import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:senior_project/assets/color_constant.dart';
import 'package:senior_project/help_desk/help_desk_main/assets/status_color.dart';
import 'package:senior_project/help_desk/help_desk_main/core/widget/priority_icon.dart';
import 'package:senior_project/help_desk/help_desk_main/view_model/help_desk_view_model.dart';

class HelpDeskCardWidget {
  final Map<String, dynamic> card;
  final BuildContext context;
  const HelpDeskCardWidget({required this.card, required this.context});
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
      fontWeight: FontWeight.w500,
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
      fontSize: 14.0);
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

  Widget widget() {
    String priority = context.watch<HelpDeskViewModel>().convertToString(false, card["priority"]);
    List<Color> statusColor = StatusColor.getColor(false, card["status"]);
    String time = DateFormat('d/MM/yyyy H:mm').format(card["time"]);

    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  color: const Color(0xFFF3F3F3),
                  border:
                      Border(left: BorderSide(color: statusColor[2], width: 5.0))),
              child: Table(
                columnWidths: const <int, TableColumnWidth>{
                  0: FixedColumnWidth(120),
                  1: FlexColumnWidth(),
                  2: FixedColumnWidth(250)
                },
                children: <TableRow>[
                  TableRow(children: <Widget>[
                    TableCell(
                        verticalAlignment: TableCellVerticalAlignment.middle,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 24.0, bottom: 8.0, left: 16),
                          child: Container(
                            alignment: Alignment.centerRight,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: const Color(0xFFDADBDC), width: 2.0),
                                borderRadius: BorderRadius.circular(8.0),
                                color: Colors.white),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(16, 6, 16, 6),
                              child: Center(
                                child: DefaultTextStyle(
                                    style: priorityTextStyle(),
                                    child: Row(
                                      children: [
                                        Icon(PriorityIcon.getIcon(card["priority"]), size: 16,),
                                        const Spacer(),
                                        Text(priority),
                                      ],
                                    )),
                              ),
                            ),
                          ),
                        )),
                    TableCell(
                        verticalAlignment: TableCellVerticalAlignment.middle,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 24.0, left: 16.0),
                          child: RichText(
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: "${card["taskHeader"]} ",
                                    style: titleDetailTextStyle(),
                                  ),
                                  TextSpan(
                                    text: "#${card["id"][1]}${card["id"][2]}${card["id"][card["id"].length-1]}",
                                    style: const TextStyle(
                                      fontFamily: ColorConstant.font,
                                      fontWeight: FontWeight.w400,
                                      color: ColorConstant.whiteBlack60,
                                      fontSize: 20
                                    )
                                  )
                                ]
                              ),
                            ),
                        )),
                    TableCell(
                        verticalAlignment: TableCellVerticalAlignment.middle,
                        child: Container(
                          alignment: Alignment.centerRight,
                          padding: const EdgeInsets.only(top: 24.0, right: 16.0),
                          child: DefaultTextStyle(
                              style: timeTextStyle(),
                              child: Text("Time $time")),
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
                          top: 8.0, bottom: 8.0, left: 16.0),
                      child: DefaultTextStyle(
                          style: categoryTextStyle(),
                          child: Text(card["category"])),
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
                            top: 8.0, left: 14.0, right: 8.0, bottom: 24.0),
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: const Color(0xFFDADBDC), width: 2.0),
                              borderRadius: BorderRadius.circular(8.0),
                              color: Colors.white),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(8, 16, 8, 16),
                            child: RichText(
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: card["taskDetail"],
                                    style: detailTextStyle()
                                  )
                                ]
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    TableCell(
                      verticalAlignment: TableCellVerticalAlignment.bottom,
                      child: Container(
                        padding: const EdgeInsets.only(
                            left: 16, bottom: 24.0, right: 16.0),
                        height: 56.0,
                        child: TextButton(
                          onPressed: () {
                            // TODO: - reply channel
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
