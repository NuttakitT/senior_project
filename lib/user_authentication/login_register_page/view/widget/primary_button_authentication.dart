import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senior_project/assets/color_constant.dart';
import 'package:senior_project/user_authentication/login_register_page/view_model/authentication_view_model.dart';
import 'package:senior_project/user_authentication/role_selection_page/view/page/role_selection_page.dart';

class PrimaryButtonAuthentication extends StatefulWidget {
  final bool isLoginPage;
  final bool isMobileSite;
  const PrimaryButtonAuthentication({super.key, required this.isLoginPage, required this.isMobileSite});

  @override
  State<PrimaryButtonAuthentication> createState() => _PrimaryButtonAuthenticationState();
}

class _PrimaryButtonAuthenticationState extends State<PrimaryButtonAuthentication> {
  static TextStyle _style(bool isMobileSite) =>  TextStyle(
    fontFamily: ColorConstant.font,
    fontWeight: FontWeight.w600,
    fontSize: isMobileSite ? 16 : 20,
    color: Colors.white
  );

  @override
  Widget build(BuildContext context) {
    String errorText = context.watch<AuthenticationViewModel>().getErrorText;

    return Column(
      children: [
        Builder(
          builder: (context) {
            if (errorText.isNotEmpty) {
              return Align(
                alignment: AlignmentDirectional.centerEnd,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(
                    errorText,
                    style: const TextStyle(
                      color: ColorConstant.red40,
                      fontFamily: ColorConstant.font,
                      fontSize: 14
                    ),
                  ),
                ),
              );
            }
            return Container();
          },
        ),
        SizedBox(
          height: 40,
          width: double.infinity,
          child: TextButton(
            onPressed: () async {
              bool allInputValid = context.read<AuthenticationViewModel>().checkkUserInput(
                widget.isLoginPage ? false : true
              );
              if (allInputValid) {
                bool isCreateSuccess = widget.isLoginPage 
                  ? await context.read<AuthenticationViewModel>().loginUser(context)
                  : await context.read<AuthenticationViewModel>().createUser(context);
                if (isCreateSuccess) {
                  if (!widget.isLoginPage) {
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
                }
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
            child: widget.isLoginPage 
              ? Text("Login", style: _style(widget.isMobileSite),) 
              : Text("Sign up", style: _style(widget.isMobileSite),),
          ),
        ),
      ],
    );
  }
}