// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senior_project/assets/color_constant.dart';
import 'package:senior_project/assets/font_style.dart';
import 'package:senior_project/help_desk/help_desk_main/view/page/help_desk_main_view.dart';
import 'package:senior_project/user_authentication/role_selection_page/view_model/role_selection_view_model.dart';

class ConfirmButton {
  static Widget button(BuildContext context, bool isConfirmButton,
      bool isMobileSite, double size) {
    return SizedBox(
      width: size,
      height: 40,
      child: TextButton(
        onPressed: () async {
          bool isSuccess = isConfirmButton
              ? await context
                  .read<RoleSelectionViewModel>()
                  .confirmButtonLogic(context)
              : await context
                  .read<RoleSelectionViewModel>()
                  .backButtonLogic(context);
          if (isSuccess) {
            if (isConfirmButton) {
              // TODO add logic to main site
              Navigator.pushAndRemoveUntil(
                context, 
                MaterialPageRoute(builder: (context) {
                  return const HelpDeskMainView(isAdmin: false);
                }), 
                (route) => false
              );
            } else {
              Navigator.pop(context);
            }
          }
        },
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(
                isConfirmButton ? ColorConstant.orange40 : Colors.white),
            side: MaterialStateProperty.all(
                const BorderSide(color: ColorConstant.orange40)),
            shape: MaterialStateProperty.all(const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8))))),
        child: isConfirmButton
            ? Text(
                "Confirm",
                style: isMobileSite
                    ? AppFontStyle.whiteSemiB16
                    : AppFontStyle.whiteSemiB18,
              )
            : Text(
                "Back",
                style: isMobileSite
                    ? AppFontStyle.orange40SemiB16
                    : AppFontStyle.orange40SemiB18,
              ),
      ),
    );
  }
}
