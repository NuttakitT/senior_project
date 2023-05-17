import 'package:flutter/cupertino.dart';
import 'package:senior_project/core/template/template_desktop/view/page/template_desktop.dart';
import 'package:senior_project/facility/view/widget/facility_header.dart';

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
          children: [
            const FacilityHeader(title: "Admin Section"),
            Container(),
          ],
        ));
  }
}
