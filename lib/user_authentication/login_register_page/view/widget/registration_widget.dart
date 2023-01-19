import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:senior_project/assets/constant.dart';
import 'package:senior_project/user_authentication/login_register_page/view/widget/additional_login_button.dart';
import 'package:senior_project/user_authentication/login_register_page/view/widget/primary_button_authentication.dart';
import 'package:senior_project/user_authentication/login_register_page/view/widget/text_field_authentication.dart';

class RegistrationWidget extends StatelessWidget {
  final bool isMobileSite;
  const RegistrationWidget({super.key, required this.isMobileSite});

  @override
  Widget build(BuildContext context) {
    String welcomeText = "Let’s get you to my website and\nyou can send the task to admin for help.";

    return Column(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Sign up",
              style: TextStyle(
                color: isMobileSite ? Constant.whiteBlack80 : Constant.orange90,
                fontFamily: Constant.font,
                fontWeight: FontWeight.w600,
                fontSize: isMobileSite ? 28 : 40
              ),
            ),
            Builder(
              builder: (context) {
                if (isMobileSite) {
                  return Container();
                }
                return Padding(
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
                );
              }
            ),
            Padding(
              padding: EdgeInsets.only(top: isMobileSite ? 40 : 24),
              child: TextFieldAuthentication.widget("Username", false),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: TextFieldAuthentication.widget("Email", false),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: TextFieldAuthentication.widget("Password", true),
            ),
            Padding(
              padding: EdgeInsets.only(top: isMobileSite ? 24 : 56),
              child: PrimaryButtonAuthentication.widget(true, isMobileSite)
            ),
            Padding(
              padding: EdgeInsets.only(top: isMobileSite ? 92 : 64),
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
              padding: const EdgeInsets.only(top: 24),
              child: AdditionalLoginButton.widget(true, isMobileSite),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: AdditionalLoginButton.widget(false, isMobileSite),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "Already have an account ",
                      style: TextStyle(
                        color: Constant.whiteBlack40,
                        fontFamily: Constant.font,
                        fontWeight: FontWeight.w400,
                        fontSize: isMobileSite ? 12 : 14
                      )
                    ),
                    TextSpan(
                      text: "Log in",
                      style: TextStyle(
                        color: Constant.orange90,
                        fontFamily: Constant.font,
                        fontWeight: FontWeight.w500,
                        fontSize: isMobileSite ? 12 : 14
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
      ],
    );  
  }
}