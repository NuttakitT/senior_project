// ignore_for_file: use_build_context_synchronously

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:senior_project/assets/font_style.dart';
import 'package:senior_project/core/datasource/firebase_services.dart';
import 'package:senior_project/core/template/template_desktop/view/widget/desktop/confirmation_popup.dart';
import 'package:senior_project/facility/model/facility_model.dart';
import 'package:senior_project/facility/view/my_booking/my_booking.dart';
import 'package:senior_project/facility/view/my_booking/suggest_faq.dart';
import 'package:senior_project/facility/view_model/facility_view_model.dart';

class BookingCardView extends StatefulWidget {
  final dynamic cardDetail;
  const BookingCardView({super.key, required this.cardDetail});

  @override
  State<BookingCardView> createState() => _BookingCardViewState();
}

class _BookingCardViewState extends State<BookingCardView> {
  String dateFormat(DateTime? date) {
    if (date == null) {
      return "";
    }
    return DateFormat('HH:mm dd/MM/yyyy').format(date);
  }

  final _itemReservation = FirebaseServices("itemReservations");

  @override
  Widget build(BuildContext context) {
    RoomReservation? roomCard;
    if (widget.cardDetail is RoomReservation) {
      try {
        roomCard = widget.cardDetail;
      } catch (e) {
        if (kDebugMode) {
          print(e);
        }
      }
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const DefaultTextStyle(
              style: AppFontStyle.wb80Md28, child: Text("Room Reservation")),
          const SizedBox(height: 4),
          BookCardViewCell(title: "Detail", detail: "Room ${roomCard?.room}"),
          BookCardViewCell(
              title: "Create", detail: dateFormat(roomCard?.dateCreate)),
          BookCardViewCell(
              title: "Book time", detail: dateFormat(roomCard?.bookTime)),
          BookCardViewCell(
              title: "End time", detail: dateFormat(roomCard?.endTime)),
          BookCardViewCell(title: "Status", detail: "${roomCard?.status}"),
          Builder(
            builder: (context) {
              DateTime now = DateTime.now();
              if (!roomCard!.endTime.isAfter(now)) {
                return Container();
              }
              return Row(
                children: [
                  Flexible(
                    fit: FlexFit.tight,
                    child: TextButton(
                        onPressed: () {
                          showDialog(
                              context: (context),
                              builder: ((context) {
                                return ConfirmationPopup(
                                    title: "Cancel Reservation?",
                                    detail:
                                        "Are you sure you want to cancel this room?",
                                    widget: null,
                                    onCancel: () {
                                      Navigator.pop(context);
                                    },
                                    onConfirm: () async {
                                      await context
                                          .read<FacilityViewModel>()
                                          .cancelBooking(context, roomCard?.id ?? "", true,
                                              roomCard?.room);
                                      Navigator.pushAndRemoveUntil(
                                        context, 
                                        MaterialPageRoute(builder: (context) {
                                          return const MyBookingView();
                                        }), 
                                        (route) => false
                                      );
                                    });
                              }));
                        },
                        child: const DefaultTextStyle(
                          style: AppFontStyle.red40R16,
                          child: Text("Cancel", textAlign: TextAlign.end),
                        )),
                  ),
                  Flexible(
                    fit: FlexFit.tight,
                    child: TextButton(
                      onPressed: () {
                        showDialog(
                          context: (context),
                          builder: (context) {
                            return AlertDialog(
                              content: SuggestFaq(
                                bookTime: roomCard!.bookTime, 
                                isItemRequest: false, 
                                object: roomCard.room!,
                              ),
                            );
                          }
                        );
                      },
                      child: const DefaultTextStyle(
                        style: AppFontStyle.orange50R16,
                        child: Text("แจ้งปัญหากับเจ้าหน้าที่", textAlign: TextAlign.end),
                      )
                    ),
                  )
                ],
              );
            }
          )
        ],
      );
    } else if (widget.cardDetail is ItemReservation) {
      ItemReservation? itemCard;
      try {
        itemCard = widget.cardDetail;
      } catch (e) {
        if (kDebugMode) {
          print(e);
        }
      }
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const DefaultTextStyle(
              style: AppFontStyle.wb80Md28, child: Text("Item request")),
          const SizedBox(height: 4),
          BookCardViewCell(
              title: "Detail",
              detail: "${itemCard?.objectName} amount ${itemCard?.amount} ea."),
          BookCardViewCell(
              title: "Start", detail: dateFormat(itemCard?.startDate)),
          BookCardViewCell(
              title: "Until", detail: dateFormat(itemCard?.endDate)),
          BookCardViewCell(title: "Status", detail: "${itemCard?.status}"),
          StreamBuilder(
            stream: _itemReservation.listenToDocument(itemCard!.id!),
            builder: (context, snapshot) {
              if (snapshot.connectionState != ConnectionState.active) {
                return Container();
              }
              if (snapshot.data!.get("status") != "Pending") {
                return Container();
              }
              return Row(
                children: [
                  Flexible(
                    fit: FlexFit.tight,
                    child: TextButton(
                        onPressed: () async {
                          showDialog(
                              context: (context),
                              builder: ((context) {
                                return ConfirmationPopup(
                                    title: "Cancel Request Item",
                                    detail:
                                        "Are you sure you want to cancel the request?",
                                    widget: null,
                                    onCancel: () {
                                      Navigator.pop(context);
                                    },
                                    onConfirm: () async {
                                      await context
                                          .read<FacilityViewModel>()
                                          .cancelBooking(context,
                                              itemCard?.id ?? "", false, null);
                                      Navigator.pushAndRemoveUntil(
                                        context, 
                                        MaterialPageRoute(builder: (context) {
                                          return const MyBookingView();
                                        }), 
                                        (route) => false
                                      );
                                    });
                              }));
                        },
                        child: const DefaultTextStyle(
                          style: AppFontStyle.red40R16,
                          child: Text("Cancel", textAlign: TextAlign.end),
                        )),
                  ),
                  Flexible(
                    fit: FlexFit.tight,
                    child: TextButton(
                      onPressed: () {
                        showDialog(
                          context: context, 
                          builder: (context) {
                            return AlertDialog(
                              content: SuggestFaq(
                                bookTime: itemCard!.startDate, 
                                isItemRequest: true, 
                                object: itemCard.objectName,
                              ),
                            );
                          }
                        );
                      },
                      child: const DefaultTextStyle(
                        style: AppFontStyle.orange50R16,
                        child: Text("แจ้งปัญหากับเจ้าหน้าที่", textAlign: TextAlign.end),
                      )
                    ),
                  )
                ],
              );
            }
          )
        ],
      );
    }
    return Container();
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
