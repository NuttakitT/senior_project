import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:senior_project/assets/color_constant.dart';

import 'common_divider.dart';

class UserProfileCard {
  static TextStyle nameTextStyle() => const TextStyle(
      fontFamily: ColorConstant.font,
      fontWeight: FontWeight.w500,
      color: Color(0xFF2D3236),
      fontSize: 24.0);
  static TextStyle roleTextStyle() => const TextStyle(
      fontFamily: ColorConstant.font,
      fontWeight: FontWeight.w600,
      color: Color(0xFF6B6E71),
      fontSize: 16.0);
  static TextStyle informationHeaderTextStyle() => const TextStyle(
      fontFamily: ColorConstant.font,
      fontWeight: FontWeight.w500,
      color: Color(0xFF393E42),
      fontSize: 20.0);
  static TextStyle informationTitleTextStyle() => const TextStyle(
      fontFamily: ColorConstant.font,
      fontWeight: FontWeight.w400,
      color: Color(0xFF9C9FA1),
      fontSize: 16.0);
  static TextStyle informationDetailTextStyle() => const TextStyle(
      fontFamily: ColorConstant.font,
      fontWeight: FontWeight.w400,
      color: Color(0xFF393E42),
      fontSize: 18.0);
  static EdgeInsets informationPadding =
      const EdgeInsets.fromLTRB(20, 16, 20, 16);

  static Widget widget(BuildContext context, Map<String, dynamic> profileData) {
    double screenWidth = MediaQuery.of(context).size.width;

    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: screenWidth),
      child: Padding(
        padding: const EdgeInsets.only(left: 102, top: 44, right: 102),
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFFFF9800), width: 1),
              borderRadius: BorderRadius.circular(16.0),
              color: Colors.white),
          child: Padding(
            padding:
                const EdgeInsets.only(left: 16, top: 24, right: 16, bottom: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: 300,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(profileData["imageUrl"]),
                        radius: 90,
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      DefaultTextStyle(
                        style: nameTextStyle(),
                        child: Text(
                          profileData["name"] + " " + profileData["surname"],
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: const Color(0xFFDADBDC), width: 1),
                            borderRadius: BorderRadius.circular(16.0),
                            color: const Color(0xFFF3F3F3)),
                        child: Center(
                          child: DefaultTextStyle(
                              style: roleTextStyle(),
                              child: const Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 6, horizontal: 33),
                                child: Text("User"),
                              )),
                        ),
                      )
                    ],
                  ),
                ),
                const CommonVerticalDivider(),
                SizedBox(
                  width: screenWidth - 611,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // [1] About me
                        Padding(
                          padding: informationPadding,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              DefaultTextStyle(
                                  style: informationHeaderTextStyle(),
                                  child: const Text("About me")),
                              const SizedBox(height: 8),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 8.0, horizontal: 16.0),
                                child: DefaultTextStyle(
                                  style: informationDetailTextStyle(),
                                  child: Text(
                                    profileData["aboutMe"],
                                    maxLines: 5,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const CommonDivider(),
                        // [2] User profile
                        Padding(
                          padding: informationPadding,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              DefaultTextStyle(
                                  style: informationHeaderTextStyle(),
                                  child: const Text("User profile")),
                              const SizedBox(height: 8),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 8.0, horizontal: 16.0),
                                child: Row(
                                  children: [
                                    Expanded(
                                        flex: 1,
                                        child: Text(
                                          "Gender",
                                          style: informationTitleTextStyle(),
                                          textAlign: TextAlign.left,
                                        )),
                                    Expanded(
                                        flex: 3,
                                        child: Text(
                                          profileData["gender"],
                                          style: informationDetailTextStyle(),
                                          textAlign: TextAlign.center,
                                        )),
                                    Expanded(
                                        flex: 1,
                                        child: Text(
                                          "Date of Birth",
                                          style: informationTitleTextStyle(),
                                          textAlign: TextAlign.left,
                                        )),
                                    Expanded(
                                        flex: 3,
                                        child: Text(
                                          "412342342342",
                                          style: informationDetailTextStyle(),
                                          textAlign: TextAlign.center,
                                        ))
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const CommonDivider(),
                        // [3]
                        Padding(
                          padding: informationPadding,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              DefaultTextStyle(
                                  style: informationHeaderTextStyle(),
                                  child: const Text("Contact")),
                              const SizedBox(height: 8),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 8.0, horizontal: 16.0),
                                child: Row(
                                  children: [
                                    Expanded(
                                        flex: 1,
                                        child: Text(
                                          "Email",
                                          style: informationTitleTextStyle(),
                                          textAlign: TextAlign.left,
                                        )),
                                    Expanded(
                                        flex: 3,
                                        child: Text(
                                          profileData["email"],
                                          style: informationDetailTextStyle(),
                                          textAlign: TextAlign.center,
                                        )),
                                    Expanded(
                                        flex: 1,
                                        child: Text(
                                          "Phone",
                                          style: informationTitleTextStyle(),
                                          textAlign: TextAlign.left,
                                        )),
                                    Expanded(
                                        flex: 3,
                                        child: Text(
                                          profileData["phone"],
                                          style: informationDetailTextStyle(),
                                          textAlign: TextAlign.center,
                                        ))
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
