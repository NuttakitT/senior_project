import 'package:flutter/cupertino.dart';
import 'package:senior_project/user_authentication/core/widget/page_indicator.dart';
import 'package:senior_project/user_authentication/core/widget/desktop/back_plate_desktop.dart';
import 'package:senior_project/user_authentication/login_register_page/view/widget/login_widget.dart';
import 'package:senior_project/user_authentication/login_register_page/view/widget/registration_widget.dart';

class AuthenticationPage extends StatefulWidget {
  const AuthenticationPage({super.key});

  @override
  State<AuthenticationPage> createState() => _AuthenticationPage();
}

class _AuthenticationPage extends State<AuthenticationPage> {
  // TODO edit breakpoint to view model
  static const double mobileWidthBreakpoint = 430;

  @override
  Widget build(BuildContext context) {
    // TODO edit breakpoint to view model
    final bool isMobileSite = MediaQuery.of(context).size.width <= mobileWidthBreakpoint; 

    // TODO desktop templete / edit breakpoint to view model
    return Builder(
      builder: (BuildContext context) {
        if (isMobileSite) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                PageIndicator(
                  width: isMobileSite ? 160 : 200, 
                  isMobileSize: isMobileSite,
                ),
                RegistrationWidget(isMobileSite: isMobileSite,)
              ],
            ),
          );
        }
        return Column(
          children: [
            PageIndicator(
              width: isMobileSite ? 160 : 200, 
              isMobileSize: isMobileSite,
            ),
            BackPlateWidgetDesktop.widget(
              context, 
              {"width": 502, "height": MediaQuery.of(context).size.height * 0.8,},
              RegistrationWidget(isMobileSite: isMobileSite,)
            ),
          ],
        );
      },
    );
  }
}

// * register page
// if (isMobileSite) {
//           return Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 16),
//             child: Column(
//               children: [
//                 PageIndicator(
//                   width: isMobileSite ? 178 : 200, 
//                   isMobileSize: isMobileSite,
//                 ),
//                 const RegistrationWidget(isMobileSite: isMobileSite,)
//               ],
//             ),
//           );
//         }
//         return Column(
//           children: [
//             PageIndicator(
//               width: isMobileSite ? 178 : 200, 
//               isMobileSize: isMobileSite,
//             ),
//             BackPlateWidgetDesktop.widget(
//               context, 
//               const RegistrationWidget(isMobileSite: isMobileSite,)
//             ),
//           ],
//         );