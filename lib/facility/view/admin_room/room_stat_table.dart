import 'package:flutter/material.dart';
import 'package:senior_project/assets/color_constant.dart';
import 'package:senior_project/assets/font_style.dart';
import 'package:senior_project/facility/model/facility_model.dart';
import 'package:senior_project/facility/view/admin_room/room_stat_by_month.dart';

class RoomStatTable extends StatefulWidget {
  final List<RoomStatNewModel> months;
  const RoomStatTable({super.key, required this.months});

  @override
  State<RoomStatTable> createState() => _RoomStatTableState();
}

class _RoomStatTableState extends State<RoomStatTable> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RoomStatDetailTable(widget: widget),
      ],
    );
  }
}

class RoomStatDetailTable extends StatefulWidget {
  const RoomStatDetailTable({
    Key? key,
    required this.widget,
  }) : super(key: key);

  final RoomStatTable widget;

  @override
  State<RoomStatDetailTable> createState() => _RoomStatDetailTableState();
}

class _RoomStatDetailTableState extends State<RoomStatDetailTable> {
  int number = 1;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(64, 0, 64, 16),
      child: Container(
        decoration: BoxDecoration(
            color: ColorConstant.white,
            borderRadius: BorderRadius.circular(16)),
        child: Table(
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          columnWidths: const {0: FixedColumnWidth(280), 1: FlexColumnWidth()},
          children: [
            buildRow([Consts.room, Consts.amount], true, false, null, context),
            for (int i = 0; i < widget.widget.months.length; i++) ...[
              buildRow([
                widget.widget.months[i].monthAndYearLabel,
                "${widget.widget.months[i].amount} ครั้ง"
              ], false, i == widget.widget.months.length - 1,
                  widget.widget.months[i].reservations, context),
            ]
          ],
        ),
      ),
    );
  }
}

TableRow buildRow(List<String> cells, bool isHeader, bool isLastIndex,
    List<RoomReservation>? res, BuildContext context) {
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
        return Padding(
          padding: const EdgeInsets.only(left: 16, top: 28, bottom: 28),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: cell.contains("isDes") ? 700 : null,
                child: Text(
                  cell.contains("isDes") ? cell.split("isDes ")[1] : cell,
                  style: isHeader ? AppFontStyle.wb80B20 : AppFontStyle.wb80R20,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (!isHeader &&
                  cell == cells.last) // Add the button only for non-header rows
                TextButton(
                  onPressed: () {
                    if (res != null) {
                      Navigator.push(context,
                          MaterialPageRoute(builder: ((context) {
                        return RoomStatByMonthView(res: res);
                      })));
                    }
                    // Handle button press
                  },
                  child: const Icon(
                    Icons.arrow_forward_ios,
                    color: ColorConstant.whiteBlack60,
                  ),
                ),
            ],
          ),
        );
      }).toList());
}

class Consts {
  static String listCategoryLabel = "List Category";
  static String addCategory = "Add Category";

  static String room = "เดือน";
  static String roomCat = "ประเภท";
  static String amount = "จำนวนการจอง";
}
