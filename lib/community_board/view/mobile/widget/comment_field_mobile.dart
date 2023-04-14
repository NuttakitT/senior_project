import 'package:flutter/material.dart';
import 'package:senior_project/assets/color_constant.dart';

class CommentFieldMobile extends StatefulWidget {
  const CommentFieldMobile({super.key});

  @override
  State<CommentFieldMobile> createState() => _CommentFieldMobileState();
}

class _CommentFieldMobileState extends State<CommentFieldMobile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: ColorConstant.whiteBlack5,
          border: Border.all(color: ColorConstant.whiteBlack40),
          borderRadius: BorderRadius.circular(8)),
      child: Column(children: [
        Padding(
          padding: const EdgeInsets.only(right: 16, left: 16, bottom: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Padding(
                padding: EdgeInsets.only(bottom: 8),
                child: Text(
                  "รายละเอียด",
                  style: TextStyle(
                      color: ColorConstant.orange70,
                      fontSize: 20,
                      fontWeight: FontWeight.w500),
                ),
              ),
              TextField(
                decoration: InputDecoration(
                  fillColor: ColorConstant.whiteBlack40,
                  hintText: "รายละเอียด",
                  hintStyle: TextStyle(
                      color: ColorConstant.whiteBlack60, fontSize: 14),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8))),
                ),
              ),
            ],
          ),
        ),
        Container(
            width: double.infinity,
            padding: const EdgeInsets.only(right: 16, left: 16, bottom: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(bottom: 8),
                  child: Text(
                    "เพิ่มรูปภาพ",
                    style: TextStyle(
                        color: ColorConstant.whiteBlack90, fontSize: 16),
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      side: const BorderSide(
                          color: ColorConstant.orange50, width: 1),
                      fixedSize: const Size(125, 32),
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
        Container(
          decoration: const BoxDecoration(
              color: ColorConstant.orange50,
              borderRadius: BorderRadius.all(Radius.circular(8))),
          child: Row(
            children: const [
              Padding(
                padding: EdgeInsets.only(right: 4),
                child: Icon(
                  Icons.send_rounded,
                  color: ColorConstant.white,
                  size: 16,
                ),
              ),
              Text(
                "Send",
                style: TextStyle(
                    color: ColorConstant.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
        )
      ]),
    );
  }
}
