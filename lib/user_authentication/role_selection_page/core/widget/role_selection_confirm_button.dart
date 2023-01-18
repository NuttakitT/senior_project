import 'package:flutter/material.dart';
import 'package:senior_project/assets/constant.dart';

class RoleSelctionButton {
  static Widget button(bool isConfirmButton, double width) {
    return SizedBox(
      width: width,
      height: 40,
      child: TextButton(
        onPressed: () {
          // TODO add button logic
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
          ? const Text(
            "Confirm",
            style: TextStyle(
              fontFamily: Constant.font,
              fontWeight: FontWeight.w600,
              fontSize: 18,
              color: Colors.white
            ),
          )
          : const Text(
            "Back",
            style: TextStyle(
              fontFamily: Constant.font,
              fontWeight: FontWeight.w600,
              fontSize: 18,
              color: Constant.orange40
            ),
          ),
      ),
    );
  }
}