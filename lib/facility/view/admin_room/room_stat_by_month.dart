import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:senior_project/assets/color_constant.dart';
import 'package:senior_project/assets/font_style.dart';
import 'package:senior_project/core/template/template_desktop/view/page/template_desktop.dart';
import 'package:senior_project/facility/model/facility_model.dart';
import 'package:senior_project/facility/view/widget/facility_header.dart';
import 'package:collection/collection.dart';

class RoomStatByMonthView extends StatefulWidget {
  final List<RoomReservation> res;
  const RoomStatByMonthView({super.key, required this.res});

  @override
  State<RoomStatByMonthView> createState() => _RoomStatByMonthViewState();
}

class _RoomStatByMonthViewState extends State<RoomStatByMonthView> {
  String dayFormat(DateTime? date) {
    if (date == null) {
      return "";
    }
    return DateFormat('d MMMM yyyy').format(date);
  }

  @override
  Widget build(BuildContext context) {
    Map<DateTime, List<RoomReservation>> reservationsByDay =
        groupBy(widget.res, (reservation) {
      DateTime bookTime = reservation.bookTime;
      return DateTime(bookTime.year, bookTime.month, bookTime.day);
    });

    List<DateTime> sortedDays = reservationsByDay.keys.toList()
      ..sort((a, b) => a.day.compareTo(b.day));

    // Create table for each day

    return TemplateDesktop(
      helpdesk: false,
      helpdeskadmin: false,
      home: true,
      useTemplatescroll: true,
      content: Column(
        children: [
          const FacilityHeader(
              title: "รายงานการขอใช้ห้องเรียนรายวัน", canPop: true),
          SizedBox(
            height: MediaQuery.of(context).size.height - 70,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 24),
              child: ListView.builder(
                  itemCount: sortedDays.length,
                  itemBuilder: (context, index) {
                    DateTime day = sortedDays[index];
                    List<RoomReservation> reservations =
                        reservationsByDay[day]!;
                    return Column(
                      children: [
                        FacilityHeader(title: dayFormat(day), canPop: false),
                        RoomStatByMonthTable(res: reservations)
                      ],
                    );
                  }),
            ),
          ),
        ],
      ),
    );
  }
}

class RoomStatByMonthTable extends StatefulWidget {
  final List<RoomReservation> res;
  const RoomStatByMonthTable({Key? key, required this.res}) : super(key: key);

  @override
  State<RoomStatByMonthTable> createState() => _RoomStatByMonthTableState();
}

class _RoomStatByMonthTableState extends State<RoomStatByMonthTable> {
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
            for (int i = 0; i < widget.res.length; i++) ...[
              buildRow([
                "${widget.res[i].room}",
                "isDes ${widget.res[i].userId}",
                "isDes ${widget.res[i].email}",
                "isDes ${widget.res[i].purpose}",
                dateFormat(widget.res[i].bookTime),
                dateFormat(widget.res[i].endTime),
              ], false, i == widget.res.length - 1),
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
