import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senior_project/assets/font_style.dart';
import 'package:senior_project/core/template/template_desktop/view/widget/desktop/confirmation_popup.dart';
import 'package:senior_project/facility/model/facility_model.dart';
import 'package:senior_project/facility/view/facility_view.dart';
import 'package:senior_project/facility/view_model/facility_view_model.dart';

class BookingCardView extends StatefulWidget {
  final dynamic cardDetail;
  const BookingCardView({super.key, required this.cardDetail});

  @override
  State<BookingCardView> createState() => _BookingCardViewState();
}

class _BookingCardViewState extends State<BookingCardView> {
  @override
  Widget build(BuildContext context) {
    RoomReservation? roomCard;
    if (widget.cardDetail is RoomReservation) {
      try {
        roomCard = widget.cardDetail;
      } catch (e) {
        print(e);
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
              title: "Create", detail: "${roomCard?.dateCreate.toString()}"),
          BookCardViewCell(
              title: "Book time", detail: "${roomCard?.bookTime.toString()}"),
          BookCardViewCell(title: "Status", detail: "${roomCard?.status}"),
          Row(
            children: [
              Expanded(
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
                                      .cancelBooking(roomCard?.id ?? "", true,
                                          roomCard?.room);
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                });
                          }));
                    },
                    child: const DefaultTextStyle(
                      style: AppFontStyle.red40R16,
                      child: Text("Cancel", textAlign: TextAlign.end),
                    )),
              ),
            ],
          )
        ],
      );
    } else if (widget.cardDetail is ItemReservation) {
      ItemReservation? itemCard;
      try {
        itemCard = widget.cardDetail;
      } catch (e) {
        print(e);
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
              title: "Start", detail: "${itemCard?.startDate.toString()}"),
          BookCardViewCell(
              title: "Until", detail: "${itemCard?.endDate.toString()}"),
          BookCardViewCell(title: "Status", detail: "${itemCard?.status}"),
          Row(
            children: [
              Expanded(
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
                                      .cancelBooking(
                                          itemCard?.id ?? "", false, null);
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                });
                          }));
                    },
                    child: const DefaultTextStyle(
                      style: AppFontStyle.red40R16,
                      child: Text("Cancel", textAlign: TextAlign.end),
                    )),
              ),
            ],
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
