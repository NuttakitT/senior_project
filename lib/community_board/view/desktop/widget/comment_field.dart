import 'package:flutter/material.dart';
import 'package:senior_project/assets/color_constant.dart';

class CommentField extends StatefulWidget {
  const CommentField({super.key});

  @override
  State<CommentField> createState() => _CommentFieldState();
}

class _CommentFieldState extends State<CommentField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
          color: ColorConstant.whiteBlack5,
          border: Border.all(color: ColorConstant.whiteBlack40),
          borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(bottom: 24),
            child: Text(
              "ช่องแสดงความคิดเห็น",
              style: TextStyle(
                  color: ColorConstant.orange70,
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 24),
            child: Column(
              children: [
                Container(
                    width: double.infinity,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(8),
                            topRight: Radius.circular(8)),
                        color: ColorConstant.white,
                        border: Border.all(color: ColorConstant.whiteBlack40)),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //TODO add image
                        TextButton(
                          onPressed: () {},
                          style: TextButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                              side: const BorderSide(
                                  color: ColorConstant.orange50, width: 1),
                              fixedSize: const Size(116, 28),
                              foregroundColor: ColorConstant.orange50,
                              padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                              backgroundColor: ColorConstant.white,
                              textStyle: const TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold)),
                          child: Row(
                            children: const [
                              Icon(
                                Icons.add_photo_alternate_rounded,
                                color: ColorConstant.orange50,
                                size: 16,
                              ),
                              Text("Add Image"),
                            ],
                          ),
                        ),
                      ],
                    )),
                //TODO comment field
                const TextField(
                  maxLines: 5,
                  decoration: InputDecoration(
                    fillColor: ColorConstant.whiteBlack10,
                    labelStyle: TextStyle(
                        color: ColorConstant.whiteBlack90, fontSize: 16),
                    hintText: "แสดงความคิดเห็น",
                    hintStyle: TextStyle(
                        color: ColorConstant.whiteBlack50, fontSize: 16),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(8),
                            bottomRight: Radius.circular(8))),
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              const Spacer(),
              //TODO send comment
              TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    side: const BorderSide(
                        color: ColorConstant.orange50, width: 1),
                    alignment: Alignment.center,
                    fixedSize: const Size(125, 40),
                    foregroundColor: ColorConstant.white,
                    padding: const EdgeInsets.fromLTRB(24, 12, 24, 12),
                    backgroundColor: ColorConstant.orange50,
                    textStyle: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold)),
                child: Row(
                  children: const [
                    Padding(
                      padding: EdgeInsets.only(right: 8.0),
                      child: Icon(
                        Icons.send_rounded,
                        color: ColorConstant.white,
                        size: 24,
                      ),
                    ),
                    Text("Send"),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
