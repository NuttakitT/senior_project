import 'package:flutter/material.dart';
import 'package:senior_project/assets/color_constant.dart';
import 'package:senior_project/assets/font_style.dart';
import 'package:senior_project/statistic/model/statistic_model.dart';

class TicketComment extends StatefulWidget {
  final List<TicketCommentModel> ticketComment;
  const TicketComment({super.key, required this.ticketComment});

  @override
  State<TicketComment> createState() => _TicketCommentState();
}

class _TicketCommentState extends State<TicketComment> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: Container(
        height: 317,
        decoration: BoxDecoration(
            color: ColorConstant.white, borderRadius: BorderRadius.circular(8)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Table(
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              columnWidths: const {
                0: FixedColumnWidth(80),
                1: FixedColumnWidth(140),
                2: FlexColumnWidth(),
                3: FixedColumnWidth(80),
                4: FixedColumnWidth(100)
              },
              children: [
                buildRow([
                  Consts.ticketId,
                  Consts.title,
                  Consts.comments,
                  Consts.star,
                  Consts.date
                ], true, false),
                for (int i = 0; i < widget.ticketComment.length; i++) ...[
                  buildRow([
                    widget.ticketComment[i].ticketId,
                    widget.ticketComment[i].title,
                    widget.ticketComment[i].comment,
                    widget.ticketComment[i].stars,
                    widget.ticketComment[i].date
                  ], false, i == widget.ticketComment.length - 1),
                ]
              ],
            ),
          ),
        ),
      ),
    );
  }
}

TableRow buildRow(List<dynamic> cells, bool isHeader, bool isLastIndex) {
  return TableRow(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
              color: isLastIndex
                  ? Colors.transparent
                  : ColorConstant.whiteBlack20),
        ),
      ),
      children: cells.map((cell) {
        if (cell is String) {
          return Padding(
            padding: const EdgeInsets.only(left: 8, top: 8, bottom: 8),
            child: Text(
              cell,
              style: isHeader ? AppFontStyle.wb80B16 : AppFontStyle.wb80R16,
              overflow: TextOverflow.ellipsis,
            ),
          );
        } else if (cell is int) {
          return Padding(
            padding: const EdgeInsets.only(left: 8, top: 8, bottom: 8),
            child: Row(
              children: [
                const Icon(Icons.star, color: ColorConstant.yellow40),
                Text(
                  cell.toString(),
                  style: AppFontStyle.wb80R16,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          );
        } else {
          return Container();
        }
      }).toList());
}

class Consts {
  static String ticketId = "ID";
  static String title = "Title";
  static String comments = "Comments";
  static String star = "Star";
  static String date = "Date";
}
