import 'package:flutter/material.dart';
import 'package:senior_project/teacher_contact/view/widget/teacher_contact_desktop_card.dart';

class TeacherContactDesktopListView extends StatelessWidget {
  const TeacherContactDesktopListView(
      {super.key,
      required this.isMobileSite,
      required this.isAdmin,
      required this.teacherContactList});
  final bool isMobileSite;
  final bool isAdmin;
  final List<Map<String, dynamic>?> teacherContactList;

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> cards = teacherContactList
        .where(
          (element) => element != null,
        )
        .map((item) => item!)
        .toList();
    if (cards.isEmpty) {
      return const Center(child: Text('No results'));
    }
    return Container(
      constraints: const BoxConstraints(minWidth: 1300, maxWidth: 1700),
      height: MediaQuery.of(context).size.height - 162,
      child: GridView.count(
          padding: const EdgeInsets.only(top: 40, left: 40, right: 20),
          crossAxisCount: isMobileSite ? 1 : 2,
          childAspectRatio: 2.1,
          mainAxisSpacing: 20.0,
          crossAxisSpacing: 20.0,
          children: List.generate(cards.length, (index) {
            return TeacherContactDesktopCard(
              cardDetail: cards[index],
              isEditable: !isMobileSite && isAdmin,
            );
          })),
    );
  }
}
