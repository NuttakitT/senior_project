// ignore_for_file: use_build_context_synchronously

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:senior_project/assets/color_constant.dart';
import 'package:provider/provider.dart';
import 'package:senior_project/community_board/model/community_board_model.dart';
import 'package:senior_project/community_board/view/page/community_board_view.dart';
import 'package:senior_project/community_board/view_model/community_board_view_model.dart';
import 'package:uuid/uuid.dart';

class CreatePost extends StatefulWidget {
  const CreatePost({super.key});

  @override
  State<CreatePost> createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  String title = "";
  String detail = "";
  String addtopic = "";
  bool isTopicEmpty = false;
  bool checkAddTopic = false;
  bool ifSuccession = true;
  List<Topic> topic = [];
  List<String> topics = [];
  XFile? pickedFile;
  Uint8List? imageFile;
  bool hasImage = false;

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
    addtopicTextController.addListener(() {
      addtopic = addtopicTextController.text;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool isDetailNotEmpty =
        context.watch<CommunityBoardViewModel>().getIsDetailNotEmpty;
    bool isTitleNotEmpty =
        context.watch<CommunityBoardViewModel>().getIsTitleNotEmpty;
    topic = context.watch<CommunityBoardViewModel>().getAllTopic;

    return SingleChildScrollView(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 644),
        child: Container(
          width: 707,
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
                decoration:
                    const BoxDecoration(color: ColorConstant.whiteBlack30),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
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
                      onTap: () {
                        context
                            .read<CommunityBoardViewModel>()
                            .setIsTitleNotEmpty = true;
                      },
                      decoration: InputDecoration(
                        hintText:
                            !isTitleNotEmpty ? "กรุณากรอกหัวข้อ" : "หัวข้อ",
                        hintStyle: TextStyle(
                            color: !isTitleNotEmpty
                                ? ColorConstant.red40
                                : ColorConstant.whiteBlack60,
                            fontSize: 16),
                        border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8))),
                      ),
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
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(8))),
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
                                            .map((topic) =>
                                                MultiSelectItem<Topic>(
                                                    topic, topic.name))
                                            .toList(),
                                        title: const Text("Topics"),
                                        selectedColor: ColorConstant.orange40,
                                        decoration: BoxDecoration(
                                            color: ColorConstant.white,
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(8)),
                                            border: Border.all(
                                                color:
                                                    ColorConstant.whiteBlack60,
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
                                          for (int i = 0;
                                              i < results.length;
                                              i++) {
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
                                  padding:
                                      const EdgeInsets.fromLTRB(8, 8, 8, 8),
                                  backgroundColor: ColorConstant.white,
                                  textStyle: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500)),
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
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                      side: const BorderSide(
                                          color: ColorConstant.orange50,
                                          width: 1),
                                      fixedSize: const Size(40, 40),
                                      foregroundColor: ColorConstant.orange50,
                                      padding:
                                          const EdgeInsets.fromLTRB(8, 8, 8, 8),
                                      backgroundColor: ColorConstant.white,
                                      textStyle: const TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500)),
                                  child: const Text("Cancel"),
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
                                border: Border.all(
                                    color: ColorConstant.whiteBlack40)),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Builder(
                                  builder: (context) {
                                    if (hasImage) {
                                      return Row(
                                        children: [
                                          Text(pickedFile!.name),
                                          IconButton(
                                            onPressed: () {
                                              imageFile = null;
                                              setState(() {
                                                hasImage = false;
                                              });
                                            }, 
                                            icon: const Icon(
                                              Icons.delete_rounded
                                            )
                                          )
                                        ],
                                      );
                                    }
                                    return TextButton(
                                      onPressed: () async {
                                        pickedFile = await ImagePicker()
                                          .pickImage(
                                              source: ImageSource.gallery);
                                        if (pickedFile != null) {
                                          imageFile = await pickedFile!.readAsBytes();
                                          setState(() {
                                            hasImage = true;
                                          });
                                        }
                                      },
                                      style: TextButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                          side: const BorderSide(
                                              color: ColorConstant.orange50,
                                              width: 1),
                                          fixedSize: const Size(116, 28),
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
                                            size: 12,
                                          ),
                                          Text("Add Image"),
                                        ],
                                      ),
                                    );
                                  }
                                ),
                              ],
                            )),
                        TextField(
                          onTap: () {
                            context
                                .read<CommunityBoardViewModel>()
                                .setIsDetailNotEmpty = true;
                          },
                          maxLines: 7,
                          controller: detailTextController,
                          decoration: InputDecoration(
                            hintText: !isDetailNotEmpty
                                ? "กรุณากรอกรายละเอียด"
                                : "รายละเอียด",
                            hintStyle: TextStyle(
                                color: !isDetailNotEmpty
                                    ? ColorConstant.red40
                                    : ColorConstant.whiteBlack60,
                                fontSize: 16),
                            border: const OutlineInputBorder(
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    child: Container(
                        constraints: const BoxConstraints(maxWidth: 300),
                        width: double.infinity,
                        alignment: Alignment.center,
                        height: 40,
                        padding: const EdgeInsets.symmetric(
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                            color: ColorConstant.white,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: ColorConstant.orange50)),
                        child: const Text(
                          "Cancel",
                          style: TextStyle(
                              color: ColorConstant.orange50,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        )),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  InkWell(
                    child: Container(
                        constraints: const BoxConstraints(maxWidth: 300),
                        width: double.infinity,
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
                    onTap: () async {
                      context
                              .read<CommunityBoardViewModel>()
                              .setIsTitleNotEmpty =
                          context
                              .read<CommunityBoardViewModel>()
                              .validateNameField(title);
                      context
                              .read<CommunityBoardViewModel>()
                              .setIsDetailNotEmpty =
                          context
                              .read<CommunityBoardViewModel>()
                              .validateNameField(detail);
                      if (topics.isEmpty) {
                        topics.add("General");
                      }
                      isDetailNotEmpty = context
                          .read<CommunityBoardViewModel>()
                          .getIsDetailNotEmpty;
                      isTitleNotEmpty = context
                          .read<CommunityBoardViewModel>()
                          .getIsTitleNotEmpty;
                      if ((isTitleNotEmpty && isDetailNotEmpty)) {
                        String? imageUrl = await context.read<CommunityBoardViewModel>().getImageUrl(imageFile, "${const Uuid().v1()}_${pickedFile!.name}", "post");
                        final request = CreatePostRequest(
                          title: title,
                          detail: detail,
                          topics: topics,
                          imageUrl: imageUrl
                        );
                        await context
                            .read<CommunityBoardViewModel>()
                            .createPost(request, context);

                        Navigator.pushAndRemoveUntil(context,
                            MaterialPageRoute(builder: (context) {
                          return const CommunityBoardView();
                        }), (route) => false);
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
