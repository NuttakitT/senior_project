import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:senior_project/assets/constant.dart';
import 'package:senior_project/user_authentication/login_page/view/desktop/widget/additional_login_button_desktop.dart';
import 'package:senior_project/user_authentication/login_page/view/desktop/widget/back_plate_desktop.dart';
import 'package:senior_project/user_authentication/login_page/view/desktop/widget/primary_button_authentication_desktop.dart';
import 'package:senior_project/user_authentication/login_page/view/desktop/widget/text_field_authentication_desktop.dart';

class LoginWidgetDesktop extends StatelessWidget {
  const LoginWidgetDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    String welcomeText = "Welcome back!  Please login to your account.\nSo you can send task to admin.";

    return BackPlateWidgetDesktop.widget( 
      context,
      Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            "Log in",
            style: TextStyle(
              color: Constant.orange90,
              fontFamily: Constant.font,
              fontWeight: FontWeight.w600,
              fontSize: 40
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 24),
            child: Text(
              welcomeText,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Constant.whiteBlack60,
                fontFamily: Constant.font,
                fontWeight: FontWeight.w400,
                fontSize: 18
              ),
            )
          ),
          Padding(
            padding: const EdgeInsets.only(top: 56),
            child: TextFieldAuthenticationDesktop.widget("Username or Mail", false),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16),
            child: TextFieldAuthenticationDesktop.widget("Password", true),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 64),
            child: PrimaryButtonAuthenticationDesktop.widget(true)
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16),
            child: RichText(
              text: TextSpan(
                text: "Forgot password?",
                style: const TextStyle(
                  color: Constant.whiteBlack40,
                  fontFamily: Constant.font,
                  fontWeight: FontWeight.w400,
                  fontSize: 16
                ),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    // TODO link to forget password
                  }
              ),
            )
          ),
          Padding(
            padding: const EdgeInsets.only(top: 84),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Container(
                    height: 1,
                    color: Constant.whiteBlack30,
                  ),
                ),
                const Divider(),
                const Padding(
                  padding: EdgeInsets.fromLTRB(12.5, 10, 12.5, 10),
                  child: Text(
                    "or",
                    style: TextStyle(
                      color: Constant.whiteBlack30,
                    fontFamily: Constant.font,
                    fontWeight: FontWeight.w400,
                    fontSize: 16
                    ),
                  ),
                ),
                const Divider(),
                Expanded(
                  child: Container(
                    height: 1,
                    color: Constant.whiteBlack30,
                  ),
                )
              ],
            )
          ),
          Padding(
            padding: const EdgeInsets.only(top: 43),
            child: AdditionalLoginButtonDesktop.widget(true),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16),
            child: AdditionalLoginButtonDesktop.widget(false),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16),
            child: RichText(
              text: TextSpan(
                children: [
                  const TextSpan(
                    text: "Don't have an account? ",
                    style: TextStyle(
                      color: Constant.whiteBlack40,
                      fontFamily: Constant.font,
                      fontWeight: FontWeight.w400,
                      fontSize: 14
                    )
                  ),
                  TextSpan(
                    text: "Sign up",
                    style: const TextStyle(
                      color: Constant.orange90,
                      fontFamily: Constant.font,
                      fontWeight: FontWeight.w500,
                      fontSize: 14
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        // TODO link to sign up
                      }
                  )
                ]
              ),
            ),
          ),
        ],
      ),
    );  
  }
}