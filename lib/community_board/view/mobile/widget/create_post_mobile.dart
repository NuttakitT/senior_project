import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:senior_project/assets/color_constant.dart';
import 'package:provider/provider.dart';
import 'package:senior_project/community_board/view/mobile/page/template_community_board_mobile.dart';
import 'package:uuid/uuid.dart';

import '../../../model/community_board_model.dart';
import '../../../view_model/community_board_view_model.dart';

class CreatePostMobile extends StatefulWidget {
  const CreatePostMobile({super.key});

  @override
  State<CreatePostMobile> createState() => _CreatePostMobileState();
}

class Topic {
  final String name;

  Topic({required this.name});
}

class _CreatePostMobileState extends State<CreatePostMobile> {
  String title = "";
  String detail = "";
  String addtopic = "";
  List<String> topics = [];
  bool isTitleNotEmpty = true;
  bool isDetailNotEmpty = true;
  bool isTopicEmpty = false;
  bool checkAddTopic = false;
  bool ifSuccession = true;
  List<Topic> topic = [
    Topic(name: "General"),
    Topic(name: "ทุนการศึกษา"),
    Topic(name: "การฝึกงาน"),
    Topic(name: "การลงทะเบียน"),
    Topic(name: "การจบการศึกษา"),
    Topic(name: "รายวิชา"),
    Topic(name: "กิจกรรม"),
  ];

  TextEditingController titleTextController = TextEditingController();
  TextEditingController detailTextController = TextEditingController();
  TextEditingController addtopicTextController = TextEditingController();
  @override
  void initState() {
    titleTextController.addListener(() {
      title = titleTextController.text;
    });
    detailTextController.addListener(() {
      detail = detailTextController.text;
    });

    super.initState();
  }

  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 24, bottom: 24),
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
                decoration: InputDecoration(
                  hintText: !isTitleNotEmpty ? "กรุณากรอกหัวข้อ" : "หัวข้อ",
                  hintStyle: TextStyle(
                      color: !isTitleNotEmpty
                          ? ColorConstant.red40
                          : ColorConstant.whiteBlack60,
                      fontSize: 14),
                  border: const OutlineInputBorder(
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
                constraints: const BoxConstraints(maxWidth: 659),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Builder(builder: ((context) {
                        if (checkAddTopic) {
                          return SizedBox(
                            height: 40,
                            child: TextField(
                              controller: addtopicTextController,
                              decoration: const InputDecoration(
                                hintText: "เพิ่ม Topic ของคุณ",
                                hintStyle: TextStyle(
                                    color: ColorConstant.whiteBlack60,
                                    fontSize: 12),
                                border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8))),
                              ),
                            ),
                          );
                        }
                        return SingleChildScrollView(
                          child: Container(
                            alignment: Alignment.center,
                            child: Column(children: <Widget>[
                              MultiSelectDialogField(
                                  items: topic
                                      .map((topic) => MultiSelectItem<Topic>(
                                          topic, topic.name))
                                      .toList(),
                                  title: const Text("Topics"),
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
                                    for (int i = 0; i < results.length; i++) {
                                      topics.add(results[i].name);
                                    }
                                  })
                            ]),
                          ),
                        );
                      })),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: TextButton(
                        onPressed: () async {
                          if (checkAddTopic) {
                            final request = CreateTagRequest(
                              id: const Uuid().v1(),
                              name: addtopic,
                            );
                            if (ifSuccession) {
                              setState(() {
                                ifSuccession = false;
                              });
                              bool ifSuccess = await context
                                  .read<CommunityBoardViewModel>()
                                  .createTopics(request);
                              if (ifSuccess) {
                                setState(() {
                                  ifSuccession = true;
                                  topic.add(Topic(name: addtopic));
                                  checkAddTopic = false;
                                });
                              }
                            }
                          } else {
                            setState(() {
                              checkAddTopic = true;
                            });
                          }
                        },
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
                    Builder(builder: ((context) {
                      if (checkAddTopic) {
                        return Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: TextButton(
                            onPressed: () {
                              setState(() {
                                checkAddTopic = false;
                              });
                            },
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
                            child: const Text("Cancle"),
                          ),
                        );
                      }
                      return Container();
                    }))
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
            children: [
              const Padding(
                padding: EdgeInsets.only(bottom: 8),
                child: Text(
                  "รายละเอียด",
                  style: TextStyle(
                      color: ColorConstant.whiteBlack90, fontSize: 18),
                ),
              ),
              TextField(
                controller: detailTextController,
                decoration: InputDecoration(
                  hintText:
                      !isDetailNotEmpty ? "กรุณากรอกรายละเอียด" : "รายละเอียด",
                  hintStyle: TextStyle(
                      color: !isDetailNotEmpty
                          ? ColorConstant.red40
                          : ColorConstant.whiteBlack60,
                      fontSize: 14),
                  border: const OutlineInputBorder(
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
              //TODO add image
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
          onTap: () async {
            setState(() {
              isTitleNotEmpty = context
                  .read<CommunityBoardViewModel>()
                  .validateNameField(title);
            });
            setState(() {
              isDetailNotEmpty = context
                  .read<CommunityBoardViewModel>()
                  .validateNameField(detail);
            });
            if (topics.isEmpty) {
              topics.add("General");
            }
            if ((isTitleNotEmpty && isDetailNotEmpty)) {
              final request = CreatePostRequest(
                title: title,
                detail: detail,
                topics: topics,
              );
              await context
                  .read<CommunityBoardViewModel>()
                  .createPost(request, context);

              Navigator.pushAndRemoveUntil(context,
                  MaterialPageRoute(builder: (context) {
                return const TemplateCommunityBoardMobile();
              }), (route) => false);
            }
          },
        ),
      ],
    );
  }
}