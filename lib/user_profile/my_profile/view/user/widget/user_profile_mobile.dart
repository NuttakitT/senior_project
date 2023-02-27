import 'package:flutter/material.dart';
import 'package:senior_project/assets/color_constant.dart';
import 'package:senior_project/assets/font_style.dart';
import 'package:senior_project/user_profile/my_profile/view/user/widget/user_profile_detail_list_view.dart';

class UserProfileMobile extends StatefulWidget {
  final Map<String, dynamic> profileData;
  final bool isCurrentlyEditData;
  const UserProfileMobile(
      {super.key,
      required this.profileData,
      required this.isCurrentlyEditData});

  @override
  State<UserProfileMobile> createState() => _UserProfileMobileState();
}

class _UserProfileMobileState extends State<UserProfileMobile> {
  bool _isEditting = false;

  void toggleEditProfileButton() {
    // Move to somewhere else
    _isEditting = !_isEditting;
  }

  @override
  void initState() {
    super.initState();
    _isEditting = widget.isCurrentlyEditData;
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return SizedBox(
      width: screenWidth,
      height: screenHeight,
      child: SingleChildScrollView(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 24),
              child: DefaultTextStyle(
                style: AppFontStyle.wb80Md28,
                child: Text(
                  "My Profile",
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            CircleAvatar(
              backgroundImage: NetworkImage(widget.profileData["imageUrl"]),
              radius: 120,
            ),
            const SizedBox(
              height: 16,
            ),
            DefaultTextStyle(
              style: AppFontStyle.wb80Md28,
              child: Text(
                widget.profileData["name"] +
                    " " +
                    widget.profileData["surname"],
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: ColorConstant.orange40, width: 1),
                borderRadius: BorderRadius.circular(8.0),
                color: Colors.white,
              ),
              child: TextButton(
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: DefaultTextStyle(
                    style: AppFontStyle.orange40B16,
                    child: Text("Edit Profile"),
                  ),
                ),
                onPressed: () {
                  toggleEditProfileButton();
                  print(_isEditting);
                },
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            UserProfileDetailListView(
                title: "About me", detail: widget.profileData["aboutMe"]),
            UserProfileDetailListView(
                title: "E-mail", detail: widget.profileData["email"]),
            UserProfileDetailListView(
                title: "Phone", detail: widget.profileData["phone"]),
            UserProfileDetailListView(
                title: "Office Hours",
                detail: widget.profileData["officeHours"]),
            UserProfileDetailListView(
                title: "Facebook", detail: widget.profileData["facebook"]),
            UserProfileDetailListView(
                title: "Subject", detail: widget.profileData["subject"]),
            const UserProfileDetailListView(
              title: "Birth Day",
              detail: "?????",
            ),
            const SizedBox(
              height: 16,
            )
          ],
        ),
      ),
    );
  }
}
