import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senior_project/assets/color_constant.dart';
import 'package:senior_project/assets/font_style.dart';
import 'package:senior_project/core/template/template_desktop/view/page/template_desktop.dart';
import 'package:senior_project/core/template/template_mobile/view/template_menu_mobile.dart';
import 'package:senior_project/core/view_model/app_view_model.dart';
import 'package:senior_project/facility/model/facility_model.dart';
import 'package:senior_project/facility/view/my_booking/my_booking.dart';
import 'package:senior_project/facility/view/my_booking/schedule_booking.dart';
import 'package:senior_project/facility/view/room_reservation/radio_form.dart';
import 'package:senior_project/facility/view/widget/facility_header.dart';
import 'package:senior_project/facility/view/widget/facility_header_mobile.dart';
import 'package:senior_project/facility/view_model/facility_view_model.dart';

class ScheduleRoomView extends StatefulWidget {
  const ScheduleRoomView({super.key});

  @override
  State<ScheduleRoomView> createState() => _ScheduleRoomViewState();
}

class _ScheduleRoomViewState extends State<ScheduleRoomView> {
  bool isMobileSite = kIsWeb &&
      (defaultTargetPlatform == TargetPlatform.iOS ||
          defaultTargetPlatform == TargetPlatform.android);

  @override
  Widget build(BuildContext context) {
    if (isMobileSite) {
      return TemplateMenuMobile(
          content: Column(
        children: const [
          FacilityHeaderMobile(title: "Room Scheduler"),
          ScheduleRoomForm()
        ],
      ));
    } else {
      return TemplateDesktop(
          helpdesk: false,
          helpdeskadmin: false,
          home: true,
          useTemplatescroll: true,
          content: Column(
            children: const [
              FacilityHeader(title: "Room Scheduler", canPop: false,),
              ScheduleRoomForm()
            ],
          ));
    }
  }
}

class ScheduleRoomForm extends StatefulWidget {
  const ScheduleRoomForm({super.key});

  @override
  State<ScheduleRoomForm> createState() => _ScheduleRoomFormState();
}

class _ScheduleRoomFormState extends State<ScheduleRoomForm> {
  int? selectedDayOfWeek;
  DateTime? _startTime;
  DateTime? _endTime;

  bool isReserveButtonEnabled() {
    if (selectedDayOfWeek != null && _startTime != null && _endTime != null) {
      return true;
    }
    return false;
  }

  String _formatTimeRange(TimeOfDay startTime) {
    final formattedStartTime = startTime.format(context);
    return formattedStartTime;
  }

