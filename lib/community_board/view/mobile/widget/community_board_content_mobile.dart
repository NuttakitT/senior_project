import 'package:flutter/material.dart';
import 'package:senior_project/assets/color_constant.dart';

class CommunityBoardContentMobile extends StatefulWidget {
  final Map<String, dynamic> info;
  const CommunityBoardContentMobile({super.key, required this.info});

  @override
  State<CommunityBoardContentMobile> createState() =>
      _CommunityBoardContentMobileState();
}

class _CommunityBoardContentMobileState
    extends State<CommunityBoardContentMobile> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        decoration: const BoxDecoration(
            color: ColorConstant.whiteBlack5,
            border: Border(
              // top: BorderSide(width: 1, color: ColorConstant.whiteBlack20),
              bottom: BorderSide(width: 1, color: ColorConstant.whiteBlack20),
            )),
        padding: const EdgeInsets.only(top: 8, bottom: 16, left: 16, right: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Text(
                widget.info["title"],
                style: const TextStyle(
                    color: ColorConstant.whiteBlack80, fontSize: 16),
              ),
            ),
            Row(
              children: [
                //TODO user
                const Padding(
                  padding: EdgeInsets.only(right: 24),
                  child: Text(
                    "Nayao",
                    style: TextStyle(
                        color: ColorConstant.whiteBlack70, fontSize: 12),
                  ),
                ),
                //TODO datetime
                const Text(
                  "25 Feb.",
                  style: TextStyle(
                      color: ColorConstant.whiteBlack50, fontSize: 12),
                ),
                const Spacer(),
                Row(
                  children: const [
                    Padding(
                      padding: EdgeInsets.only(right: 8),
                      child: Icon(
                        Icons.chat_rounded,
                        color: ColorConstant.whiteBlack60,
                        size: 14,
                      ),
                    ),
                    //TODO number comment
                    Text(
                      "14",
                      style: TextStyle(
                          color: ColorConstant.whiteBlack80, fontSize: 14),
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      ),
      onTap: () {
        //TODO link to detail page
      },
    );
  }
}
