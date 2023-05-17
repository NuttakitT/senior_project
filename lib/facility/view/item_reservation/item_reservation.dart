import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senior_project/assets/color_constant.dart';
import 'package:senior_project/assets/font_style.dart';
import 'package:senior_project/core/template/template_desktop/view/page/template_desktop.dart';
import 'package:senior_project/core/template/template_mobile/view/template_menu_mobile.dart';
import 'package:senior_project/facility/model/facility_model.dart';
import 'package:senior_project/facility/view/item_reservation/drop_down.dart';
import 'package:senior_project/facility/view/room_reservation/radio_form.dart';
import 'package:senior_project/facility/view/widget/facility_header.dart';
import 'package:senior_project/facility/view/widget/facility_header_mobile.dart';
import 'package:senior_project/facility/view_model/facility_view_model.dart';

class ItemReservationView extends StatefulWidget {
  const ItemReservationView({super.key});

  @override
  State<ItemReservationView> createState() => _ItemReservationViewState();
}

class _ItemReservationViewState extends State<ItemReservationView> {
  bool isMobileSite = kIsWeb &&
      (defaultTargetPlatform == TargetPlatform.iOS ||
          defaultTargetPlatform == TargetPlatform.android);

  @override
  Widget build(BuildContext context) {
    if (isMobileSite) {
      return TemplateMenuMobile(
          content: Column(
        children: const [
          FacilityHeaderMobile(title: "Item Reservation"),
          ItemReservationForm()
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
              FacilityHeader(title: "Item Reservation"),
              ItemReservationForm()
            ],
          ));
    }
  }
}

class ItemReservationForm extends StatefulWidget {
  const ItemReservationForm({super.key});

  @override
  State<ItemReservationForm> createState() => _ItemReservationFormState();
}

class _ItemReservationFormState extends State<ItemReservationForm> {
  DateTime? _fromDate;
  DateTime? _toDate;
  DateTime? _time;
  TextEditingController textController = TextEditingController();
  RoomModel? selectedRoom;

