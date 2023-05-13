import 'package:flutter/widgets.dart';
import 'package:senior_project/teacher_contact/view/widget/teacher_contact_desktop_card.dart';
import 'package:senior_project/teacher_contact/view/widget/teacher_contact_mobile_card.dart';

class TeacherContactMobileListView extends StatelessWidget {
  const TeacherContactMobileListView(
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
    return SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 200),
          child: ListView.builder(
              itemCount: cards.length,
              itemBuilder: (context, index) {
                return TeacherContactMobileCard(cardDetail: cards[index]);
              }),
        ));
  }
}
