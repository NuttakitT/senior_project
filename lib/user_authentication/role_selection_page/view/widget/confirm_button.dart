import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senior_project/assets/color_constant.dart';
import 'package:senior_project/user_authentication/role_selection_page/view_model/role_selection_view_model.dart';

class ConfirmButton {
  static Widget button(BuildContext context, bool isConfirmButton, bool isMobileSite) {
    return SizedBox(
      width: isMobileSite ? 140 : 180,
      height: 40,
      child: TextButton(
        onPressed: () async {
          bool isSuccess = isConfirmButton 
            ? await context.read<RoleSelectionViewModel>().confirmButtonLogic()
            : await context.read<RoleSelectionViewModel>().backButtonLogic();
          if (isSuccess) {
             if (isConfirmButton) {
            // TODO add logic to main site
            } else {
              // ignore: use_build_context_synchronously
              Navigator.pop(context);
            }
          }
        },
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(
            isConfirmButton ? ColorConstant.orange40 : Colors.white
          ),
          side: MaterialStateProperty.all(
            const BorderSide(color: ColorConstant.orange40)
          ),
          shape: MaterialStateProperty.all(
            const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8))
            )
          )
        ),
        child: isConfirmButton
          ? Text(
            "Confirm",
            style: TextStyle(
              fontFamily: ColorConstant.font,
              fontWeight: FontWeight.w600,
              fontSize: isMobileSite ? 16 : 18,
              color: Colors.white
            ),
          )
          : Text(
            "Back",
            style: TextStyle(
              fontFamily: ColorConstant.font,
              fontWeight: FontWeight.w600,
              fontSize: isMobileSite ? 16 : 18,
              color: ColorConstant.orange40
            ),
          ),
      ),
    );
  }
}