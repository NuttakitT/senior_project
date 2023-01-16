import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:senior_project/assets/constant.dart';
import 'package:senior_project/user_authentication/core/widget/additional_login_button.dart';
import 'package:senior_project/user_authentication/core/widget/back_plate.dart';
import 'package:senior_project/user_authentication/core/widget/primary_button_authentication.dart';
import 'package:senior_project/user_authentication/core/widget/text_field_authentication.dart';

class LoginWidget extends StatelessWidget {
  const LoginWidget({super.key});

  @override
  Widget build(BuildContext context) {
    String welcomeText = "Welcome back!  Please login to your account.\nSo you can send task to admin.";

    return BackPlateWidget.widget( 
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
            child: TextFieldAuthentication.widget("Username or Mail", false),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16),
            child: TextFieldAuthentication.widget("Password", true),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 64),
            child: PrimaryButtonAuthentication.widget(true)
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
            child: AdditionalLoginButton.widget(true),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16),
            child: AdditionalLoginButton.widget(false),
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