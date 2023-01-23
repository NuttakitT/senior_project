import 'package:flutter/material.dart';
import 'package:senior_project/assets/constant.dart';

class ConfirmButton {
  static Widget button(BuildContext context, bool isConfirmButton, bool isMobileSite) {
    return SizedBox(
      width: isMobileSite ? 140 : 180,
      height: 40,
      child: TextButton(
        onPressed: () {
          if (isConfirmButton) {
            // TODO add logic to main site
          } else {
            Navigator.pop(context);
          }
        },
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(
            isConfirmButton ? Constant.orange40 : Colors.white
          ),
          side: MaterialStateProperty.all(
            const BorderSide(color: Constant.orange40)
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
              fontFamily: Constant.font,
              fontWeight: FontWeight.w600,
              fontSize: isMobileSite ? 16 : 18,
              color: Colors.white
            ),
          )
          : Text(
            "Back",
            style: TextStyle(
              fontFamily: Constant.font,
              fontWeight: FontWeight.w600,
              fontSize: isMobileSite ? 16 : 18,
              color: Constant.orange40
            ),
          ),
      ),
    );
  }
}