  Future<void> _selectStartTime(BuildContext context) async {
    const int startHour = 9; // Start hour (24-hour format)
    const int endHour = 21; // End hour (24-hour format)

    final List<TimeOfDay> availableTimes = [];
    for (int hour = startHour; hour <= endHour; hour++) {
      final TimeOfDay time = TimeOfDay(hour: hour, minute: 00);
      availableTimes.add(time);
      late final TimeOfDay time30;
      if (hour != endHour) {
        time30 = TimeOfDay(hour: hour, minute: 30);
        availableTimes.add(time30);
      } 
    }

    final TimeOfDay? pickedTime = await showDialog<TimeOfDay>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select Time'),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: availableTimes.length,
              itemBuilder: (BuildContext context, int index) {
                final TimeOfDay time = availableTimes[index];
                final String timeText = time.format(context);
                return ListTile(
                  title: Text(timeText),
                  onTap: () {
                    Navigator.of(context).pop(time);
                  },
                );
              },
            ),
          ),
        );
      },
    );

    if (pickedTime != null) {
      final DateTime selectedDateTime = DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
        pickedTime.hour,
        pickedTime.minute,
      );

      setState(() {
        _startTime = selectedDateTime;
        if (_startTime!.hour == 21) {
          setState(() {
            _endTime = DateTime(
              DateTime.now().year,
              DateTime.now().month,
              DateTime.now().day,
              21,
              30,
            );
          });
        }
      });
    }
  }

  Future<void> _selectEndTime(BuildContext context) async {
    if (_startTime == null || _startTime!.hour == 21)  {
      if (_startTime!.hour == 21) {
        setState(() {
          _endTime = DateTime(
            DateTime.now().year,
            DateTime.now().month,
            DateTime.now().day,
            21,
            30,
          );
        });
      }
      return;
    }
    final int startHour = _startTime!.hour + 1; // Start hour (24-hour format)
    const int endHour = 17; // End hour (24-hour format)

    final List<TimeOfDay> availableTimes = [];
    for (int hour = startHour; hour <= endHour; hour++) {
      final TimeOfDay time = TimeOfDay(hour: hour, minute: 00);
      final TimeOfDay time30 = TimeOfDay(hour: hour, minute: 30);
      availableTimes.add(time);
      availableTimes.add(time30);
    }

    final TimeOfDay? pickedTime = await showDialog<TimeOfDay>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select Time'),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: availableTimes.length,
              itemBuilder: (BuildContext context, int index) {
                final TimeOfDay time = availableTimes[index];
                final String timeText = time.format(context);
                return ListTile(
                  title: Text(timeText),
                  onTap: () {
                    Navigator.of(context).pop(time);
                  },
                );
              },
            ),
          ),
        );
      },
    );

    if (pickedTime != null) {
      final DateTime selectedDateTime = DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
        pickedTime.hour,
        pickedTime.minute,
      );

      setState(() {
        _endTime = selectedDateTime;
      });
    }
  }

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

  @override
  Widget build(BuildContext context) {
    bool isMobileSite = kIsWeb &&
        (defaultTargetPlatform == TargetPlatform.iOS ||
            defaultTargetPlatform == TargetPlatform.android);

    const mobilePadding = EdgeInsets.only(left: 12, right: 12, bottom: 24);
    const desktopPadding = EdgeInsets.only(left: 64, right: 64, bottom: 24);

    const mobileBoxPadding =
        EdgeInsets.only(top: 16, left: 4, right: 4, bottom: 24);
    const desktopBoxPadding =
        EdgeInsets.only(top: 24, left: 16, right: 16, bottom: 24);
    return Padding(
      padding: isMobileSite ? mobilePadding : desktopPadding,
      child: Container(
        padding: isMobileSite ? mobileBoxPadding : desktopBoxPadding,
        decoration: BoxDecoration(
            color: ColorConstant.white, borderRadius: BorderRadius.circular(8)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const SizedBox(width: 1),
                Expanded(
                  child: SizedBox(
                    height: isMobileSite ? 36 : 40,
                    child: TextButton(
                      onPressed: () async {
                        Navigator.push(context,
                            MaterialPageRoute(builder: ((context) {
                          return const ScheduleBooking();
                        })));
                      },
                      style: TextButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          foregroundColor: ColorConstant.white,
                          padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                          backgroundColor: ColorConstant.orange40,
                          textStyle: TextStyle(
                              fontSize: isMobileSite ? 16 : 20,
                              fontWeight: AppFontWeight.regular)),
                      child: Text('ไปยังการลงเวลาห้องเรียน',
                          style: isMobileSite
                              ? AppFontStyle.whiteB16
                              : AppFontStyle.whiteSemiB20),
                    ),
                  ),
                ),
              ],
            ),
            // Room
            const SizedBox(height: 16),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: isMobileSite ? 1 : 1,
                  child: DefaultTextStyle(
                    style: isMobileSite
                        ? AppFontStyle.wb80R16
                        : AppFontStyle.wb80R24,
                    child: const Text("Room"),
                  ),
                ),
                SizedBox(width: isMobileSite ? 8 : 16),
                Expanded(
                    flex: isMobileSite ? 3 : 6,
                    child: FutureBuilder(
                        future: context.read<FacilityViewModel>().getAllRooms(),
                        builder: (context, snapshot) {
                          final rooms = snapshot.data ?? [];
                          if (rooms.isEmpty) {
                            return SizedBox(
                              height: isMobileSite ? 80 : 120,
                              child: const Center(
                                child: DefaultTextStyle(
                                  style: AppFontStyle.wb40R16,
                                  child:
                                      Text("No room available at this time."),
                                ),
                              ),
                            );
                          }
                          return RadioForm(rooms: rooms, onPressed: (rooms) {});
                        })),
              ],
            ),
            Row(
              children: [
                Expanded(
                  flex: isMobileSite ? 1 : 1,
                  child: SizedBox(
                    child: DefaultTextStyle(
                      style: isMobileSite
                          ? AppFontStyle.wb80R16
                          : AppFontStyle.wb80R24,
                      child: const Text("Day"),
                    ),
                  ),
                ),
                SizedBox(width: isMobileSite ? 8 : 16),
                Expanded(
                    flex: isMobileSite ? 3 : 6,
                    child: DropdownButton<int>(
                      isExpanded: true,
                      value: selectedDayOfWeek,
                      icon: const Icon(Icons.arrow_downward),
                      elevation: 16,
                      underline: Container(
                        height: 2,
                        color: Colors.deepPurpleAccent,
                      ),
                      onChanged: (int? value) {
                        setState(() {
                          selectedDayOfWeek = value;
                        });
                      },
                      items: List.generate(7, (index) {
                        int dayOfWeekValue = index + 1;
                        String dayOfWeekName =
                            _getDayOfWeekName(dayOfWeekValue);
                        return DropdownMenuItem<int>(
                          value: dayOfWeekValue,
                          child: Text(dayOfWeekName),
                        );
                      }),
                    ))
              ],
            ),
            // Time
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  flex: isMobileSite ? 1 : 1,
                  child: SizedBox(
                    child: DefaultTextStyle(
                      style: isMobileSite
                          ? AppFontStyle.wb80R16
                          : AppFontStyle.wb80R24,
                      child: const Text("From time"),
                    ),
                  ),
                ),
                SizedBox(width: isMobileSite ? 8 : 16),
                Expanded(
                  flex: isMobileSite ? 3 : 6,
                  child: GestureDetector(
                    onTap: () {
                      _selectStartTime(context);
                      if (_startTime != null) {
                        // Call room loader
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: ColorConstant.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: ColorConstant.whiteBlack20),
                      ),
                      child: Text(
                        _startTime != null
                            ? _formatTimeRange(
                                TimeOfDay.fromDateTime(_startTime!))
                            : 'time',
                      ),
                    ),
                  ),
                ),
              ],
            ),
            // To time
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  flex: isMobileSite ? 1 : 1,
                  child: SizedBox(
                    child: DefaultTextStyle(
                      style: isMobileSite
                          ? AppFontStyle.wb80R16
                          : AppFontStyle.wb80R24,
                      child: const Text("To time"),
                    ),
                  ),
                ),
                SizedBox(width: isMobileSite ? 8 : 16),
                Expanded(
                  flex: isMobileSite ? 3 : 6,
                  child: GestureDetector(
                    onTap: () {
                      _selectEndTime(context);
                      if (_startTime != null) {
                        // Call room loader
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: ColorConstant.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: ColorConstant.whiteBlack20),
                      ),
                      child: Text(
                        _endTime != null
                            ? _formatTimeRange(
                                TimeOfDay.fromDateTime(_endTime!))
                            : 'time',
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(width: isMobileSite ? 8 : 24),
            Row(
              children: [
                const SizedBox(width: 1),
                Expanded(
                  child: SizedBox(
                    height: isMobileSite ? 36 : 40,
                    child: TextButton(
                      onPressed: () async {
                        if (isReserveButtonEnabled()) {
                          final request = Schedule(
                              roomName: "",
                              dayOfWeek: selectedDayOfWeek!,
                              startTime: _startTime!,
                              endTime: _endTime!);
                          await context
                              .read<FacilityViewModel>()
                              .scheduleRoom(request);
                          if (isMobileSite) {
                            Navigator.pop(context);
                          } else {
                            Navigator.push(context,
                                MaterialPageRoute(builder: ((context) {
                              return const ScheduleBooking();
                            })));
                          }
                        }
                      },
                      style: TextButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          foregroundColor: ColorConstant.white,
                          padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                          backgroundColor: ColorConstant.orange40,
                          textStyle: TextStyle(
                              fontSize: isMobileSite ? 16 : 20,
                              fontWeight: AppFontWeight.regular)),
                      child: Text('Schedule Room',
                          style: isMobileSite
                              ? AppFontStyle.whiteB16
                              : AppFontStyle.whiteSemiB20),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
