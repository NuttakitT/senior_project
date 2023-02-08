import 'package:flutter/material.dart';
import 'package:senior_project/user_authentication/role_selection_page/assets/card_text_style.dart';
import 'package:senior_project/user_authentication/role_selection_page/assets/text_constant.dart';

class StudentTextAlignment {

  static Widget desktopAlignment() {
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
                  style: CardTextStyle.subStyle(false)
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Text(
                  TextConstant.studentFeatureText[2],
                  style: CardTextStyle.subStyle(false)
                ),
              ),
              Text(
                TextConstant.studentFeatureText[4],
                style: CardTextStyle.subStyle(false)
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
                style: CardTextStyle.subStyle(false)
              ),
            ),
            Text(
              TextConstant.studentFeatureText[3],
              style: CardTextStyle.subStyle(false)
            ),
          ],
        ),
      ],
    );
  }

  static Widget mobileAlignment(double screenWidth) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: SizedBox(
            width: screenWidth - 130,
            child: RichText(
              maxLines: null,
              text: TextSpan(
                children: [
                  TextSpan(
                    text: TextConstant.studentFeatureText[0],
                    style: CardTextStyle.subStyle(true)
                  )
                ]
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: SizedBox(
            width: screenWidth - 130,
            child: RichText(
              maxLines: null,
              text: TextSpan(
                children: [
                  TextSpan(
                    text: TextConstant.studentFeatureText[2],
                    style: CardTextStyle.subStyle(true)
                  )
                ]
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: SizedBox(
            width: screenWidth - 130,
            child: RichText(
              maxLines: null,
              text: TextSpan(
                children: [
                  TextSpan(
                    text: TextConstant.studentFeatureText[4],
                    style: CardTextStyle.subStyle(true)
                  )
                ]
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: SizedBox(
            width: screenWidth - 130,
            child: RichText(
              maxLines: null,
              text: TextSpan(
                children: [
                  TextSpan(
                    text: TextConstant.studentFeatureText[1],
                    style: CardTextStyle.subStyle(true)
                  )
                ]
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: SizedBox(
            width: screenWidth - 130,
            child: RichText(
              maxLines: null,
              text: TextSpan(
                children: [
                  TextSpan(
                    text: TextConstant.studentFeatureText[3],
                    style: CardTextStyle.subStyle(true)
                  )
                ]
              ),
            ),
          ),
        ),
      ],
    );
  }
}