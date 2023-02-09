import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senior_project/assets/color_constant.dart';
import 'package:senior_project/core/template_desktop/view/page/template_desktop.dart';
import 'package:senior_project/core/template_mobile/view/template_menu_mobile.dart';
import 'package:senior_project/core/view_model/app_view_model.dart';
import 'package:senior_project/user_authentication/core/widget/desktop/back_plate_desktop.dart';
import 'package:senior_project/user_authentication/core/widget/page_indicator.dart';
import 'package:senior_project/user_authentication/role_selection_page/view/widget/card_selection.dart';
import 'package:senior_project/user_authentication/role_selection_page/view/widget/confirm_button.dart';
import 'package:senior_project/user_authentication/role_selection_page/view_model/role_selection_view_model.dart';

class RoleSelectionPage extends StatelessWidget {
  const RoleSelectionPage({super.key});
  final double widgetWidth = 580;

  Widget pageDetail(BuildContext context, bool isMobileSite, double screenWidth) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: double.infinity,
          child: Text(
            "Selec Your Role",
            textAlign: isMobileSite ? TextAlign.center : TextAlign.start,
            style: TextStyle(
              fontFamily: ColorConstant.font,
              fontWeight: FontWeight.w700,
              fontSize: isMobileSite ? 28 : 32,
              color: isMobileSite ? ColorConstant.whiteBlack80 : ColorConstant.orange70
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
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 24),
          child: CardSelection(
            isStudentCard: false,
            isMobileSite: isMobileSite,  
          ),
        ),
        Builder(
          builder: (context) {
            if (screenWidth <= 320 ) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: ConfirmButton.button(context, false, isMobileSite, double.infinity),
                  ),
                  ConfirmButton.button(context, true, isMobileSite, double.infinity),
                ],
              );
            } 
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ConfirmButton.button(context, false, isMobileSite, isMobileSite ? 140 : 180),
                const Spacer(),
                ConfirmButton.button(context, true, isMobileSite, isMobileSite ? 140 : 180,),
              ],
            );
          },
        ),
       
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    context.read<AppViewModel>().selectView(MediaQuery.of(context).size.width);
    bool isMobileSite = context.watch<AppViewModel>().getMobileSiteState;
    double screenWidth = MediaQuery.of(context).size.width;

    return Builder(
      builder: (context) {
        if (isMobileSite) {
          return TemplateMenuMobile(
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 40),
                  child: PageIndicator(
                    isMobileSize: isMobileSite,
                    indicatorsState: const [true, true],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: pageDetail(context, isMobileSite, screenWidth),
                ),
              ],
            ),
          );
        }
        return TemplateDesktop(
          faqmenu: false, 
          faqmenuadmin: false, 
          helpdesk: false, 
          helpdeskadmin: false, 
          home: false, 
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 40),
                child: PageIndicator(
                  isMobileSize: isMobileSite,
                  indicatorsState: const [true, true],
                ),
              ),
              BackPlateWidgetDesktop.widget(
                context,
                {
                  "width": 630, 
                  "height": 600
                },
                pageDetail(context, isMobileSite, screenWidth)
              )
            ],
          ),
        );
      },
    );
  }
}