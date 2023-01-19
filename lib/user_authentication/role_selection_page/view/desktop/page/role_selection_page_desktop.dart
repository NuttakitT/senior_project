import 'package:flutter/material.dart';
import 'package:senior_project/assets/constant.dart';
import 'package:senior_project/user_authentication/core/widget/desktop/back_plate_desktop.dart';
import 'package:senior_project/user_authentication/core/widget/page_indicator.dart';
import 'package:senior_project/user_authentication/role_selection_page/view/desktop/widget/card_selection_desktop.dart';
import 'package:senior_project/user_authentication/role_selection_page/core/widget/role_selection_confirm_button.dart';

class RoleSelectionPage extends StatelessWidget {
  const RoleSelectionPage({super.key});
  final double widgetWidth = 580;

  Widget pageDetail() {
    return Column(
      children: [
        const SizedBox(
          width: double.infinity,
          child: Text(
            "Selec Your Role",
            style: TextStyle(
              fontFamily: Constant.font,
              fontWeight: FontWeight.w700,
              fontSize: 32,
              color: Constant.orange70
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.fromLTRB(0, 40, 0, 16),
          child: CardSelectionDesktop(isStudentCard: true),
        ),
        const Padding(
          padding: EdgeInsets.only(bottom: 24),
          child: CardSelectionDesktop(isStudentCard: false),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 220),
              child: RoleSelctionButton.button(false, 180),
            ),
            RoleSelctionButton.button(true, 180),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO desktop templete
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.only(bottom: 80),
            child: PageIndicator(width: 280, isMobileSize: false,),
          ),
          BackPlateWidgetDesktop.widget(
            context,
            {"width": 630, "height": MediaQuery.of(context).size.height * 0.63,},
            pageDetail()
          ),
        ],
      ),
    );
  }
}