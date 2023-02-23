import 'package:flutter/material.dart';
import '../../../../assets/font_style.dart';

class UserProfileDetailListView extends StatelessWidget {
  final String title;
  final String detail;
  const UserProfileDetailListView(
      {Key? key, required this.title, required this.detail})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(),
          const SizedBox(
            height: 8.0,
          ),
          DefaultTextStyle(
            style: AppFontStyle.wb60R18,
            child: Text(
              title,
              textAlign: TextAlign.left,
            ),
          ),
          const SizedBox(
            height: 8.0,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: DefaultTextStyle(
              style: AppFontStyle.wb70R20,
              child: Text(
                detail,
                textAlign: TextAlign.left,
              ),
            ),
          ),
          const SizedBox(
            height: 16.0,
          ),
        ],
      ),
    );
  }
}
