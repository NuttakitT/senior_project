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
import 'package:senior_project/facility/view/room_reservation/radio_form.dart';
import 'package:senior_project/facility/view/widget/facility_header.dart';
import 'package:senior_project/facility/view/widget/facility_header_mobile.dart';
import 'package:senior_project/facility/view_model/facility_view_model.dart';

class RoomReservationView extends StatefulWidget {
  const RoomReservationView({super.key});

  @override
  State<RoomReservationView> createState() => _RoomReservationViewState();
}

class _RoomReservationViewState extends State<RoomReservationView> {
  bool isMobileSite = kIsWeb &&
      (defaultTargetPlatform == TargetPlatform.iOS ||
          defaultTargetPlatform == TargetPlatform.android);

  @override
  Widget build(BuildContext context) {
    if (isMobileSite) {
      return TemplateMenuMobile(
          content: Builder(
            builder: (context) {
              bool isLogin = context.watch<AppViewModel>().isLogin;
              if (!isLogin) {
                return const Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Center(
                    child: Text(
                      "Please login to use the services",
                      style: TextStyle(
                          color: ColorConstant.orange60,
                          fontWeight: FontWeight.w400,
                          fontFamily: AppFontStyle.font,
                          fontSize: 18),
                    ),
                  ),
                );
              }
              return Column(
        children: const [
              FacilityHeaderMobile(title: "Room Reservation"),
              RoomReservationForm()
        ],
      );
            }
          ));
    } else {
      return TemplateDesktop(
          helpdesk: false,
          helpdeskadmin: false,
          home: true,
          useTemplatescroll: true,
          content: Builder(
            builder: (context) {
              bool isLogin = context.watch<AppViewModel>().isLogin;
              if (!isLogin) {
                return const Padding(
                  padding: EdgeInsets.only(top: 100),
                  child: Center(
                    child: Text(
                      "Please login to use the services",
                      style: TextStyle(
                          color: ColorConstant.orange60,
                          fontWeight: FontWeight.w400,
                          fontFamily: AppFontStyle.font,
                          fontSize: 24),
                    ),
                  ),
                );
              }
              return Column(
                children: const [
                  FacilityHeader(title: "Room Reservation", canPop: false,),
                  RoomReservationForm()
                ],
              );
            }
          ));
    }
  }
}

class RoomReservationForm extends StatefulWidget {
  const RoomReservationForm({super.key});

  @override
  State<RoomReservationForm> createState() => _RoomReservationFormState();
}

class _RoomReservationFormState extends State<RoomReservationForm> {
  DateTime? _date;
  DateTime? _time;
  TextEditingController textController = TextEditingController();

  bool isReserveButtonEnabled() {
    if (_date != null && _time != null && textController.text.isNotEmpty) {
      return true;
    }
    return false;
  }

