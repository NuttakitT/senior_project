import 'package:flutter/material.dart';
import 'package:senior_project/assets/color_constant.dart';
import 'package:senior_project/assets/font_style.dart';
import 'package:senior_project/my_profile/view/user/widget/user_profile_about_me.dart';
import 'package:senior_project/my_profile/view/user/widget/user_profile_detail_cell.dart';

class UserProfileCard {
  static TextStyle informationHeaderTextStyle = AppFontStyle.wb80Md20;
  static TextStyle informationTitleTextStyle = AppFontStyle.wb40R16;
  static TextStyle informationDetailTextStyle = AppFontStyle.wb80R18;

  static EdgeInsets informationPadding =
      const EdgeInsets.fromLTRB(20, 16, 20, 16);

  static Widget widget(BuildContext context, Map<String, dynamic> profileData,
      bool isCurrentlyEditProfile) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Padding(
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
              Container(
                decoration: const BoxDecoration(
                    border: Border(
                        right: BorderSide(
                            color: ColorConstant.whiteBlack40, width: 1.0))),
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
                      style: AppFontStyle.wb80Md24,
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
                              color: ColorConstant.whiteBlack15, width: 1),
                          borderRadius: BorderRadius.circular(16.0),
                          color: ColorConstant.whiteBlack5),
                      child: DefaultTextStyle(
                          style: AppFontStyle.wb60SemiB16,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 6, horizontal: 33),
                            child: Text(profileData["role"]),
                          )),
                    )
                  ],
                ),
              ),
              SizedBox(
                width: screenWidth > 1300 ? screenWidth - 612 : 688,
                child: Padding(
                  padding: const EdgeInsets.only(right: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      UserProfileAboutMe(
                        aboutMeHeader: "About me",
                        aboutMeDetail: profileData['aboutMe'],
                      ),
                      UserProfileDetailCell(
                        cellTitle: "User Profile",
                        leftCellTitle: "Gender",
                        leftCellDetail: profileData["gender"],
                        rightCellTitle: "Date of Birth",
                        rightCellDetail: "null",
                        isBorderNeeded: true,
                      ),
                      UserProfileDetailCell(
                        cellTitle: "Office Hours",
                        leftCellTitle: "Time",
                        leftCellDetail: profileData["officeHours"],
                        rightCellTitle: "Null",
                        rightCellDetail: null,
                        isBorderNeeded: false,
                      ),
                      UserProfileDetailCell(
                        cellTitle: "Contact",
                        leftCellTitle: "E-mail",
                        leftCellDetail: profileData["email"],
                        rightCellTitle: "Phone",
                        rightCellDetail: profileData["phone"],
                        isBorderNeeded: false,
                      ),
                      UserProfileDetailCell(
                        cellTitle: "Link",
                        leftCellTitle: "Facebook",
                        leftCellDetail: profileData["facebook"],
                        rightCellTitle: "Null",
                        rightCellDetail: null,
                        isBorderNeeded: false,
                      ),
                      UserProfileAboutMe(
                        aboutMeHeader: "Subject",
                        aboutMeDetail: profileData["subject"],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
