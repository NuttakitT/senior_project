import 'package:flutter/material.dart';
import 'package:senior_project/assets/color_constant.dart';
import '../../../../assets/font_style.dart';

class UserProfileEditButtonBar extends StatelessWidget {
  const UserProfileEditButtonBar({
    Key? key,
    required this.didTapCancel,
    required this.didTapSaveChange,
  }) : super(key: key);

  final Function(void) didTapCancel;
  final Function(void) didTapSaveChange;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(right: 102, top: 24),
        child: ButtonBar(
          alignment: MainAxisAlignment.end,
          children: [
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                backgroundColor: ColorConstant.white,
                side: const BorderSide(color: ColorConstant.orange40),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () {
                // Handle button press
              },
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 24),
                child: Text(
                  'Cancel',
                  style: AppFontStyle.orange40B16,
                ),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorConstant.orange40,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () {
                // Handle button press
              },
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 24),
                child: Text(
                  'Save Change',
                  style: AppFontStyle.whiteB16,
                ),
              ),
            ),
          ],
        ));
  }
}
