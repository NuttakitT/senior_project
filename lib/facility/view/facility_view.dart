import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senior_project/assets/color_constant.dart';
import 'package:senior_project/assets/font_style.dart';
import 'package:senior_project/core/template/template_desktop/view/page/template_desktop.dart';
import 'package:senior_project/core/template/template_mobile/view/template_menu_mobile.dart';
import 'package:senior_project/core/view_model/app_view_model.dart';
import 'package:senior_project/facility/view/admin_room/admin_room.dart';
import 'package:senior_project/facility/view/item_reservation/item_reservation.dart';
import 'package:senior_project/facility/view/my_booking/my_booking.dart';
import 'package:senior_project/facility/view/room_reservation/room_reservation_view.dart';
import 'package:senior_project/facility/view/schedule/schedule_room.dart';

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
    bool isLogin = context.watch<AppViewModel>().isLogin;
    if (!isLogin) {
      return const Center(
        child: Text(
          "Please login to use the services",
          style: TextStyle(
              color: ColorConstant.orange60,
              fontWeight: FontWeight.w400,
              fontFamily: AppFontStyle.font,
              fontSize: 18),
        ),
      );
    }
    return Column(
      children: [
        Card(
          child: ListTile(
            title: Text("Room Reservation"),
            subtitle: Text("จองห้องเรียน"),
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
            subtitle: Text("ส่งคำขอยืมอุปกรณ์ Hardware ที่นี่"),
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
            subtitle: Text("การจองห้องของคุณ"),
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
              title: Text("Admin Dashboard"),
              subtitle: Text(
                  "ดูจำนวนการจองห้องเรียนตามวันเวลา ลงเวลาห้องเรียนรายสัปดาห์"),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: ((context) {
                  return const AdminRoom();
                })));
              },
            ),
          ),
        if (!isMobileSite && isAdmin)
          Card(
            child: ListTile(
              title: Text("Schedule Room"),
              subtitle: Text("เพิ่มและยกเลิกการลงเวลาห้องเรียนรายสัปดาห์"),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: ((context) {
                  return const ScheduleRoomView();
                })));
              },
            ),
          )
      ],
    );
  }
}
