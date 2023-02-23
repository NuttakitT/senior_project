import 'package:flutter/material.dart';
import 'package:senior_project/my_profile/view/user/widget/user_profile_detail_list_view.dart';
import '../../../../assets/color_constant.dart';
import '../../../../assets/font_style.dart';

class AdminProfileMobile extends StatefulWidget {
  final Map<String, dynamic> profileData;
  const AdminProfileMobile({super.key, required this.profileData});

  @override
  State<AdminProfileMobile> createState() => _AdminProfileMobileState();
}

class _AdminProfileMobileState extends State<AdminProfileMobile> {
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
                  border:
                      Border.all(color: ColorConstant.whiteBlack15, width: 1),
                  borderRadius: BorderRadius.circular(16.0),
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 4.0, horizontal: 16.0),
                  child: DefaultTextStyle(
                    style: AppFontStyle.wb60Md16,
                    child: Text(widget.profileData["role"]),
                  ),
                )),
            const SizedBox(
              height: 24,
            ),
            UserProfileDetailListView(
              title: "About me",
              detail: widget.profileData["aboutMe"],
            ),
            UserProfileDetailListView(
              title: "E-mail",
              detail: widget.profileData["email"],
            ),
            UserProfileDetailListView(
              title: "Phone",
              detail: widget.profileData["phone"],
            ),
            UserProfileDetailListView(
              title: "Office Hours",
              detail: widget.profileData["officeHours"],
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
