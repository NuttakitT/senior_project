import 'package:flutter/material.dart';
import 'package:senior_project/assets/constant.dart';
import 'package:senior_project/user_authentication/core/widget/page_indicator.dart';
import 'package:senior_project/user_authentication/role_selection_page/view/desktop/widget/card_selection_desktop.dart';
import 'package:senior_project/user_authentication/role_selection_page/core/widget/role_selection_confirm_button.dart';

class RoleSelectionPage extends StatelessWidget {
  const RoleSelectionPage({super.key});
  final double widgetWidth = 580;

  @override
  Widget build(BuildContext context) {
    // TODO desktop templete
    return SizedBox(
      width: widgetWidth,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.only(bottom: 80),
            child: PageIndicator(width: 280, isMobileSize: false,),
          ),
          const SizedBox(
            width: double.infinity,
            child: Text(
              "Selec Your Role",
              style: TextStyle(
                fontFamily: Constant.font,
                fontWeight: FontWeight.w500,
                fontSize: 32,
                color: Constant.whiteBlack80
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
      ),
    );
  }
}