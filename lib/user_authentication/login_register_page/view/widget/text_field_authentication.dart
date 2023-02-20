import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senior_project/assets/color_constant.dart';
import 'package:senior_project/assets/font_style.dart';
import 'package:senior_project/user_authentication/login_register_page/view_model/authentication_view_model.dart';

class TextFieldAuthentication extends StatefulWidget {
  final int hintMode;
  final bool isPasswordField;
  const TextFieldAuthentication({
    super.key,
    required this.hintMode,
    required this.isPasswordField,
  });

  @override
  State<TextFieldAuthentication> createState() =>
      _TextFieldAuthenticationState();
}

class _TextFieldAuthenticationState extends State<TextFieldAuthentication> {
  final List<String> _hintText = ["Username", "E-mail", "Password"];
  final controller = TextEditingController();

  bool? getState(int hintMode) {
    switch (hintMode) {
      case 0:
        return context.watch<AuthenticationViewModel>().getIsEmptyUsername;
      case 1:
        return context.watch<AuthenticationViewModel>().getIsEmptyEmail;
      case 2:
        return context.watch<AuthenticationViewModel>().getIsEmptyPassword;
      default:
        return null;
    }
  }

  @override
  void initState() {
    controller.addListener(() {
      context
          .read<AuthenticationViewModel>()
          .getUserInput(widget.hintMode, controller.text);
    });
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool state = getState(widget.hintMode) as bool;

    return Container(
      alignment: Alignment.centerLeft,
      width: double.infinity,
      height: 40,
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: state ? ColorConstant.red50 : ColorConstant.whiteBlack50,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(8))),
      child: Row(
        children: [
          Flexible(
            child: Padding(
              padding: const EdgeInsets.only(left: 16),
              child: TextField(
                controller: controller,
                obscureText: widget.isPasswordField
                    ? context
                        .watch<AuthenticationViewModel>()
                        .getVisibilityState
                    : false,
                decoration: InputDecoration.collapsed(
                    hintText: _hintText[widget.hintMode],
                    hintStyle: AppFontStyle.wb30R14),
                onTap: () {
                  switch (widget.hintMode) {
                    case 0:
                      context
                          .read<AuthenticationViewModel>()
                          .clearIsEmptyUsername();
                      break;
                    case 1:
                      context
                          .read<AuthenticationViewModel>()
                          .clearIsEmptyEmail();
                      break;
                    case 2:
                      context
                          .read<AuthenticationViewModel>()
                          .clearIsEmptyPassword();
                      break;
                    default:
                      break;
                  }
                },
              ),
            ),
          ),
          const Divider(),
          Builder(builder: (context) {
            if (widget.isPasswordField) {
              return Padding(
                padding: const EdgeInsets.only(right: 16),
                child: IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    context
                        .read<AuthenticationViewModel>()
                        .changeVisibilityState();
                  },
                  icon: Builder(
                    builder: (context) {
                      bool isVisibility = context
                          .watch<AuthenticationViewModel>()
                          .getVisibilityState;
                      if (isVisibility) {
                        return const Icon(
                          Icons.visibility,
                          color: ColorConstant.whiteBlack50,
                        );
                      }
                      return const Icon(
                        Icons.visibility_off,
                        color: ColorConstant.whiteBlack50,
                      );
                    },
                  ),
                ),
              );
            }
            return Container();
          })
        ],
      ),
    );
  }
}
