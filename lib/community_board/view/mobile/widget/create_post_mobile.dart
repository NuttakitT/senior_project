import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:senior_project/assets/color_constant.dart';
import 'package:provider/provider.dart';

class CreatePostMobile extends StatefulWidget {
  const CreatePostMobile({super.key});

  @override
  State<CreatePostMobile> createState() => _CreatePostMobileState();
}

class Topic {
  final int id;
  final String name;

  Topic({required this.id, required this.name});
}

late String title;
late String detail;
late List<String> topics;
bool isTitleEmpty = false;
bool isDetailEmpty = false;
bool isTopicEmpty = false;
List<Topic> _topic = [
  Topic(id: 1, name: "ทุนการศึกษา"),
  Topic(id: 2, name: "การฝึกงาน"),
  Topic(id: 3, name: "การลงทะเบียน"),
  Topic(id: 4, name: "การจบการศึกษา"),
  Topic(id: 5, name: "รายวิชา"),
  Topic(id: 6, name: "กิจกรรม"),
];
final _itemList =
    _topic.map((topic) => MultiSelectItem<Topic>(topic, topic.name)).toList();
List<Topic> _selectedTopic = [];
TextEditingController titleTextController = TextEditingController();
TextEditingController detailTextController = TextEditingController();

class _CreatePostMobileState extends State<CreatePostMobile> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 40, bottom: 24),
          child: Container(
            width: double.infinity,
            constraints: const BoxConstraints(maxHeight: 30),
            decoration: const BoxDecoration(color: ColorConstant.white),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: const [
                Padding(
                  padding: EdgeInsets.only(right: 100),
                  child: Padding(
                    padding: EdgeInsets.only(left: 16),
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: ColorConstant.whiteBlack90,
                        size: 24,
                      ),
                    ),
                  ),
                ),
                Text(
                  "Create Post",
                  style: TextStyle(
                      color: ColorConstant.whiteBlack90,
                      fontWeight: FontWeight.w500,
                      fontSize: 28),
                )
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 16, right: 16, left: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(bottom: 8),
                child: Text(
                  "ระบุหัวข้อของคุณ",
                  style: TextStyle(
                      color: ColorConstant.whiteBlack90, fontSize: 18),
                ),
              ),
              TextField(
                controller: titleTextController,
                decoration: const InputDecoration(
                  hintText: "หัวข้อ",
                  hintStyle: TextStyle(
                      color: ColorConstant.whiteBlack60, fontSize: 14),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8))),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 16, left: 16, right: 16),
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
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 428),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //TODO
                    SingleChildScrollView(
                      child: Container(
                        width: 272,
                        alignment: Alignment.center,
                        child: Column(children: <Widget>[
                          MultiSelectDialogField(
                              items: _itemList,
                              title: Text("Topics"),
                              selectedColor: ColorConstant.orange40,
                              decoration: BoxDecoration(
                                  color: ColorConstant.white,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(8)),
                                  border: Border.all(
                                      color: ColorConstant.whiteBlack60,
                                      width: 1)),
                              buttonIcon: const Icon(
                                Icons.arrow_drop_down_rounded,
                                color: ColorConstant.whiteBlack90,
                              ),
                              buttonText: const Text(
                                "Select Topic",
                                style: TextStyle(
                                    color: ColorConstant.whiteBlack90,
                                    fontSize: 16),
                              ),
                              onConfirm: (results) {
                                _selectedTopic = results;
                              })
                        ]),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                            side: const BorderSide(
                                color: ColorConstant.orange50, width: 1),
                            fixedSize: const Size(88, 40),
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
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
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
                      color: ColorConstant.whiteBlack90, fontSize: 18),
                ),
              ),
              TextField(
                decoration: InputDecoration(
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
                padding: EdgeInsets.only(bottom: 16),
                child: Text(
                  "เพิ่มรูปภาพ",
                  style: TextStyle(
                      color: ColorConstant.whiteBlack90, fontSize: 18),
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
          ),
        ),
        InkWell(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: Container(
                alignment: Alignment.center,
                height: 40,
                padding: const EdgeInsets.symmetric(
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                    color: ColorConstant.orange50,
                    borderRadius: BorderRadius.circular(8)),
                child: const Text(
                  "Post",
                  style: TextStyle(
                      color: ColorConstant.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                )),
          ),
        ),
      ],
    );
  }
}
