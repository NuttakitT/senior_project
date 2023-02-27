import 'package:flutter/widgets.dart';
import 'package:senior_project/teacher_contact/view/widget/teacher_contact_desktop_card.dart';

class TeacherContactDesktopListView extends StatelessWidget {
  const TeacherContactDesktopListView(
      {super.key, required this.teacherContactList});
  final List<Map<String, dynamic>?> teacherContactList;

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> cards = teacherContactList
        .where(
          (element) => element != null,
        )
        .map((item) => item!)
        .toList();
    return Container(
      height: MediaQuery.of(context).size.height - 162,
      // padding: const EdgeInsets.only(top: 40, left: 102, right: 102),
      child: GridView.count(
          crossAxisCount: 2,
          // childAspectRatio: 1.0,
          mainAxisSpacing: 8.0,
          crossAxisSpacing: 8.0,
          children: List.generate(cards.length, (index) {
            return TeacherContactDesktopCard(
              cardDetail: cards[index],
            );
          })),
      // child: Column(
      //   children: [
      //     Row(card card),
      //     Row(card card),
      //   ],
      // ),
    );
  }
}
