import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senior_project/assets/font_style.dart';
import 'package:senior_project/my_profile/view_model/user_profile_view_model.dart';
import '../../../../assets/color_constant.dart';

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
            child: Text(Consts.myProfile),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}

class Consts {
  static String myProfile = "My Profile";
}
