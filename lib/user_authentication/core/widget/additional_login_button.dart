import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:senior_project/assets/constant.dart';

class AdditionalLoginButton {
  static TextStyle _style(bool isFacebookLogin) => const TextStyle(
    fontFamily: Constant.font,
    fontWeight: FontWeight.w400,
    fontSize: 16,
    color: Colors.white
  );

  static Widget widget(bool isFacebookLogin) {
    return SizedBox(
      height: 40,
      width: double.infinity,
      child: TextButton(
        onPressed: () {}, 
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
                  FontAwesomeIcons.facebook
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.5),
                  child: Text(
                      "Login with Facebook", 
                      style: _style(true),
                    ),
                ) 
              ]
            : [
                const Icon(
                  FontAwesomeIcons.google
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.5),
                  child: Text(
                      "Login with Google", 
                      style: _style(true),
                    ),
                ) 
              ]
        )
      ),
    );
  }
}