import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senior_project/assets/color_constant.dart';
import 'package:senior_project/assets/font_style.dart';
import 'package:senior_project/core/template/template_desktop/view/page/template_desktop.dart';
import 'package:senior_project/core/template/template_mobile/view/template_menu_mobile.dart';
import 'package:senior_project/core/view_model/app_view_model.dart';
import 'package:senior_project/help_desk/help_desk_main/view/desktop/body.dart';
import 'package:senior_project/help_desk/help_desk_main/view/desktop/header.dart';
import 'package:senior_project/help_desk/help_desk_main/view/mobile/mobile_widget.dart';
import 'package:senior_project/help_desk/help_desk_main/view_model/help_desk_view_model.dart';

class HelpDeskMainView extends StatefulWidget {
  final bool isAdmin;
  const HelpDeskMainView({super.key, required this.isAdmin});

  @override
  State<HelpDeskMainView> createState() => _HelpDeskMainViewState();
}

class _HelpDeskMainViewState extends State<HelpDeskMainView> {

  @override
  Widget build(BuildContext context) {
    bool isMobileSite = context.watch<AppViewModel>().getMobileSiteState(MediaQuery.of(context).size.width);
    double screenHeight = MediaQuery.of(context).size.height;
    int? role = context.watch<AppViewModel>().app.getUser.getRole;
    bool isLogin = context.watch<AppViewModel>().isLogin;
    context.read<HelpDeskViewModel>().setIsMobile = isMobileSite;

    return FutureBuilder(
      future: context.read<HelpDeskViewModel>().initTicketCategory(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
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
            helpdesk: !widget.isAdmin,
            helpdeskadmin: widget.isAdmin,
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
                return Container(
                  alignment: AlignmentDirectional.topCenter,
                  child: Builder(
                    builder: (context) {
                      if (screenHeight < 500) {
                        return SingleChildScrollView(
                          child: Column(
                            children: [
                              Header.widget(context, widget.isAdmin),
                              const Body(isAdmin: true,)
                            ],
                          ),
                        );
                      }
                      return Column(
                        children: [
                          Header.widget(context, widget.isAdmin),
                          Body(isAdmin: widget.isAdmin,)
                        ],
                      );
                    }
                  ),
                );
              }
            )
          );
        }
        return Container();
      },
    );
  }
}
