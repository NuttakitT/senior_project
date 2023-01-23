import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senior_project/core/view_model/app_view_model.dart';
import 'package:senior_project/user_authentication/core/widget/page_indicator.dart';
import 'package:senior_project/user_authentication/core/widget/desktop/back_plate_desktop.dart';
import 'package:senior_project/user_authentication/login_register_page/view/widget/login_widget.dart';
import 'package:senior_project/user_authentication/login_register_page/view/widget/registration_widget.dart';
import 'package:senior_project/user_authentication/login_register_page/view_model/page_view_model.dart';

class AuthenticationPage extends StatefulWidget {
  const AuthenticationPage({super.key});

  @override
  State<AuthenticationPage> createState() => _AuthenticationPage();
}

class _AuthenticationPage extends State<AuthenticationPage> {

  Widget loginSite(bool isMobileSite) {
    if (isMobileSite) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: LoginWidget(isMobileSite: isMobileSite,),
      );
    }
    return BackPlateWidgetDesktop.widget(
      context, 
      {"width": 502, "height": MediaQuery.of(context).size.height * 0.8,},
      LoginWidget(isMobileSite: isMobileSite,)
    );
  }

  Widget registerSite(bool isMobileSite) {
    if (isMobileSite) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            PageIndicator(
              width: isMobileSite ? 178 : 200, 
              isMobileSize: isMobileSite,
              indicatorsState: const [true, false],
            ),
            RegistrationWidget(isMobileSite: isMobileSite,)
          ],
        ),
      );
    }
    return Column(
      children: [
        PageIndicator(
          width: isMobileSite ? 178 : 200, 
          isMobileSize: isMobileSite, 
          indicatorsState: const [true, false],
        ),
        BackPlateWidgetDesktop.widget(
          context, 
          {"width": 502, "height": MediaQuery.of(context).size.height * 0.8,},
          RegistrationWidget(isMobileSite: isMobileSite,)
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    context.read<AppViewModel>().selectView(MediaQuery.of(context).size.width);
    bool isMobileSite = context.watch<AppViewModel>().getMobileSiteState;
    bool isLoginPage = context.watch<PageViewModel>().getPageState;
    
    // TODO templete
    return Builder(
      builder: (BuildContext context) {
        if (isLoginPage) {
          return loginSite(isMobileSite);
        }
        return registerSite(isMobileSite);
      },
    );
  }
}