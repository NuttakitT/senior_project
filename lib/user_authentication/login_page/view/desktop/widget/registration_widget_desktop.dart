import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:senior_project/assets/constant.dart';
import 'package:senior_project/user_authentication/login_page/core/widget/desktop/additional_login_button_desktop.dart';
import 'package:senior_project/user_authentication/login_page/core/widget/desktop/back_plate_desktop.dart';
import 'package:senior_project/user_authentication/login_page/core/widget/desktop/page_indicator_desktop.dart';
import 'package:senior_project/user_authentication/login_page/core/widget/desktop/primary_button_authentication_desktop.dart';
import 'package:senior_project/user_authentication/login_page/core/widget/desktop/text_field_authentication_desktop.dart';

class RegistrationWidgetDesktop extends StatelessWidget {
  const RegistrationWidgetDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    String welcomeText = "Let’s get you to my website and\nyou can send the task to admin for help.";

    return Column(
      children: [
        PageIndicatorDesktop.widget(),
        BackPlateWidgetDesktop.widget( 
          context,
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "Sign up",
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
                padding: const EdgeInsets.only(top: 24),
                child: TextFieldAuthenticationDesktop.widget("Username", false),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: TextFieldAuthenticationDesktop.widget("Email", false),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: TextFieldAuthenticationDesktop.widget("Password", true),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 56),
                child: PrimaryButtonAuthenticationDesktop.widget(true)
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
                        text: "Already have an account ",
                        style: TextStyle(
                          color: Constant.whiteBlack40,
                          fontFamily: Constant.font,
                          fontWeight: FontWeight.w400,
                          fontSize: 14
                        )
                      ),
                      TextSpan(
                        text: "Log in",
                        style: const TextStyle(
                          color: Constant.orange90,
                          fontFamily: Constant.font,
                          fontWeight: FontWeight.w500,
                          fontSize: 14
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            // TODO link to log in
                          }
                      )
                    ]
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );  
  }
}