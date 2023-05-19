import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senior_project/assets/color_constant.dart';
import 'package:senior_project/assets/font_style.dart';
import 'package:senior_project/core/template/template_desktop/view/page/template_desktop.dart';
import 'package:senior_project/core/template/template_desktop/view_model/template_desktop_view_model.dart';
import 'package:senior_project/core/template/template_mobile/view/template_menu_mobile.dart';
import 'package:senior_project/core/view_model/app_view_model.dart';
import 'package:senior_project/facility/model/facility_model.dart';
import 'package:senior_project/facility/view/my_booking/my_booking.dart';
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
              FacilityHeaderMobile(title: "Item Reservation"),
              ItemReservationForm()
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
                  FacilityHeader(title: "Item Reservation", canPop: false,),
                  ItemReservationForm()
                ],
              );
            }
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
  TextEditingController textController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  ItemModel? selectedItem;
  bool isInit = true;

  bool isReserveButtonEnabled() {
    if (_fromDate != null &&
        _toDate != null &&
        textController.text.isNotEmpty &&
        amountController.text.isNotEmpty &&
        selectedItem != null) {
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
      initialDate: _fromDate!,
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
            // items
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
                          if (snapshot.hasError) {
                            return Text(
                                'Error: ${snapshot.error}'); // Show an error message if there's an error
                          }
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            final items = context
                                .watch<FacilityViewModel>()
                                .getViewModeItems;
                            if (items.isEmpty) {
                              return SizedBox(
                                height: isMobileSite ? 80 : 120,
                                child: const Center(
                                  child: DefaultTextStyle(
                                    style: AppFontStyle.wb40R16,
                                    child:
                                        Text("No item available at this time."),
                                  ),
                                ),
                              );
                            }
                            if (isInit) {
                              selectedItem = items.first;
                            }
                            return DropdownButton<ItemModel>(
                              isExpanded: true,
                              value: selectedItem,
                              icon: const Icon(Icons.arrow_downward),
                              elevation: 16,
                              underline: Container(
                                height: 2,
                                color: Colors.deepPurpleAccent,
                              ),
                              onChanged: (ItemModel? value) {
                                setState(() {
                                  selectedItem = value!;
                                  isInit = false;
                                });
                              },
                              items: items.map<DropdownMenuItem<ItemModel>>(
                                  (ItemModel value) {
                                return DropdownMenuItem<ItemModel>(
                                  value: value,
                                  child: Text(value.objectName),
                                );
                              }).toList(),
                            );
                          }
                          return SizedBox(
                            height: isMobileSite ? 80 : 120,
                            child: const Center(
                              child: DefaultTextStyle(
                                style: AppFontStyle.wb40R16,
                                child: Text("Loading..."),
                              ),
                            ),
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
                    keyboardType: TextInputType.number,
                    controller: amountController,
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
                      _selectToDate(context);
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
            SizedBox(width: isMobileSite ? 8 : 16),
            // Booking Button
            Row(
              children: [
                const SizedBox(width: 1),
                Expanded(
                  child: SizedBox(
                    height: isMobileSite ? 36 : 40,
                    child: TextButton(
                      onPressed: () async {
                        int? amount;
                        try {
                          amount = int.parse(amountController.text);
                        } catch (e) {
                          print(
                              'Error: Failed to parse the string to an integer');
                          amount = 0;
                        }

                        if (isReserveButtonEnabled() && amount != 0) {
                          String userId =
                              context.read<AppViewModel>().app.getUser.getId;
                          final request = ItemReservation(
                              objectName: selectedItem!.objectName,
                              purpose: textController.text,
                              amount: amount,
                              startDate: _fromDate!,
                              endDate: _toDate!,
                              userId: userId,
                              status: "Pending");
                          final ticketTitle =
                              "Request ${selectedItem!.objectName} for $amount ea.";
                          final ticketDetail =
                              "Request the use of ${selectedItem!.objectName} amount=$amount from date $_fromDate to date $_toDate for ${textController.text}. (Automatically sent)";
                          const ticketPriority = 1;
                          const ticketCategory = "การใช้งานอุปกรณ์";

                          final List<dynamic> ticket = [
                            ticketTitle,
                            ticketDetail,
                            ticketPriority,
                            ticketCategory
                          ];
                          await context
                              .read<FacilityViewModel>()
                              .requestItems(request, ticket, context);
                          if (isMobileSite) {
                            Navigator.pop(context);
                          } else {
                            context
                              .read<TemplateDesktopViewModel>() 
                              .changeState(context, 5, 1);
                            Navigator.push(context,
                              MaterialPageRoute(builder: ((context) {
                              return const MyBookingView();
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
