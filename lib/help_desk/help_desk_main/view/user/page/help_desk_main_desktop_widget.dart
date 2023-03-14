import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senior_project/assets/color_constant.dart';
import 'package:senior_project/assets/font_style.dart';
import 'package:senior_project/core/template_desktop/view/page/template_desktop.dart';
import 'package:senior_project/core/template_mobile/view/template_menu_mobile.dart';
import 'package:senior_project/core/view_model/app_view_model.dart';
import 'package:senior_project/help_desk/help_desk_main/view/widget/mobile/mobile_widget.dart';
import 'package:senior_project/help_desk/help_desk_main/view/user/widget/help_desk_desktop_header_widget.dart';
import '../widget/help_desk_desktop_body_widget.dart';

class HelpDeskMainDesktopWidget extends StatefulWidget {
  const HelpDeskMainDesktopWidget({super.key});

  @override
  State<HelpDeskMainDesktopWidget> createState() => _HelpDeskMainDesktopWidgetState();
}

class _HelpDeskMainDesktopWidgetState extends State<HelpDeskMainDesktopWidget> {
  @override
  Widget build(BuildContext context) {
    bool isMobileSite = context.watch<AppViewModel>().getMobileSiteState(MediaQuery.of(context).size.width);
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    int? role = context.watch<AppViewModel>().app.getUser.getRole;
    bool isLogin = context.watch<AppViewModel>().isLogin;

    if (isMobileSite) {
      return TemplateMenuMobile(
          content: Builder(
            builder: (context) {
              if (!isLogin) {
                return const Center(
                  child: Text(
                    "Please login to use the services",
                    style: TextStyle(
                      color: ColorConstant.orange60,
                      fontWeight: FontWeight.w400,
                      fontFamily: AppFontStyle.font,
                      fontSize: 18
                    ),
                  ),
                );
              }
              return MobileWidget(
        isAdmin: role == 0 ? true : false,
      );
            }
          ));
    }
    return TemplateDesktop(
        helpdesk: true,
        helpdeskadmin: false,
        home: false,
        useTemplatescroll: true,
        content: Builder(
          builder: (context) {
            if (!isLogin) {
              return const Center(
                child: Text(
                  "Please login to use the services",
                  style: TextStyle(
                    color: ColorConstant.orange60,
                    fontWeight: FontWeight.w400,
                    fontFamily: AppFontStyle.font,
                    fontSize: 24
                  ),
                ),
              );
              }
            return Container(
              constraints: BoxConstraints(
                  maxWidth: screenWidth,
                  minWidth: 200,
                  maxHeight: screenHeight - 155),
              alignment: AlignmentDirectional.topCenter,
              child: ListView(
                children: [
                  HelpDeskDesktopHeader.widget(context),
                  const HelpDeskDesktopBody()
                ],
              ),
            );
          }
        ));
  }
}
