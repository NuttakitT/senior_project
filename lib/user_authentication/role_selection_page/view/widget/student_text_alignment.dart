import 'package:flutter/material.dart';
import 'package:senior_project/user_authentication/role_selection_page/core/assets/card_text_style.dart';
import 'package:senior_project/user_authentication/role_selection_page/core/assets/text_constant.dart';

class StudentTextAlignment {

  static Widget desktopWidget(double screenWidth) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Text(
                  TextConstant.studentFeatureText[0],
                  style: CardTextStyle.subStyle(screenWidth)
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Text(
                  TextConstant.studentFeatureText[2],
                  style: CardTextStyle.subStyle(screenWidth)
                ),
              ),
              Text(
                TextConstant.studentFeatureText[4],
                style: CardTextStyle.subStyle(screenWidth)
              ),
            ],
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Text(
                TextConstant.studentFeatureText[1],
                style: CardTextStyle.subStyle(screenWidth)
              ),
            ),
            Text(
              TextConstant.studentFeatureText[3],
              style: CardTextStyle.subStyle(screenWidth)
            ),
          ],
        ),
      ],
    );
  }

  static Widget rowAlignmentText(double screenWidth) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Text(
            TextConstant.studentFeatureText[0],
            style: CardTextStyle.subStyle(screenWidth)
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Text(
            TextConstant.studentFeatureText[2],
            style: CardTextStyle.subStyle(screenWidth)
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Text(
            TextConstant.studentFeatureText[4],
            style: CardTextStyle.subStyle(screenWidth)
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Text(
            TextConstant.studentFeatureText[1],
            style: CardTextStyle.subStyle(screenWidth)
          ),
        ),
        Text(
          TextConstant.studentFeatureText[3],
          style: CardTextStyle.subStyle(screenWidth)
        ),
      ],
    );
  }
}