import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senior_project/core/template/template_desktop/view/page/template_desktop.dart';
import 'package:senior_project/core/template/template_mobile/view/template_menu_mobile.dart';
import 'package:senior_project/core/view_model/app_view_model.dart';
import 'package:senior_project/facility/model/facility_model.dart';
import 'package:senior_project/facility/view/my_booking/booking_card.dart';
import 'package:senior_project/facility/view/widget/facility_header.dart';
import 'package:senior_project/facility/view/widget/facility_header_mobile.dart';
import 'package:senior_project/facility/view_model/facility_view_model.dart';

class MyBookingView extends StatefulWidget {
  const MyBookingView({super.key});

  @override
  State<MyBookingView> createState() => _MyBookingViewState();
}

class _MyBookingViewState extends State<MyBookingView> {
  bool isMobileSite = kIsWeb &&
      (defaultTargetPlatform == TargetPlatform.iOS ||
          defaultTargetPlatform == TargetPlatform.android);

  @override
  Widget build(BuildContext context) {
    if (isMobileSite) {
      return TemplateMenuMobile(
          content: Column(
        children: const [
          FacilityHeaderMobile(title: "My Booking"),
          MyBookingList()
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
              FacilityHeader(title: "My Booking"),
              MyBookingList()
            ],
          ));
    }
  }
}

class MyBookingList extends StatefulWidget {
  const MyBookingList({super.key});

  @override
  State<MyBookingList> createState() => _MyBookingListState();
}

class _MyBookingListState extends State<MyBookingList> {
  @override
  Widget build(BuildContext context) {
    bool isMobileSite = kIsWeb &&
        (defaultTargetPlatform == TargetPlatform.iOS ||
            defaultTargetPlatform == TargetPlatform.android);

    const mobilePadding = EdgeInsets.only(left: 12, right: 12, bottom: 24);
    const desktopPadding = EdgeInsets.only(left: 64, right: 64, bottom: 24);

    const mobileBoxPadding = EdgeInsets.all(8);
    const desktopBoxPadding = EdgeInsets.all(16);

    final userId = context.read<AppViewModel>().app.getUser.getId;
    return FutureBuilder(
      future: context.read<FacilityViewModel>().fetchBookings(userId),
      builder: (context, snapshot) {
        List<BookingCard> bookList = snapshot.data ?? [];
        return SizedBox(
          height: MediaQuery.of(context).size.height,
          child: ListView.builder(
              itemCount: bookList.length,
              itemBuilder: ((context, index) {
                return Padding(
                    padding: isMobileSite ? mobilePadding : desktopPadding,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Card(
                        child: Container(
                            padding: isMobileSite
                                ? mobileBoxPadding
                                : desktopBoxPadding,
                            child:
                                BookingCardView(cardDetail: bookList[index])),
                      ),
                    ));
              })),
        );
      },
    );
  }
}
