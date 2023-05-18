import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senior_project/core/template/template_desktop/view/page/template_desktop.dart';
import 'package:senior_project/facility/model/facility_model.dart';
import 'package:senior_project/facility/view/admin_room/room_date_filter.dart';
import 'package:senior_project/facility/view/admin_room/room_stat_table.dart';
import 'package:senior_project/facility/view/widget/facility_header.dart';
import 'package:senior_project/facility/view_model/facility_view_model.dart';

class AdminRoom extends StatefulWidget {
  const AdminRoom({super.key});

  @override
  State<AdminRoom> createState() => _AdminRoomState();
}

class _AdminRoomState extends State<AdminRoom> {
  @override
  Widget build(BuildContext context) {
    return TemplateDesktop(
        helpdesk: false,
        helpdeskadmin: false,
        home: true,
        useTemplatescroll: true,
        content: Column(
          children: const [
            FacilityHeader(title: "Room Statistical Section"),
            RoomDateFilterView(),
            AdminRoomStatisticView(),
          ],
        ));
  }
}

class AdminRoomStatisticView extends StatefulWidget {
  const AdminRoomStatisticView({super.key});

  @override
  State<AdminRoomStatisticView> createState() => _AdminRoomStatisticViewState();
}

class _AdminRoomStatisticViewState extends State<AdminRoomStatisticView> {
  @override
  Widget build(BuildContext context) {
    // DateTime from = DateTime(2023, 4, 15, 12, 0, 0);
    // DateTime to = DateTime(2023, 5, 20, 12, 0, 0);

    return FutureBuilder(
      future: context.watch<FacilityViewModel>().fetchRoomStatisticData(
          context.watch<FacilityViewModel>().startDate,
          context.watch<FacilityViewModel>().endDate),
      builder: ((context, snapshot) {
        if (snapshot.hasError) {
          return Text('Has error ${snapshot.error}');
        }
        if (snapshot.connectionState == ConnectionState.done) {
          List<RoomStatModel> roomStat = snapshot.data ?? [];
          return Column(
            children: [RoomStatTable(rooms: roomStat)],
          );
        }
        return const Center(
          child: SizedBox(
            width: 100,
            height: 100,
            child: CircularProgressIndicator(),
          ),
        );
      }),
    );
  }
}
