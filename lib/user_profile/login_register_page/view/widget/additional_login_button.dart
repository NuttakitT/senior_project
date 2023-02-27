import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:senior_project/assets/color_constant.dart';
import 'package:senior_project/assets/font_style.dart';
import 'package:senior_project/help_desk/help_desk_main/view/page/help_desk_main_view.dart';
import 'package:senior_project/user_profile/login_register_page/view_model/authentication_view_model.dart';

class AdditionalLoginButton {
  static TextStyle _style(bool isFacebookLogin, bool isMobileSite) {
    if (isFacebookLogin) {
      return isMobileSite ? AppFontStyle.whiteR14 : AppFontStyle.whiteR16;
    } else {
      return isMobileSite ? AppFontStyle.wb60R14 : AppFontStyle.wb60R16;
    }
  }

  static Widget widget(
      BuildContext context, bool isFacebookLogin, bool isMobileSite) {
    return SizedBox(
      height: isMobileSite ? 32 : 40,
      width: double.infinity,
      child: TextButton(
          onPressed: () async {
            bool isSuccess = isFacebookLogin
                ? await context
                    .read<AuthenticationViewModel>()
                    .facebookSignIn(context)
                : await context
                    .read<AuthenticationViewModel>()
                    .googleSignIn(context);
            if (isSuccess) {
              // TODO link to main page
              // ignore: use_build_context_synchronously
              Navigator.pushAndRemoveUntil(
                context, 
                MaterialPageRoute(builder: (context) {
                  return const HelpDeskMainView(isAdmin: false);
                }), 
                (route) => false
              );
            }
          },
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                  isFacebookLogin ? ColorConstant.facebookColor : Colors.white),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8))),
              side: MaterialStateProperty.all(isFacebookLogin
                  ? null
                  : const BorderSide(color: ColorConstant.whiteBlack40))),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: isFacebookLogin
                  ? [
                      const Icon(
                        FontAwesomeIcons.facebook,
                        color: Colors.white,
                        size: 19,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.5),
                        child: Text(
                          "Login with Facebook",
                          style: _style(true, isMobileSite),
                        ),
                      )
                    ]
                  : [
                      const Icon(
                        FontAwesomeIcons.google,
                        color: Colors.black,
                        size: 19,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.5),
                        child: Text(
                          "Login with Google",
                          style: _style(false, isMobileSite),
                        ),
                      )
                    ])),
    );
  }
}
