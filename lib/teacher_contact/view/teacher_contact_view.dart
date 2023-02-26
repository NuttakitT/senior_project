import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senior_project/core/template_desktop/view/page/template_desktop.dart';
import 'package:senior_project/teacher_contact/view/widget/teacher_contact_desktop_card.dart';
import 'package:senior_project/teacher_contact/view/widget/teacher_contact_desktop_list.dart';

import '../../core/view_model/app_view_model.dart';

class TeacherContactView extends StatelessWidget {
  final bool isAdmin;
  const TeacherContactView({super.key, required this.isAdmin});

  @override
  Widget build(BuildContext context) {
    bool isMobileSite = context.watch<AppViewModel>().getMobileSiteState;

    final List<Map<String, dynamic>> teacherContactList = [];

    if (isMobileSite) {
      return Container();
    } else {}
    return TemplateDesktop(
        faqmenu: false,
        faqmenuadmin: false,
        helpdesk: false,
        helpdeskadmin: false,
        home: false,
        useTemplatescroll: false,
        content: Column(
          children: [
            TeacherContactDesktopHeader(
              isAdmin: isAdmin,
            ),
            TeacherContactDesktopListView(
              teacherContactList: teacherContactList,
            )
          ],
        ));
  }
}
