import 'package:flutter/material.dart';
import 'package:senior_project/user_authentication/role_selection_page/view/desktop/widget/card_selection_desktop.dart';

class RoleSelectionPage extends StatelessWidget {
  const RoleSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO desktop templete
    return Column(
      children: const [
        Padding(
          padding: EdgeInsets.only(bottom: 16),
          child: CardSelectionDesktop(isStudentCard: true),
        ),
        CardSelectionDesktop(isStudentCard: false),
      ],
    );
  }
}