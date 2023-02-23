import 'package:flutter/material.dart';
import 'package:senior_project/assets/color_constant.dart';

class DescriptionMobile extends StatelessWidget {
  const DescriptionMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Description",
              style: TextStyle(
                  color: ColorConstant.whiteBlack80,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            InkWell(
              child: const Icon(
                Icons.cancel_rounded,
                color: ColorConstant.whiteBlack80,
              ),
              //TODO close popup
              onTap: () {
                Navigator.pop(context);
              },
            )
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(width: 1, color: ColorConstant.whiteBlack20),
              color: ColorConstant.whiteBlack5,
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            child: const Text(
              "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
              style: TextStyle(color: ColorConstant.whiteBlack70, fontSize: 16),
            ),
          ),
        )
      ],
    );
  }
}
