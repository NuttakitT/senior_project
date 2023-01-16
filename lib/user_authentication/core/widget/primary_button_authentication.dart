import 'package:flutter/material.dart';
import 'package:senior_project/assets/constant.dart';

class PrimaryButtonAuthentication {
  static const TextStyle _style =  TextStyle(
    fontFamily: Constant.font,
    fontWeight: FontWeight.w600,
    fontSize: 20,
    color: Colors.white
  );

  static Widget widget(bool isLoginPage) {
    return SizedBox(
      height: 40,
      width: double.infinity,
      child: TextButton(
        onPressed: () {
          // TODO login logic
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
          ? Text("Login", style: _style,) 
          : Text("Sign up", style: _style,),
      ),
    );
  }
}