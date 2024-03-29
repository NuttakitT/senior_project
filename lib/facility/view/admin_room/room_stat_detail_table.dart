import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:senior_project/assets/color_constant.dart';
import 'package:senior_project/assets/font_style.dart';
import 'package:senior_project/core/template/template_desktop/view/page/template_desktop.dart';
import 'package:senior_project/facility/model/facility_model.dart';
import 'package:senior_project/facility/view/widget/facility_header.dart';
import 'package:senior_project/facility/view_model/facility_view_model.dart';

class RoomStatDetailView extends StatefulWidget {
  final List<RoomReservation> res;
  const RoomStatDetailView({super.key, required this.res});

  @override
  State<RoomStatDetailView> createState() => _RoomStatDetailViewState();
}

class _RoomStatDetailViewState extends State<RoomStatDetailView> {
  @override
  Widget build(BuildContext context) {
    return TemplateDesktop(
        helpdesk: false,
        helpdeskadmin: false,
        home: true,
        useTemplatescroll: true,
        content: Column(
          children: [
            const FacilityHeader(
              title: "Room Statistical Section",
              canPop: true,
            ),
            RoomStatDetailTable(widget: widget),
          ],
        ));
  }
}

class RoomStatDetailTable extends StatefulWidget {
  const RoomStatDetailTable({
    Key? key,
    required this.widget,
  }) : super(key: key);

  final RoomStatDetailView widget;

  @override
  State<RoomStatDetailTable> createState() => _RoomStatDetailTableState();
}

class _RoomStatDetailTableState extends State<RoomStatDetailTable> {
  int number = 1;

  String dateFormat(DateTime? date) {
    if (date == null) {
      return "";
    }
    return DateFormat('HH:mm').format(date);
  }

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
            0: FixedColumnWidth(120),
            1: FixedColumnWidth(220),
            2: FixedColumnWidth(300),
            3: FlexColumnWidth(),
            4: FixedColumnWidth(100),
            5: FixedColumnWidth(100),
          },
          children: [
            buildRow([
              Consts.room,
              Consts.user,
              Consts.email,
              Consts.purpose,
              Consts.startTime,
              Consts.endTime
            ], true, false),
            for (int i = 0; i < widget.widget.res.length; i++) ...[
              buildRow([
                "${widget.widget.res[i].room}",
                "isDes ${widget.widget.res[i].userId}",
                "isDes ${widget.widget.res[i].email}",
                widget.widget.res[i].purpose,
                dateFormat(widget.widget.res[i].bookTime),
                dateFormat(
                    widget.widget.res[i].bookTime), // Fix here (room-stat)
              ], false, i == widget.widget.res.length - 1),
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: cell.contains("isDes") ? 200 : null,
                child: Text(
                  cell.contains("isDes") ? cell.split("isDes ")[1] : cell,
                  style: isHeader ? AppFontStyle.wb80B20 : AppFontStyle.wb80R20,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                ),
              ),
            ],
          ),
        );
      }).toList());
}

class Consts {
  static String room = "รหัสห้อง";
  static String user = "ชื่อ";
  static String email = "อีเมล";
  static String startTime = "เริ่ม";
  static String endTime = "สิ้นสุด";
  static String purpose = "เหตุผล";
}
