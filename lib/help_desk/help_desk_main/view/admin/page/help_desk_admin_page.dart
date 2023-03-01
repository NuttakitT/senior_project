import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senior_project/assets/color_constant.dart';
import 'package:senior_project/assets/font_style.dart';
import 'package:senior_project/core/template_desktop/view/page/template_desktop.dart';
import 'package:senior_project/core/template_mobile/view/template_menu_mobile.dart';
import 'package:senior_project/core/view_model/app_view_model.dart';
import 'package:senior_project/help_desk/help_desk_main/view/admin/widget/desktop_widget.dart';
import 'package:senior_project/help_desk/help_desk_main/core/widget/mobile/mobile_widget.dart';

class HelpDeskAdminPage extends StatefulWidget {
  const HelpDeskAdminPage({super.key});

  @override
  State<HelpDeskAdminPage> createState() => _HelpDeskAdminPageState();
}

class _HelpDeskAdminPageState extends State<HelpDeskAdminPage> {
  @override
  Widget build(BuildContext context) {
    context.read<AppViewModel>().selectView(MediaQuery.of(context).size.width);
    bool isMobileSite = context.watch<AppViewModel>().getMobileSiteState;
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
      faqmenu: false,
      faqmenuadmin: false,
      helpdesk: false,
      helpdeskadmin: true,
      home: false,
      useTemplatescroll: false,
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
          return const Align(
              alignment: AlignmentDirectional.topCenter, 
              child: DesktopWidget()
          );
        }
      )
    );
  }
}
