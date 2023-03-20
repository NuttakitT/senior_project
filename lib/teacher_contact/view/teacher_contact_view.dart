import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senior_project/core/template_desktop/view/page/template_desktop.dart';
import 'package:senior_project/core/template_mobile/view/template_menu_mobile.dart';
import 'package:senior_project/teacher_contact/model/teacher_contact_model.dart';
import 'package:senior_project/teacher_contact/view/widget/teacher_contact_desktop_card.dart';
import 'package:senior_project/teacher_contact/view/widget/teacher_contact_desktop_list.dart';
import 'package:senior_project/teacher_contact/view_model/teacher_contact_view_model.dart';

import '../../core/view_model/app_view_model.dart';

class TeacherContactView extends StatelessWidget {
  final bool isAdmin;
  const TeacherContactView({super.key, required this.isAdmin});

  @override
  Widget build(BuildContext context) {
    bool isMobileSite = context
        .watch<AppViewModel>()
        .getMobileSiteState(MediaQuery.of(context).size.width);

    return FutureBuilder(
        future: context.watch<TeacherContactViewModel>().getTeacherContacts(),
        builder: ((context, snapshot) {
          return isMobileSite
              ? TemplateMenuMobile(
                  content: TeacherContactDesktopListView(
                  isMobileSite: isMobileSite,
                  isAdmin: isAdmin,
                  teacherContactList: snapshot.data ?? [],
                ))
              : TemplateDesktop(
                  helpdesk: false,
                  helpdeskadmin: false,
                  home: false,
                  useTemplatescroll: true,
                  content: Column(
                    children: [
                      TeacherContactDesktopHeader(
                        isAdmin: isAdmin,
                      ),
                      TeacherContactDesktopListView(
                        isMobileSite: false,
                        isAdmin: isAdmin,
                        teacherContactList: snapshot.data ?? [],
                      )
                    ],
                  ));
        }));
  }
}
