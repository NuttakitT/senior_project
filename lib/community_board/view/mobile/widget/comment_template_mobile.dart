import 'package:flutter/material.dart';
import 'package:senior_project/assets/color_constant.dart';

class CommentTemplateMobile extends StatefulWidget {
  const CommentTemplateMobile({super.key});

  @override
  State<CommentTemplateMobile> createState() => _CommentTemplateMobileState();
}

class _CommentTemplateMobileState extends State<CommentTemplateMobile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: ColorConstant.whiteBlack5,
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          border: Border.all(color: ColorConstant.whiteBlack40)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Padding(
                padding: EdgeInsets.only(bottom: 24),
                child: Text(
                  "ความคิดเห็นที่ 1",
                  style: TextStyle(
                      color: ColorConstant.orange70,
                      fontSize: 20,
                      fontWeight: FontWeight.w500),
                ),
              ),
              Spacer(),
              TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                    padding: const EdgeInsets.fromLTRB(0, 0, 24, 0),
                    foregroundColor: ColorConstant.whiteBlack80,
                    textStyle: const TextStyle(fontSize: 16)),
                child: const Icon(
                  Icons.delete_rounded,
                  color: ColorConstant.whiteBlack80,
                  size: 20,
                ),
              ),
              TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                    foregroundColor: ColorConstant.whiteBlack80,
                    textStyle: const TextStyle(fontSize: 16)),
                child: const Icon(
                  Icons.border_color_rounded,
                  color: ColorConstant.whiteBlack80,
                  size: 20,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 24),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                        color: ColorConstant.white,
                        borderRadius: BorderRadius.circular(360),
                        border: Border.all(color: ColorConstant.whiteBlack60)),
                    child: const Icon(
                      Icons.face_rounded,
                      color: ColorConstant.blue40,
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Padding(
                      padding: EdgeInsets.only(bottom: 8),
                      //TODO user of comment
                      child: Text(
                        "Runn",
                        style: TextStyle(
                            color: ColorConstant.whiteBlack70, fontSize: 16),
                      ),
                    ),
                    //TODO date of comment
                    Text(
                      "3 Mar",
                      style: TextStyle(
                          color: ColorConstant.whiteBlack50, fontSize: 12),
                    ),
                  ],
                ),
              ],
            ),
          ),
          //TODO detail comment
          const Text(
            "ถ้าไม่ว่างลงทะเบียนในวันลงทะเบียน ต้องทำอย่างไรครับ",
            style: TextStyle(color: ColorConstant.whiteBlack90, fontSize: 16),
          )
        ],
      ),
    );
  }
}
