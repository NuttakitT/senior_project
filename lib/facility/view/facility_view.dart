import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:senior_project/core/template/template_desktop/view/page/template_desktop.dart';
import 'package:senior_project/core/template/template_mobile/view/template_menu_mobile.dart';
import 'package:senior_project/facility/view/item_reservation/item_reservation.dart';
import 'package:senior_project/facility/view/my_booking/my_booking.dart';
import 'package:senior_project/facility/view/room_reservation/room_reservation_view.dart';

class FacilityView extends StatefulWidget {
  const FacilityView({super.key});

  @override
  State<FacilityView> createState() => _FacilityViewState();
}

class _FacilityViewState extends State<FacilityView> {
  bool isMobileSite = kIsWeb &&
      (defaultTargetPlatform == TargetPlatform.iOS ||
          defaultTargetPlatform == TargetPlatform.android);

  @override
  Widget build(BuildContext context) {
    if (isMobileSite) {
      return TemplateMenuMobile(
          content: Column(
        children: const [
          FacilityViewTile(),
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
              FacilityViewTile(),
            ],
          ));
    }
  }
}

class FacilityViewTile extends StatelessWidget {
  const FacilityViewTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          child: ListTile(
            title: Text("Room Reservation"),
            subtitle: Text("Reserve room in CPE"),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: ((context) {
                return const RoomReservationView();
              })));
            },
          ),
        ),
        Card(
          child: ListTile(
            title: Text("Request Hardware"),
            subtitle: Text("Request Hardware in hardware house"),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: ((context) {
                return const ItemReservationView();
              })));
            },
          ),
        ),
        Card(
          child: ListTile(
            title: Text("My Booking"),
            subtitle: Text("See your booking"),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: ((context) {
                return const MyBookingView();
              })));
            },
          ),
        )
      ],
    );
  }
}
