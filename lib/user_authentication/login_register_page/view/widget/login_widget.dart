import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senior_project/assets/color_constant.dart';
import 'package:senior_project/user_authentication/login_register_page/view/widget/additional_login_button.dart';
import 'package:senior_project/user_authentication/login_register_page/view/widget/primary_button_authentication.dart';
import 'package:senior_project/user_authentication/login_register_page/view/widget/text_field_authentication.dart';
import 'package:senior_project/user_authentication/login_register_page/view_model/authentication_view_model.dart';

class LoginWidget extends StatelessWidget {
  final bool isMobileSite;
  const LoginWidget({super.key, required this.isMobileSite});

  @override
  Widget build(BuildContext context) {
    String welcomeText = "Welcome back! Please login to your account.\nSo you can send task to admin.";
    
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "Log in",
          style: TextStyle(
            color: isMobileSite ? ColorConstant.whiteBlack80 : ColorConstant.orange90,
            fontFamily: ColorConstant.font,
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
                  color: ColorConstant.whiteBlack60,
                  fontFamily: ColorConstant.font,
                  fontWeight: FontWeight.w400,
                  fontSize: 18
                ),
              )
            );
          }
        ),
        Padding(
          padding: EdgeInsets.only(top: isMobileSite ? 40 : 56),
          child: const TextFieldAuthentication(
            hintMode: 1, 
            isPasswordField: false
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(top: 16),
          child: TextFieldAuthentication(
            hintMode: 2, 
            isPasswordField: true
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: isMobileSite ? 80 : 64),
          child: PrimaryButtonAuthentication.widget(context, true, isMobileSite)
        ),
        Padding(
          padding: const EdgeInsets.only(top: 16),
          child: RichText(
            text: TextSpan(
              text: "Forgot password?",
              style: const TextStyle(
                color: ColorConstant.whiteBlack40,
                fontFamily: ColorConstant.font,
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
          padding: EdgeInsets.only(top: isMobileSite ? 56 : 64),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Container(
                  height: 1,
                  color: ColorConstant.whiteBlack30,
                ),
              ),
              const Divider(),
              const Padding(
                padding: EdgeInsets.fromLTRB(12.5, 10, 12.5, 10),
                child: Text(
                  "or",
                  style: TextStyle(
                    color: ColorConstant.whiteBlack30,
                  fontFamily: ColorConstant.font,
                  fontWeight: FontWeight.w400,
                  fontSize: 16
                  ),
                ),
              ),
              const Divider(),
              Expanded(
                child: Container(
                  height: 1,
                  color: ColorConstant.whiteBlack30,
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
                  text: "Don't have an account? ",
                  style: TextStyle(
                    color: ColorConstant.whiteBlack40,
                    fontFamily: ColorConstant.font,
                    fontWeight: FontWeight.w400,
                    fontSize: isMobileSite ? 12 : 14
                  )
                ),
                TextSpan(
                  text: "Sign up",
                  style: TextStyle(
                    color: ColorConstant.orange90,
                    fontFamily: ColorConstant.font,
                    fontWeight: FontWeight.w500,
                    fontSize: isMobileSite ? 12 : 14
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      context.read<AuthenticationViewModel>().changeViewState();
                    }
                )
              ]
            ),
          ),
        ),
      ],
    );  
  }
}