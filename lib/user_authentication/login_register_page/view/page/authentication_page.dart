import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senior_project/core/template_desktop/view/page/template_desktop.dart';
import 'package:senior_project/core/template_mobile/view/template_menu_mobile.dart';
import 'package:senior_project/core/view_model/app_view_model.dart';
import 'package:senior_project/user_authentication/core/widget/page_indicator.dart';
import 'package:senior_project/user_authentication/core/widget/desktop/back_plate_desktop.dart';
import 'package:senior_project/user_authentication/login_register_page/view/widget/login_widget.dart';
import 'package:senior_project/user_authentication/login_register_page/view/widget/registration_widget.dart';
import 'package:senior_project/user_authentication/login_register_page/view_model/authentication_view_model.dart';

class AuthenticationPage extends StatefulWidget {
  const AuthenticationPage({super.key});

  @override
  State<AuthenticationPage> createState() => _AuthenticationPage();
}

class _AuthenticationPage extends State<AuthenticationPage> {

  double _indicatorWidth(double pixelWidth) {
    if (pixelWidth <= 350 && pixelWidth > 250) {
      return -50;
    } 
    if (pixelWidth <= 250) {
      return -70;
    }
    return 0;
  }

  Widget loginSite(bool isMobileSite) {
    if (isMobileSite) {
      return TemplateMenuMobile(
        content: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: LoginWidget(isMobileSite: isMobileSite,),
        )
      );
    }
    return TemplateDesktop(
      faqmenu: false, 
      faqmenuadmin: false, 
      helpdesk: false, 
      helpdeskadmin: false, 
      home: false, 
      content: Center(
        child: BackPlateWidgetDesktop.widget(
          context, 
          {"width": 502, "height": 750,},
          LoginWidget(isMobileSite: isMobileSite,)
        ),
      )
    );
  }

  Widget registerSite(bool isMobileSite, double pixelWidth) {
    if (isMobileSite) {
      return TemplateMenuMobile(
        content: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              PageIndicator(
                width: isMobileSite ? 178 + _indicatorWidth(pixelWidth) : 200, 
                isMobileSize: isMobileSite,
                indicatorsState: const [true, false],
              ),
              RegistrationWidget(isMobileSite: isMobileSite,)
            ],
          ),
        )
      );
    }
    return TemplateDesktop(
      faqmenu: false, 
      faqmenuadmin: false, 
      helpdesk: false, 
      helpdeskadmin: false, 
      home: false, 
      content: Column(
        children: [
          PageIndicator(
            width: isMobileSite ? 178 : 200, 
            isMobileSize: isMobileSite, 
            indicatorsState: const [true, false],
          ),
          BackPlateWidgetDesktop.widget(
            context, 
            {"width": 502, "height": 730},
            RegistrationWidget(isMobileSite: isMobileSite,)
          ),
        ],
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    context.read<AppViewModel>().selectView(MediaQuery.of(context).size.width);
    bool isMobileSite = context.watch<AppViewModel>().getMobileSiteState;
    bool isLoginPage = context.watch<AuthenticationViewModel>().getPageState;
    
    return Builder(
      builder: (BuildContext context) {
        if (isLoginPage) {
          return loginSite(isMobileSite);
        }
        return registerSite(isMobileSite, MediaQuery.of(context).size.width);
      },
    );
  }
}