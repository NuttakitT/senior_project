import 'package:flutter/material.dart';
import '../../../../assets/font_style.dart';

class UserProfileAboutMe extends StatelessWidget {
  static TextStyle informationHeaderTextStyle = AppFontStyle.wb80Md20;
  static TextStyle informationTitleTextStyle = AppFontStyle.wb40R16;
  static TextStyle informationDetailTextStyle = AppFontStyle.wb80R18;

  const UserProfileAboutMe({
    Key? key,
    required this.aboutMeDetail,
  }) : super(key: key);

  final String aboutMeDetail;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          border:
              Border(bottom: BorderSide(color: Color(0xFF9C9FA1), width: 1.0))),
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DefaultTextStyle(
              style: informationHeaderTextStyle, child: const Text("About me")),
          const SizedBox(height: 8),
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: DefaultTextStyle(
              style: informationDetailTextStyle,
              child: Text(
                aboutMeDetail,
                maxLines: 5,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
