import 'package:flutter/material.dart';
import 'package:senior_project/assets/constant.dart';

class PrimaryButtonAuthentication {
  static TextStyle _style(bool isMobileSite) =>  TextStyle(
    fontFamily: Constant.font,
    fontWeight: FontWeight.w600,
    fontSize: isMobileSite ? 16 : 20,
    color: Colors.white
  );

  static Widget widget(bool isLoginPage, bool isMobileSite) {
    return SizedBox(
      height: 40,
      width: double.infinity,
      child: TextButton(
        onPressed: () {
          // TODO login/register logic
        }, 
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Constant.orange40),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8)
            )
          )
        ),
        child: isLoginPage 
          ? Text("Login", style: _style(isMobileSite),) 
          : Text("Sign up", style: _style(isMobileSite),),
      ),
    );
  }
}