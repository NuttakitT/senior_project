import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senior_project/core/template/template_desktop/view/page/template_desktop.dart';
import 'package:senior_project/core/template/template_mobile/view/template_menu_mobile.dart';
import 'package:senior_project/core/view_model/app_view_model.dart';
import 'package:senior_project/facility/view/admin_room/admin_room.dart';
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
        children: [
          FacilityViewTile(isMobileSite: isMobileSite),
        ],
      ));
    } else {
      return TemplateDesktop(
          helpdesk: false,
          helpdeskadmin: false,
          home: true,
          useTemplatescroll: true,
          content: Column(
            children: [
              FacilityViewTile(isMobileSite: isMobileSite),
            ],
          ));
    }
  }
}

class FacilityViewTile extends StatelessWidget {
  final bool isMobileSite;
  const FacilityViewTile({Key? key, required this.isMobileSite})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isAdmin = context.watch<AppViewModel>().app.getUser.getRole == 0;
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
        ),
        if (!isMobileSite && isAdmin)
          Card(
            child: ListTile(
              title: Text("For Admin"),
              subtitle: Text("See rooms"),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: ((context) {
                  return const AdminRoom();
                })));
              },
            ),
          )
      ],
    );
  }
}
