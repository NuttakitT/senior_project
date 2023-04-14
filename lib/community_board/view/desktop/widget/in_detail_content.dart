import 'package:flutter/material.dart';
import 'package:senior_project/assets/color_constant.dart';
import 'package:senior_project/community_board/view/desktop/widget/comment_field.dart';

class InDetailContent extends StatefulWidget {
  final Map<String, dynamic> info;
  const InDetailContent({super.key, required this.info});

  @override
  State<InDetailContent> createState() => _InDetailContentState();
}

class _InDetailContentState extends State<InDetailContent> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(40, 40, 40, 24),
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
                color: ColorConstant.whiteBlack5,
                border: Border.all(color: ColorConstant.whiteBlack40),
                borderRadius: BorderRadius.circular(16)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //TODO tittle
                Padding(
                  padding: EdgeInsets.only(bottom: 8),
                  child: Text(
                    widget.info["tittle"],
                    style: const TextStyle(
                        color: ColorConstant.orange70,
                        fontSize: 32,
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
                        padding: EdgeInsets.only(right: 24),
                        child: Text(
                          "Nayao",
                          style: TextStyle(
                              color: ColorConstant.whiteBlack70, fontSize: 20),
                        ),
                      ),
                      //TODO date time
                      Text(
                        "3 Mar.",
                        style: TextStyle(
                            color: ColorConstant.whiteBlack50, fontSize: 16),
                      )
                    ],
                  ),
                ),
                //TODO topic tag
                Padding(
                  padding: const EdgeInsets.only(bottom: 40),
                  child: Container(
                    width: 200,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: ColorConstant.white,
                        border: Border.all(color: ColorConstant.whiteBlack30),
                        borderRadius: BorderRadius.circular(8)),
                    child: Text(
                      widget.info["topic"],
                      style: TextStyle(
                          color: ColorConstant.whiteBlack70, fontSize: 18),
                    ),
                  ),
                ),
                //TODO detail
                const Text(
                  "ปฏิทินการลงทะเบียน",
                  style: TextStyle(
                      color: ColorConstant.whiteBlack90, fontSize: 20),
                )
              ],
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.fromLTRB(40, 0, 40, 24),
          child: CommentField(),
        )
      ],
    );
  }
}
