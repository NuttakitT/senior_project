import 'package:flutter/material.dart';
import 'package:senior_project/assets/font_style.dart';
import '../../../../../assets/color_constant.dart';

class UserProfileHeader {
  static TextStyle createTaskButtonStyle() => const TextStyle(
      fontFamily: AppFontStyle.font,
      fontWeight: FontWeight.w600,
      color: Color(0xFFFFFFFF),
      fontSize: 16.0);
  static TextStyle titleTextStyle() => const TextStyle(
      fontFamily: "Roboto",
      fontWeight: FontWeight.w500,
      color: Color(0xFF393E42),
      fontSize: 32.0);
  static EdgeInsets headerPadding() => const EdgeInsets.fromLTRB(40, 24, 20, 0);

  static Widget widget(BuildContext context) {
    return Padding(
      padding: headerPadding(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          DefaultTextStyle(
            style: titleTextStyle(),
            child: const Text("My Profile"),
          ),
          const Spacer(),
          SizedBox(
            width: 178,
            height: 40,
            child: TextButton(
              onPressed: () {
                // TODO edit profile lofic
              },
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(ColorConstant.orange40),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.edit,
                    color: Colors.white,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(
                    "Edit profile",
                    style: createTaskButtonStyle(),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
