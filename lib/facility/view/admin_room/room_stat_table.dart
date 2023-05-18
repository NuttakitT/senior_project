import 'package:flutter/material.dart';
import 'package:senior_project/assets/color_constant.dart';
import 'package:senior_project/assets/font_style.dart';
import 'package:senior_project/facility/model/facility_model.dart';

class RoomStatTable extends StatefulWidget {
  final List<RoomStatModel> rooms;
  const RoomStatTable({super.key, required this.rooms});

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
          columnWidths: const {
            0: FixedColumnWidth(200),
            1: FixedColumnWidth(320),
            2: FlexColumnWidth()
          },
          children: [
            buildRow([Consts.room, Consts.roomCat, Consts.amount], true, false),
            for (int i = 0; i < widget.widget.rooms.length; i++) ...[
              buildRow([
                widget.widget.rooms[i].roomName,
                widget.widget.rooms[i].roomCategory,
                "${widget.widget.rooms[i].amount} ครั้ง"
              ], false, i == widget.widget.rooms.length - 1),
            ]
          ],
        ),
      ),
    );
  }
}

TableRow buildRow(List<String> cells, bool isHeader, bool isLastIndex) {
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
                    print(cells.first); // Room CPE1111
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

  static String room = "รหัสห้อง";
  static String roomCat = "ประเภท";
  static String amount = "จำนวนการจอง";
}
