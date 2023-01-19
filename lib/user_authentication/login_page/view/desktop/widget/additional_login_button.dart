import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:senior_project/assets/constant.dart';

class AdditionalLoginButton {
  static TextStyle _style(bool isFacebookLogin, bool isMobileSite) => TextStyle(
    fontFamily: Constant.font,
    fontWeight: FontWeight.w400,
    fontSize: isMobileSite ? 14 : 16,
    color: isFacebookLogin ? Colors.white : Constant.whiteBlack60
  );

  static Widget widget(bool isFacebookLogin, bool isMobileSite) {
    return SizedBox(
      height: isMobileSite ? 32 : 40,
      width: double.infinity,
      child: TextButton(
        onPressed: () {
          // TODO additional login logic
        }, 
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(
            isFacebookLogin 
              ? Constant.facebookColor
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