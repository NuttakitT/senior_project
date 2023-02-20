import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senior_project/assets/color_constant.dart';
import 'package:senior_project/assets/font_style.dart';
import 'package:senior_project/user_authentication/login_register_page/view/widget/additional_login_button.dart';
import 'package:senior_project/user_authentication/login_register_page/view/widget/primary_button_authentication.dart';
import 'package:senior_project/user_authentication/login_register_page/view/widget/text_field_authentication.dart';
import 'package:senior_project/user_authentication/login_register_page/view_model/authentication_view_model.dart';

class LoginWidget extends StatelessWidget {
  final bool isMobileSite;
  const LoginWidget({super.key, required this.isMobileSite});

  @override
  Widget build(BuildContext context) {
    String welcomeText =
        "Welcome back! Please login to your account.\nSo you can send task to admin.";

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.only(top: isMobileSite ? 40 : 0),
          child: Text(
            "Log in",
            style: isMobileSite
                ? AppFontStyle.orange70SemiB28
                : AppFontStyle.orange90SemiB40,
          ),
        ),
        Builder(builder: (context) {
          if (isMobileSite) {
            return Container();
          }
          return Padding(
              padding: const EdgeInsets.only(top: 24),
              child: Text(
                welcomeText,
                textAlign: TextAlign.center,
                style: AppFontStyle.wb60R18,
              ));
        }),
        Padding(
          padding: EdgeInsets.only(top: isMobileSite ? 40 : 56),
          child: const TextFieldAuthentication(
            hintMode: 1,
            isPasswordField: false,
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(top: 16),
          child: TextFieldAuthentication(
            hintMode: 2,
            isPasswordField: true,
          ),
        ),
        Padding(
            padding: EdgeInsets.only(top: isMobileSite ? 80 : 64),
            child: PrimaryButtonAuthentication(
                isLoginPage: true, isMobileSite: isMobileSite)),
        Padding(
            padding: const EdgeInsets.only(top: 16),
            child: RichText(
              text: TextSpan(
                  text: "Forgot password?",
                  style: AppFontStyle.wb40R16,
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      // TODO link to forget password
                    }),
            )),
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
                    style: AppFontStyle.wb30R16,
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
            )),
        Padding(
          padding: const EdgeInsets.only(top: 24),
          child: AdditionalLoginButton.widget(context, true, isMobileSite),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 16),
          child: AdditionalLoginButton.widget(context, false, isMobileSite),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 16),
          child: RichText(
            text: TextSpan(children: [
              TextSpan(
                  text: "Don't have an account? ",
                  style: isMobileSite
                      ? AppFontStyle.wb40R12
                      : AppFontStyle.wb40R14),
              TextSpan(
                  text: "Sign up",
                  style: isMobileSite
                      ? AppFontStyle.orange90Md12
                      : AppFontStyle.orange90Md14,
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      context.read<AuthenticationViewModel>().clearModel();
                      context.read<AuthenticationViewModel>().clearErrorText();
                      context
                          .read<AuthenticationViewModel>()
                          .clearIsEmptyUsername();
                      context
                          .read<AuthenticationViewModel>()
                          .clearIsEmptyEmail();
                      context
                          .read<AuthenticationViewModel>()
                          .clearIsEmptyPassword();
                      context
                          .read<AuthenticationViewModel>()
                          .changeShowPageState();
                    })
            ]),
          ),
        ),
      ],
    );
  }
}
