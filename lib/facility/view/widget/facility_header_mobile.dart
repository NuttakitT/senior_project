import 'package:flutter/material.dart';
import 'package:senior_project/assets/color_constant.dart';
import 'package:senior_project/assets/font_style.dart';

class FacilityHeaderMobile extends StatelessWidget {
  final String title;
  const FacilityHeaderMobile({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Row(
                children: const [
                  SizedBox(
                    width: 20,
                    child: Icon(
                      Icons.arrow_back_ios,
                      size: 20,
                      color: ColorConstant.black,
                    ),
                  ),
                ],
              )),
          const SizedBox(width: 8),
          DefaultTextStyle(style: AppFontStyle.wb90Md32, child: Text(title)),
        ],
      ),
    );
  }
}
