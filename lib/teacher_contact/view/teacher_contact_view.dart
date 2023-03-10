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
    bool isMobileSite = context.watch<AppViewModel>().getMobileSiteState(MediaQuery.of(context).size.width);

    final List<Map<String, dynamic>> teacherContactList = [
      {
        "imageUrl": "https://picsum.photos/200/300",
        "name": "Runn",
        "surname": "Siriphuwanich",
        "thaiName": "รัญชน์",
        "thaiSurname": "ศิริภูวณิชย์",
        "email": "runnsiriphuwanich@gmail.com",
        "phone": "0812343212",
        "officeHours": "12.00 - 17.00",
        "facebookLink": "https://www.youtube.com/watch?v=dQw4w9WgXcQ",
        "subject":
            "CPE 401 Software Engineering Project\nCPE111 Data Structuressss"
      },
      {
        "imageUrl": "https://picsum.photos/200/300",
        "name": "Runn",
        "surname": "Siriphuwanich",
        "thaiName": "รัญชน์",
        "thaiSurname": "ศิริภูวณิชย์",
        "email": "runnsiriphuwanich@gmail.com",
        "phone": "0812343212",
        "officeHours": "12.00 - 17.00",
        "facebookLink": "https://www.youtube.com/watch?v=dQw4w9WgXcQ"
      },
      {
        "imageUrl": "https://picsum.photos/200/300",
        "name": "Runn",
        "surname": "Siriphuwanich",
        "thaiName": "รัญชน์ำพไำพำพำพ",
        "thaiSurname": "ศิริภูวณิชย์กหกหกหกหก",
        "email": "runnsiriphuwanich@gmail.com",
        "phone": "0812343212",
        "officeHours": "12.00 - 17.00",
        "facebookLink": "https://www.youtube.com/watch?v=dQw4w9WgXcQ"
      },
      {
        "imageUrl": "https://picsum.photos/200/300",
        "name": "Runn",
        "surname": "Siriphuwanich",
        "thaiName": "รัญชน์",
        "thaiSurname": "ศิริภูวณิชย์",
        "email": "runnsiriphuwanich@gmail.com",
        "phone": "0812343212",
        "officeHours": "12.00 - 17.00",
        "facebookLink": "https://www.youtube.com/watch?v=dQw4w9WgXcQ"
      },
      {
        "imageUrl": "https://picsum.photos/200/300",
        "name": "Runn",
        "surname": "Siriphuwanich",
        "thaiName": "รัญชน์",
        "thaiSurname": "ศิริภูวณิชย์",
        "email": "runnsiriphuwanich@gmail.com",
        "phone": "0812343212",
        "officeHours": "12.00 - 17.00",
        "facebookLink": "https://www.youtube.com/watch?v=dQw4w9WgXcQ"
      },
    ];

    if (isMobileSite) {
      return Container();
    } else {}
    return TemplateDesktop(
        faqmenu: false,
        faqmenuadmin: false,
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
              teacherContactList: teacherContactList,
            )
          ],
        ));
  }
}
