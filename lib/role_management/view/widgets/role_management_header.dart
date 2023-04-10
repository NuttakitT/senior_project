import 'package:flutter/material.dart';
import 'package:senior_project/assets/color_constant.dart';
import 'package:senior_project/assets/font_style.dart';

class RoleManagementHeader extends StatelessWidget {
  final String title;
  final String buttonLabel;
  final Widget popup;
  const RoleManagementHeader(
      {super.key,
      required this.title,
      required this.buttonLabel,
      required this.popup});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 64),
      child: Row(
        children: [
          DefaultTextStyle(style: AppFontStyle.wb90Md32, child: Text(title)),
          const SizedBox(width: 16),
          Expanded(
            child: Container(
              height: 1,
              decoration: const BoxDecoration(
                color: ColorConstant.whiteBlack30
              ),
            ),
          ),
          const SizedBox(width: 16),
          SizedBox(
            width: 178,
            height: 40,
            child: TextButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return popup;
                    });
              },
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(ColorConstant.orange40),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.add, color: Colors.white),
                  const SizedBox(width: 8),
                  Text(
                    buttonLabel,
                    style: AppFontStyle.whiteSemiB16,
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
