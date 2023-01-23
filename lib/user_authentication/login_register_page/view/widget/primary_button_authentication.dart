import 'package:flutter/material.dart';
import 'package:senior_project/assets/constant.dart';
import 'package:senior_project/user_authentication/role_selection_page/view/page/role_selection_page.dart';

class PrimaryButtonAuthentication {
  static TextStyle _style(bool isMobileSite) =>  TextStyle(
    fontFamily: Constant.font,
    fontWeight: FontWeight.w600,
    fontSize: isMobileSite ? 16 : 20,
    color: Colors.white
  );

  static Widget widget(BuildContext context, bool isLoginPage, bool isMobileSite) {
    return SizedBox(
      height: 40,
      width: double.infinity,
      child: TextButton(
        onPressed: () {
          if (isLoginPage) {
            // TODO login logic
          } else {
            // TODO check user input before route
            Navigator.push(
              context, 
              MaterialPageRoute(builder: (context) {
                return const RoleSelectionPage();
              })
            );
          }
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