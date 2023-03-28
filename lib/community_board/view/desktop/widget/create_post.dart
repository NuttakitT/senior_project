import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:senior_project/assets/color_constant.dart';

class CreatePost extends StatefulWidget {
  const CreatePost({super.key});

  @override
  State<CreatePost> createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 24, 24, 24),
      decoration: const BoxDecoration(color: ColorConstant.white),
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(bottom: 12, top: 8),
            child: Text(
              "Create Post",
              style: TextStyle(
                  color: ColorConstant.orange70,
                  fontSize: 28,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            height: 1,
            decoration: const BoxDecoration(color: ColorConstant.whiteBlack30),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Padding(
                  padding: EdgeInsets.only(bottom: 8),
                  child: Text(
                    "ระบุหัวข้อของคุณ",
                    style: TextStyle(
                        color: ColorConstant.whiteBlack90, fontSize: 18),
                  ),
                ),
                TextField(
                  decoration: InputDecoration(
                    hintText: "หัวข้อ",
                    hintStyle: TextStyle(
                        color: ColorConstant.whiteBlack60, fontSize: 16),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(bottom: 8),
                  child: Text(
                    "Topic",
                    style: TextStyle(
                        color: ColorConstant.whiteBlack90, fontSize: 18),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(right: 8),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "topic",
                      hintStyle: TextStyle(
                          color: ColorConstant.whiteBlack60, fontSize: 16),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8))),
                    ),
                  ),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Stack(children: <Widget>[
                    Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: ColorConstant.orange50,
                                width: 1,
                                strokeAlign: StrokeAlign.outside)),
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(
                          fixedSize: const Size.fromHeight(40),
                          foregroundColor: ColorConstant.orange50,
                          padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
                          backgroundColor: ColorConstant.white,
                          textStyle: const TextStyle(
                              fontSize: 12, fontWeight: FontWeight.w500)),
                      child: Row(
                        children: const [
                          Icon(
                            Icons.add,
                            color: ColorConstant.orange50,
                            size: 16,
                          ),
                          Text("Add Topic"),
                        ],
                      ),
                    ),
                  ]),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(bottom: 8),
                  child: Text(
                    "รายละเอียด",
                    style: TextStyle(
                        color: ColorConstant.whiteBlack90, fontSize: 18),
                  ),
                ),
                Column(
                  children: [
                    Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(8),
                                topRight: Radius.circular(8)),
                            color: ColorConstant.whiteBlack10,
                            border:
                                Border.all(color: ColorConstant.whiteBlack40)),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Stack(children: <Widget>[
                                Positioned.fill(
                                  child: Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: ColorConstant.orange50,
                                            width: 1,
                                            strokeAlign: StrokeAlign.outside)),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {},
                                  style: TextButton.styleFrom(
                                      fixedSize: const Size.fromWidth(116),
                                      foregroundColor: ColorConstant.orange50,
                                      padding: const EdgeInsets.fromLTRB(
                                          16, 8, 16, 8),
                                      backgroundColor: ColorConstant.white,
                                      textStyle: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold)),
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
                              ]),
                            ),
                          ],
                        )),
                    const TextField(
                      decoration: InputDecoration(
                        hintText: "รายละเอียด",
                        hintStyle: TextStyle(
                            color: ColorConstant.whiteBlack60, fontSize: 16),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(8),
                                bottomRight: Radius.circular(8))),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          InkWell(
            child: Container(
                alignment: Alignment.center,
                height: 40,
                padding: const EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                    color: ColorConstant.orange50,
                    borderRadius: BorderRadius.circular(16)),
                child: const Text(
                  "Post",
                  style: TextStyle(
                      color: ColorConstant.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                )),
            onTap: () {},
          )
        ],
      ),
    );
  }
}
