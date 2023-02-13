import 'package:flutter/material.dart';
import 'package:senior_project/assets/color_constant.dart';
import 'package:senior_project/help_desk/help_desk_main/core/widget/create_task_pop_up.dart';

class HelpDeskDesktopHeader {
  static TextStyle createTaskButtonStyle() => const TextStyle(
      fontFamily: ColorConstant.font,
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
    double screenWidth = MediaQuery.of(context).size.width;

    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: screenWidth, maxHeight: 80),
      child: Padding(
        padding: headerPadding(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            DefaultTextStyle(
              style: titleTextStyle(),
              child: const Text("HelpDesk"),
            ),
            const Spacer(),
            SizedBox(
              width: 153,
              height: 40,
              child: TextButton(
                onPressed: () {
                  showDialog(
                    context: context, 
                    builder: (context) {
                      return const CreateTaskPopup();
                    }
                  );
                },
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(ColorConstant.orange40),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)))),
                child: Text(
                  "+ Create Task",
                  style: createTaskButtonStyle(),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
