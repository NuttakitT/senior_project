import 'package:flutter/material.dart';
import 'package:senior_project/assets/color_constant.dart';

class DescriptionDesktop extends StatelessWidget {
  const DescriptionDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 600,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: ColorConstant.white,
          boxShadow: [
            BoxShadow(
              offset: const Offset(5, 5),
              color: ColorConstant.black.withOpacity(0.05),
              blurRadius: 10,
            ),
          ]),
      //TODO edit height
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: const Text(
              "Description",
              style: TextStyle(
                  color: ColorConstant.whiteBlack80,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            child: const Text(
              "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
              style: TextStyle(color: ColorConstant.whiteBlack70, fontSize: 16),
            ),
          )
        ],
      ),
    );
  }
}
