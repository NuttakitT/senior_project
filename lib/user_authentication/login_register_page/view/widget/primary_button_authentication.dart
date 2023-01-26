import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senior_project/assets/color_constant.dart';
import 'package:senior_project/user_authentication/login_register_page/view_model/authentication_view_model.dart';
import 'package:senior_project/user_authentication/role_selection_page/view/page/role_selection_page.dart';

class PrimaryButtonAuthentication {
  static TextStyle _style(bool isMobileSite) =>  TextStyle(
    fontFamily: ColorConstant.font,
    fontWeight: FontWeight.w600,
    fontSize: isMobileSite ? 16 : 20,
    color: Colors.white
  );

  static Widget widget(BuildContext context, bool isLoginPage, bool isMobileSite) {
    return SizedBox(
      height: 40,
      width: double.infinity,
      child: TextButton(
        onPressed: () async {
          bool allInputValid = context.read<AuthenticationViewModel>().checkkUserInput(
            isLoginPage ? false : true
          );
          if (allInputValid) {
            Map<String, dynamic> isCreateSuccess = isLoginPage 
              ? await context.read<AuthenticationViewModel>().loginUser(context)
              : await context.read<AuthenticationViewModel>().createUser(context);
            if (isCreateSuccess["success"]) {
              if (!isLoginPage) {
                // ignore: use_build_context_synchronously
                Navigator.push(
                  context, 
                  MaterialPageRoute(builder: (context) {
                    return const RoleSelectionPage();
                  })
                );
              } else {
                // TODO change to main page
              }
            } else {
              // TODO show err
              print("craete user err ${isCreateSuccess["comment"]}");
            }
          } else {
            // TODO show error
            print("input error");
          }
        }, 
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(ColorConstant.orange40),
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