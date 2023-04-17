import 'package:flutter/material.dart';
import 'package:senior_project/assets/color_constant.dart';
import 'package:senior_project/community_board/view/mobile/widget/comment_field_mobile.dart';
import 'package:senior_project/community_board/view/mobile/widget/comment_template_mobile.dart';

class InDetailMobile extends StatefulWidget {
  final Map<String, dynamic> info;
  const InDetailMobile({super.key, required this.info});

  @override
  State<InDetailMobile> createState() => _InDetailMobileState();
}

class _InDetailMobileState extends State<InDetailMobile> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.fromLTRB(16, 24, 0, 24),
          child: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: ColorConstant.whiteBlack90,
            size: 24,
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
          child: Container(
            padding: const EdgeInsets.fromLTRB(8, 16, 8, 16),
            decoration: BoxDecoration(
                color: ColorConstant.whiteBlack5,
                border: Border.all(color: ColorConstant.whiteBlack40),
                borderRadius: BorderRadius.circular(8)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //TODO tittle
                Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Text(
                    widget.info["topic"],
                    style: const TextStyle(
                        color: ColorConstant.orange70,
                        fontSize: 20,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: const [
                      //TODO user
                      Padding(
                        padding: EdgeInsets.only(right: 16),
                        child: Text(
                          "Nayao",
                          style: TextStyle(
                              color: ColorConstant.whiteBlack70, fontSize: 14),
                        ),
                      ),
                      //TODO date time
                      Text(
                        "3 Mar.",
                        style: TextStyle(
                            color: ColorConstant.whiteBlack50, fontSize: 12),
                      )
                    ],
                  ),
                ),
                //TODO topic tag
                Padding(
                  padding: const EdgeInsets.only(bottom: 40),
                  child: Container(
                    width: 100,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: ColorConstant.white,
                        border: Border.all(color: ColorConstant.whiteBlack30),
                        borderRadius: BorderRadius.circular(8)),
                    child: Text(
                      widget.info["topic"],
                      style: const TextStyle(
                          color: ColorConstant.whiteBlack70, fontSize: 12),
                    ),
                  ),
                ),
                //TODO detail
                const Text(
                  "ปฏิทินการลงทะเบียน",
                  style: TextStyle(
                      color: ColorConstant.whiteBlack90, fontSize: 14),
                )
              ],
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
          child: CommentFieldMobile(),
        ),
        const Padding(
          padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
          child: CommentTemplateMobile(),
        )
      ],
    );
  }
}
