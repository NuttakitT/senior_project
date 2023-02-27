import 'package:flutter/material.dart';
import 'package:senior_project/assets/font_style.dart';
import '../../../../../assets/color_constant.dart';

class UserProfileHeader {
  static TextStyle createTaskButtonStyle = AppFontStyle.whiteSemiB16;
  static TextStyle titleTextStyle = AppFontStyle.wb80Md32;
  static EdgeInsets headerPadding() => const EdgeInsets.fromLTRB(40, 24, 20, 0);

  static Widget widget(BuildContext context) {
    return Padding(
      padding: headerPadding(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          DefaultTextStyle(
            style: titleTextStyle,
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
                    "Edit Profile",
                    style: createTaskButtonStyle,
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