  bool isReserveButtonEnabled() {
    if (_fromDate != null &&
        _toDate != null &&
        _time != null &&
        textController.text.isNotEmpty &&
        selectedRoom != null) {
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

  Future<void> _selectFromDate(BuildContext context) async {
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
    if (pickedDate != null && pickedDate != _fromDate) {
      setState(() {
        _fromDate = pickedDate;
      });
    }
  }

  Future<void> _selectToDate(BuildContext context) async {
    if (_fromDate == null) return;

    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: _fromDate!,
      lastDate: _fromDate!.add(const Duration(days: 3)),
      selectableDayPredicate: (DateTime day) {
        // Exclude Saturdays and Sundays
        if (day.weekday == DateTime.saturday ||
            day.weekday == DateTime.sunday) {
          return false;
        }
        return true;
      },
    );
    if (pickedDate != null && pickedDate != _toDate) {
      setState(() {
        _toDate = pickedDate;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    if (_fromDate == null) return;
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
            Row(
              children: [
                Expanded(
                  flex: isMobileSite ? 1 : 1,
                  child: DefaultTextStyle(
                    style: isMobileSite
                        ? AppFontStyle.wb80R16
                        : AppFontStyle.wb80R24,
                    child: const Text("Item"),
                  ),
                ),
                SizedBox(width: isMobileSite ? 8 : 16),
                Expanded(
                    flex: isMobileSite ? 3 : 6,
                    child: FutureBuilder(
                        future: context.read<FacilityViewModel>().getItems(),
                        builder: (context, snapshot) {
                          final items = snapshot.data ?? [];
                          // if (items.isEmpty) {
                          //   return SizedBox(
                          //     height: isMobileSite ? 80 : 120,
                          //     child: const Center(
                          //       child: DefaultTextStyle(
                          //         style: AppFontStyle.wb40R16,
                          //         child:
                          //             Text("No room available at this time."),
                          //       ),
                          //     ),
                          //   );
                          // }
                          return DropDownForm(
                            items: items,
                          );
                        })),
              ],
            ),
            // Amount
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  flex: isMobileSite ? 1 : 1,
                  child: DefaultTextStyle(
                    style: isMobileSite
                        ? AppFontStyle.wb80R16
                        : AppFontStyle.wb80R24,
                    child: const Text("Amount"),
                  ),
                ),
                SizedBox(width: isMobileSite ? 8 : 16),
                Expanded(
                  flex: isMobileSite ? 3 : 6,
                  child: TextField(
                    controller: textController,
                    onTap: () {},
                    decoration: const InputDecoration(
                      hintText: "Amount",
                      hintStyle:
                          TextStyle(color: ColorConstant.black, fontSize: 14),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                          borderSide:
                              BorderSide(color: ColorConstant.whiteBlack20)),
                    ),
                  ),
                ),
              ],
            ),
            // Date Picker
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
                      child: const Text("From date"),
                    ),
                  ),
                ),
                SizedBox(width: isMobileSite ? 8 : 16),
                Expanded(
                  flex: isMobileSite ? 3 : 6,
                  child: GestureDetector(
                    onTap: () {
                      _selectFromDate(context);
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
                        _fromDate != null
                            ? _fromDate.toString().split(' ')[0]
                            : 'Date',
                      ),
                    ),
                  ),
                ),
              ],
            ),
            // To date
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
                      child: const Text("To date"),
                    ),
                  ),
                ),
                SizedBox(width: isMobileSite ? 8 : 16),
                Expanded(
                  flex: isMobileSite ? 3 : 6,
                  child: GestureDetector(
                    onTap: () {
                      _selectFromDate(context);
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
                        _toDate != null
                            ? _toDate.toString().split(' ')[0]
                            : 'Date',
                      ),
                    ),
                  ),
                ),
              ],
            ),
            // Time
            // const SizedBox(height: 16),
            // Row(
            //   children: [
            //     Expanded(
            //       flex: isMobileSite ? 1 : 1,
            //       child: SizedBox(
            //         child: DefaultTextStyle(
            //           style: isMobileSite
            //               ? AppFontStyle.wb80R16
            //               : AppFontStyle.wb80R24,
            //           child: const Text("Select time"),
            //         ),
            //       ),
            //     ),
            //     SizedBox(width: isMobileSite ? 8 : 16),
            //     Expanded(
            //       flex: isMobileSite ? 3 : 6,
            //       child: GestureDetector(
            //         onTap: () {
            //           _selectTime(context);
            //           if (_time != null) {
            //             // Call room loader
            //           }
            //         },
            //         child: Container(
            //           padding: const EdgeInsets.symmetric(
            //               horizontal: 16, vertical: 8),
            //           decoration: BoxDecoration(
            //             color: ColorConstant.white,
            //             borderRadius: BorderRadius.circular(8),
            //             border: Border.all(color: ColorConstant.whiteBlack20),
            //           ),
            //           child: Text(
            //             _time != null
            //                 ? _formatTimeRange(TimeOfDay.fromDateTime(_time!))
            //                 : 'Time in date',
            //           ),
            //         ),
            //       ),
            //     ),
            //   ],
            // ),
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
            // Row(
            //   children: [
            //     Expanded(
            //       flex: isMobileSite ? 1 : 1,
            //       child: DefaultTextStyle(
            //         style: isMobileSite
            //             ? AppFontStyle.wb80R16
            //             : AppFontStyle.wb80R24,
            //         child: const Text("Room"),
            //       ),
            //     ),
            //     SizedBox(width: isMobileSite ? 8 : 16),
            //     Expanded(
            //         flex: isMobileSite ? 3 : 6,
            //         child: _fromDate == null || _time == null
            //             ? Container()
            //             : FutureBuilder(
            //                 future: context
            //                     .read<FacilityViewModel>()
            //                     .getAvailableRoom(),
            //                 builder: (context, snapshot) {
            //                   final rooms = snapshot.data ?? [];
            //                   if (rooms.isEmpty) {
            //                     return SizedBox(
            //                       height: isMobileSite ? 80 : 120,
            //                       child: const Center(
            //                         child: DefaultTextStyle(
            //                           style: AppFontStyle.wb40R16,
            //                           child: Text(
            //                               "No room available at this time."),
            //                         ),
            //                       ),
            //                     );
            //                   }
            //                   return RadioForm(
            //                       rooms: rooms,
            //                       onPressed: (rooms) {
            //                         setState(() {
            //                           selectedRoom = rooms;
            //                         });
            //                       });
            //                 })),
            //   ],
            // ),
            // if (_fromDate == null || _time == null)
            //   SizedBox(
            //     height: isMobileSite ? 80 : 120,
            //     child: const Center(
            //       child: DefaultTextStyle(
            //         style: AppFontStyle.wb40R16,
            //         child: Text("Please select date and time"),
            //       ),
            //     ),
            //   ),

            SizedBox(width: isMobileSite ? 8 : 16),
            // Booking Button
            Row(
              children: [
                const SizedBox(width: 1),
                Expanded(
                  child: SizedBox(
                    height: isMobileSite ? 36 : 40,
                    child: TextButton(
                      onPressed: () {
                        if (isReserveButtonEnabled()) {}
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
                      child: Text('Request Reserve',
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
