import 'package:flutter/material.dart';
import 'package:senior_project/assets/color_constant.dart';
import 'package:senior_project/assets/font_style.dart';

class FacilityHeader extends StatelessWidget {
  final bool canPop;
  final String title;
  const FacilityHeader({
    super.key,
    required this.title, required this.canPop,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      padding: const EdgeInsets.only(top: 40, bottom: 40, right: 64, left: 20),
      child: Row(
        children: [
          Builder(
            builder: (context) {
              if (!canPop) {
                return Container();
              }
              return TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Row(
                    children: const [
                      Icon(
                        Icons.arrow_back_ios,
                        size: 24,
                        color: ColorConstant.blue40,
                      ),
                      SizedBox(width: 4),
                      DefaultTextStyle(
                          style: AppFontStyle.blue90Md24, child: Text("back"))
                    ],
                  ));
            }
          ),
          const SizedBox(width: 8),
          DefaultTextStyle(style: AppFontStyle.wb90Md32, child: Text(title)),
          const SizedBox(width: 16),
          Expanded(
            child: Container(
              height: 1,
              decoration:
                  const BoxDecoration(color: ColorConstant.whiteBlack30),
            ),
          ),
          const SizedBox(width: 16)
        ],
      ),
    );
  }
}