  String _formatTimeRange(TimeOfDay startTime) {
    final endTime = startTime.replacing(hour: startTime.hour + 1);
    final formattedStartTime = startTime.format(context);
    final formattedEndTime = endTime.format(context);
    return '$formattedStartTime - $formattedEndTime';
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 7)),
      selectableDayPredicate: (DateTime day) {
        // Exclude Saturdays and Sundays
        if (day.weekday == DateTime.saturday ||
            day.weekday == DateTime.sunday) {
          return false;
        }
        return true;
      },
    );
    if (pickedDate != null && pickedDate != _date) {
      setState(() {
        _date = pickedDate;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    if (_date == null) return;
    const int interval = 60; // Interval in minutes
    const int startHour = 9; // Start hour (24-hour format)
    const int endHour = 17; // End hour (24-hour format)

    final List<TimeOfDay> availableTimes = [];
    for (int hour = startHour; hour <= endHour; hour++) {
      for (int minute = 0; minute < 60; minute += interval) {
        final TimeOfDay time = TimeOfDay(hour: hour, minute: minute);
        availableTimes.add(time);
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
        _time = selectedDateTime;
      });
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
            // Date Picker
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  flex: isMobileSite ? 1 : 1,
                  child: SizedBox(
                    child: DefaultTextStyle(
                      style: isMobileSite
                          ? AppFontStyle.wb80R16
                          : AppFontStyle.wb80R24,
                      child: const Text("Select date"),
                    ),
                  ),
                ),
                SizedBox(width: isMobileSite ? 8 : 16),
                Expanded(
                  flex: isMobileSite ? 3 : 6,
                  child: GestureDetector(
                    onTap: () {
                      _selectDate(context);
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
                        _date != null ? _date.toString().split(' ')[0] : 'Date',
                      ),
                    ),
                  ),
                ),
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
                      child: const Text("Select time"),
                    ),
                  ),
                ),
                SizedBox(width: isMobileSite ? 8 : 16),
                Expanded(
                  flex: isMobileSite ? 3 : 6,
                  child: GestureDetector(
                    onTap: () {
                      _selectTime(context);
                      if (_time != null) {
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
                        _time != null
                            ? _formatTimeRange(TimeOfDay.fromDateTime(_time!))
                            : 'Time in date',
                      ),
                    ),
                  ),
                ),
              ],
            ),
            // Purpose
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  flex: isMobileSite ? 1 : 1,
                  child: DefaultTextStyle(
                    style: isMobileSite
                        ? AppFontStyle.wb80R16
                        : AppFontStyle.wb80R24,
                    child: const Text("Purpose"),
                  ),
                ),
                SizedBox(width: isMobileSite ? 8 : 16),
                Expanded(
                  flex: isMobileSite ? 3 : 6,
                  child: TextField(
                    controller: textController,
                    onTap: () {},
                    decoration: const InputDecoration(
                      hintText: "Purpose",
                      hintStyle:
                          TextStyle(color: ColorConstant.black, fontSize: 14),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          borderSide:
                              BorderSide(color: ColorConstant.whiteBlack20)),
                    ),
                  ),
                ),
              ],
            ),
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
                    child: _date == null || _time == null
                        ? Container()
                        : FutureBuilder(
                            future: context
                                .read<FacilityViewModel>()
                                .getAvailableRoom(_date, _time),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState == ConnectionState.done) {
                                final rooms = snapshot.data ?? [];
                                if (rooms.isEmpty) {
                                  return SizedBox(
                                    height: isMobileSite ? 80 : 120,
                                    child: const Center(
                                      child: DefaultTextStyle(
                                        style: AppFontStyle.wb40R16,
                                        child: Text(
                                            "No room available at this time."),
                                      ),
                                    ),
                                  );
                                }
                                return RadioForm(
                                    rooms: rooms, onPressed: (rooms) {});
                              }
                              return const Text("Loading available room...");
                            })),
              ],
            ),
            if (_date == null || _time == null)
              SizedBox(
                height: isMobileSite ? 80 : 120,
                child: const Center(
                  child: DefaultTextStyle(
                    style: AppFontStyle.wb40R16,
                    child: Text("Please select date and time"),
                  ),
                ),
              ),

            SizedBox(width: isMobileSite ? 8 : 16),
            Row(
              children: [
                const SizedBox(width: 1),
                Expanded(
                  child: SizedBox(
                    height: isMobileSite ? 36 : 40,
                    child: TextButton(
                      onPressed: () async {
                        if (isReserveButtonEnabled()) {
                          final id =
                              context.read<AppViewModel>().app.getUser.getId;
                          final request = RoomReservationRequest(
                              purpose: textController.text,
                              bookDate: _date!,
                              bookTime: _time!,
                              userId: id);
                          await context
                              .read<FacilityViewModel>()
                              .reserveRoom(request);

                          Navigator.push(context,
                              MaterialPageRoute(builder: ((context) {
                            return const MyBookingView();
                          })));
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
                      child: Text('Reserve',
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
