import 'package:flutter/material.dart';
import 'package:senior_project/assets/constant.dart';
import 'package:senior_project/user_authentication/core/widget/desktop/back_plate_desktop.dart';
import 'package:senior_project/user_authentication/core/widget/page_indicator.dart';
import 'package:senior_project/user_authentication/role_selection_page/view/widget/card_selection.dart';
import 'package:senior_project/user_authentication/role_selection_page/view/widget/confirm_button.dart';

class RoleSelectionPage extends StatelessWidget {
  const RoleSelectionPage({super.key});
  final double widgetWidth = 580;

  // TODO edit breakpoint to view model
  static const double mobileWidthBreakpoint = 430;
  final double textBreakpoint = 620;

  Widget pageDetail(bool isMobileSite, bool isTextBreakpoint) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: Text(
            "Selec Your Role",
            style: TextStyle(
              fontFamily: Constant.font,
              fontWeight: FontWeight.w700,
              fontSize: isMobileSite ? 28 : 32,
              color: isMobileSite ? Constant.whiteBlack80 : Constant.orange70
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(
            0, 
            40, 
            0, 
            isMobileSite ? 8 : 16
          ),
          child: CardSelection(
            isStudentCard: true, 
            isMobileSite: isMobileSite,
            isTextBreakpoint: isTextBreakpoint,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 24),
          child: CardSelection(
            isStudentCard: false,
            isMobileSite: isMobileSite,  
            isTextBreakpoint: isTextBreakpoint,
          ),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ConfirmButton.button(false, isMobileSite),
            const Spacer(),
            ConfirmButton.button(true, isMobileSite),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO edit breakpoint to view model
    final bool isMobileSite = MediaQuery.of(context).size.width <= mobileWidthBreakpoint; 
    final bool isTextBreakpoint = MediaQuery.of(context).size.width <= textBreakpoint; 

    // TODO desktop templete
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 80),
            child: PageIndicator(
              width: isMobileSite ? 178 : 200,
              isMobileSize: isMobileSite,
            ),
          ),
          Builder(
            builder: (context) {
              if (isMobileSite) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: pageDetail(isMobileSite, isTextBreakpoint),
                );
              }
              return BackPlateWidgetDesktop.widget(
                context,
                {
                  "width": 630, 
                  "height": isTextBreakpoint 
                    ? MediaQuery.of(context).size.height * 0.715
                    : MediaQuery.of(context).size.height * 0.63,
                },
                pageDetail(isMobileSite, isTextBreakpoint)
              );
            }
          ),
        ],
      ),
    );
  }
}