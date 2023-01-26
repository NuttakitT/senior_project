import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:senior_project/assets/color_constant.dart';
import 'package:senior_project/user_authentication/login_register_page/view_model/authentication_view_model.dart';

class AdditionalLoginButton {
  static TextStyle _style(bool isFacebookLogin, bool isMobileSite) => TextStyle(
    fontFamily: ColorConstant.font,
    fontWeight: FontWeight.w400,
    fontSize: isMobileSite ? 14 : 16,
    color: isFacebookLogin ? Colors.white : ColorConstant.whiteBlack60
  );

  static Widget widget(BuildContext context, bool isFacebookLogin, bool isMobileSite) {
    return SizedBox(
      height: isMobileSite ? 32 : 40,
      width: double.infinity,
      child: TextButton(
        onPressed: () async {
          bool isSuccess = isFacebookLogin 
            ? await context.read<AuthenticationViewModel>().facebookSignIn()
            : await context.read<AuthenticationViewModel>().googleSignIn();
          if (isSuccess) {
            // TODO link to main page
            print("${FirebaseAuth.instance.currentUser?.email}");
          } 
        }, 
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(
            isFacebookLogin 
              ? ColorConstant.facebookColor
              : Colors.white
          ),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8)
            )
          )
        ),
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
              ]
        )
      ),
    );
  }
}