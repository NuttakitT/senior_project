import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senior_project/assets/color_constant.dart';

class HelpDeskMobileHeader {
  static TextStyle createTaskButtonStyle() => const TextStyle(
      fontFamily: ColorConstant.font,
      fontWeight: FontWeight.w600,
      color: Color(0xFFFFFFFF),
      fontSize: 16.0);
  static TextStyle titleTextStyle() => const TextStyle(
      fontFamily: "Roboto",
      fontWeight: FontWeight.w500,
      color: Color(0xFF393E42),
      fontSize: 28.0);
  static EdgeInsets headerPadding() => const EdgeInsets.fromLTRB(40, 24, 20, 0);

  static Widget widget(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return ConstrainedBox(
        constraints: BoxConstraints(maxWidth: screenWidth),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: double.infinity,
              height: 105,
              child: Center(
                child: DefaultTextStyle(
                  style: titleTextStyle(),
                  child: const Text("Help-desk List"),
                ),
              ),
            ),
            Container(
              height: 1.0,
              color: Colors.black,
            )
          ],
        ));
  }
}
