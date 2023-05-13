import 'package:flutter/material.dart';
import 'package:senior_project/assets/color_constant.dart';
import 'package:senior_project/assets/font_style.dart';
import 'package:senior_project/teacher_contact/model/teacher_contact_model.dart';
import 'package:senior_project/teacher_contact/view/widget/teacher_contact_desktop_card.dart';

class TeacherContactMobileCard extends StatelessWidget {
  final Map<String, dynamic> cardDetail;
  const TeacherContactMobileCard({super.key, required this.cardDetail});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
      child: Card(
        shape: const RoundedRectangleBorder(
            side: BorderSide(color: ColorConstant.orange50),
            borderRadius: BorderRadius.all(Radius.circular(16))),
        child: SizedBox(
            child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  CircleAvatar(
                      backgroundImage: NetworkImage(cardDetail['imageUrl']),
                      radius: 30),
                  const SizedBox(width: 24),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        DefaultTextStyle(
                            style: AppFontStyle.wb90R18,
                            child: Text(cardDetail['name'])),
                        const SizedBox(height: 4),
                        DefaultTextStyle(
                            style: AppFontStyle.wb70R16,
                            child: Text(
                              cardDetail['email'],
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            )),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  TeachContactDesktopDetailCell(
                    title: "Office Hours",
                    detail: cardDetail['officeHours'],
                    isClickable: false,
                  ),
                  TeachContactDesktopDetailCell(
                    title: "Phone",
                    detail: cardDetail['phone'],
                    isClickable: false,
                  ),
                  TeachContactDesktopDetailCell(
                    title: "Facebook Link",
                    detail: cardDetail['facebookLink'],
                    isClickable: false,
                  ),
                  TeachContactDesktopDetailCell(
                    title: "Subject",
                    detail: cardDetail['subjectId'].join('\n'),
                    isClickable: false,
                  ),
                ],
              ),
            )
          ],
        )),
      ),
    );
  }
}
