// ignore_for_file: use_build_context_synchronously

import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senior_project/assets/font_style.dart';
import 'package:senior_project/core/template/template_desktop/view/widget/desktop/confirmation_popup.dart';
import 'package:senior_project/facility/model/facility_model.dart';
import 'package:senior_project/facility/view/schedule/schedule_room.dart';
import 'package:senior_project/facility/view_model/facility_view_model.dart';

class ScheduleCardView extends StatefulWidget {
  final Schedule cardDetail;
  const ScheduleCardView({super.key, required this.cardDetail});

  @override
  State<ScheduleCardView> createState() => _ScheduleCardViewState();
}

class _ScheduleCardViewState extends State<ScheduleCardView> {
  String _getDayOfWeekName(int dayOfWeek) {
    switch (dayOfWeek) {
      case 1:
        return 'Monday';
      case 2:
        return 'Tuesday';
      case 3:
        return 'Wednesday';
      case 4:
        return 'Thursday';
      case 5:
        return 'Friday';
      case 6:
        return 'Saturday';
      case 7:
        return 'Sunday';
      default:
        return '';
    }
  }

  String _formatTimeRange(TimeOfDay startTime) {
    final formattedStartTime = startTime.format(context);
    return formattedStartTime;
  }

  @override
  Widget build(BuildContext context) {
    print(widget.cardDetail.id);
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BookCardViewCell(
            title: "ห้องเรียน", detail: widget.cardDetail.roomName),
        BookCardViewCell(
            title: "ทุกวัน",
            detail: _getDayOfWeekName(widget.cardDetail.dayOfWeek)),
        BookCardViewCell(
            title: "from",
            detail: _formatTimeRange(
                TimeOfDay.fromDateTime(widget.cardDetail.startTime))),
        BookCardViewCell(
            title: "to",
            detail: _formatTimeRange(
                TimeOfDay.fromDateTime(widget.cardDetail.endTime))),
        // BookCardViewCell(title: "Status", detail: "${itemCard?.status}"),
        Row(
          children: [
            Expanded(
              child: TextButton(
                  onPressed: () async {
                    showDialog(
                      context: context, 
                      builder: (context) {
                        return ConfirmationPopup(
                          title: "Are you sure to delete this schedule?",
                          detail: "This actoion can't be undone",
                          widget: null,
                          onCancel: () {
                            Navigator.pop(context);
                          },
                          onConfirm: () async {
                            if (widget.cardDetail.id != null) {
                            await context
                                .read<FacilityViewModel>()
                                .deleteSchedule(widget.cardDetail.id!);
                            Navigator.pushAndRemoveUntil(
                              context, 
                              MaterialPageRoute(
                                builder: (context) {
                                  return const ScheduleRoomView();
                                }
                              ), 
                              (route) => false
                            );
                          }
                          },
                        );
                      }
                    );
                  },
                  child: const DefaultTextStyle(
                    style: AppFontStyle.red40R16,
                    child: Text("Cancel schedule", textAlign: TextAlign.end),
                  )),
            ),
          ],
        )
      ],
    );
  }
}

class BookCardViewCell extends StatelessWidget {
  final String title;
  final String detail;
  const BookCardViewCell({Key? key, required this.title, required this.detail})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isMobileSite = kIsWeb &&
        (defaultTargetPlatform == TargetPlatform.iOS ||
            defaultTargetPlatform == TargetPlatform.android);
    return Column(
      children: [
        const SizedBox(height: 4),
        Row(
          children: [
            Expanded(
                flex: isMobileSite ? 2 : 1,
                child: DefaultTextStyle(
                    style: isMobileSite
                        ? AppFontStyle.wb80R16
                        : AppFontStyle.wb80R20,
                    child: Text(title))),
            Expanded(
                flex: isMobileSite ? 5 : 7,
                child: DefaultTextStyle(
                    style: isMobileSite
                        ? AppFontStyle.wb60Md16
                        : AppFontStyle.wb60Md20,
                    child: Text(detail))),
          ],
        ),
        const SizedBox(height: 4),
      ],
    );
  }
}
