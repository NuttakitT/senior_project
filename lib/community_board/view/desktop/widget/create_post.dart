// ignore_for_file: use_build_context_synchronously

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:senior_project/assets/color_constant.dart';
import 'package:provider/provider.dart';
import 'package:senior_project/assets/font_style.dart';
import 'package:senior_project/community_board/model/community_board_model.dart';
import 'package:senior_project/community_board/view/page/community_board_view.dart';
import 'package:senior_project/community_board/view_model/community_board_view_model.dart';
import 'package:senior_project/core/template/template_desktop/view/widget/desktop/confirmation_popup.dart';
import 'package:uuid/uuid.dart';

class CreatePost extends StatefulWidget {
  final bool isEdit;
  final Map<String, dynamic> detail;
  const CreatePost({super.key, required this.isEdit, required this.detail});

  @override
  State<CreatePost> createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  String title = "";
  String detail = "";
  String addtopic = "";
  bool isTopicEmpty = false;
  bool ifSuccession = true;
  List<Topic> topic = [];
  String? selectedTopic = "General";
  XFile? pickedFile;
  Uint8List? imageFile;
  bool hasImage = false;

  TextEditingController titleTextController = TextEditingController();
  TextEditingController detailTextController = TextEditingController();
  TextEditingController addtopicTextController = TextEditingController();
  @override
  void initState() {
    if (widget.isEdit) {
      titleTextController.text = widget.detail["question"];
      detailTextController.text = widget.detail["answer"];
      setState(() {
        selectedTopic = widget.detail["category"];
      });
    }
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 12, top: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "${widget.isEdit ? "Edit" : "Create"} Frequently Ask Questions",
                            style: const TextStyle(
                              color: ColorConstant.orange70,
                              fontSize: 28,
                              fontWeight: FontWeight.bold),
                          ),
                          const TextSpan(
                            text: "\nFill in more information for add question.",
                            style: TextStyle(
                              color: ColorConstant.whiteBlack80,
                              fontSize: 18,
                              fontWeight: AppFontWeight.light),
                          ),
                        ]
                      ),
                    ),
                    Builder(
                      builder: (context) {
                        if (widget.isEdit) {
                          return InkWell(
                            onTap: () async {
                              showDialog(
                                context: context, 
                                builder: (context) => ConfirmationPopup(
                                  title: "Are you sure to delete the FAQ", 
                                  detail: "This action can be undone", 
                                  widget: null, 
                                  onCancel: () {
                                    Navigator.pop(context);
                                  }, 
                                  onConfirm: () async {
                                    await context.read<CommunityBoardViewModel>().deleteFaq(widget.detail["id"]);
                                    context.read<CommunityBoardViewModel>().setIsSafeLoad = true;
                                    Navigator.pushAndRemoveUntil(context,
                                        MaterialPageRoute(builder: (context) {
                                      return const CommunityBoardView();
                                    }), (route) => false);
                                  }
                                )
                              );
                            },
                            child: Row(
                              children: const [
                                Padding(
                                  padding: EdgeInsets.only(right: 8.0),
                                  child: Icon(Icons.delete_rounded, color: ColorConstant.whiteBlack60,)
                                ),
                                Text(
                                  "ลบข้อมูล",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: AppFontWeight.regular,
                                    color: ColorConstant.whiteBlack60
                                  ),
                                )
                              ],
                            ),
                          );
                        }
                        return Container();
                      },
                    ),
                  ],
                )
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 16, top: 16),
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
                              return SingleChildScrollView(
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(color: ColorConstant.whiteBlack40)
                                  ),
                                  width: double.infinity,
                                  alignment: Alignment.center,
                                  child: DropdownButton<String>(
                                    isExpanded: true,
                                    underline: Container(),
                                    value: selectedTopic,
                                    onChanged: (value) {
                                      setState(() {
                                        selectedTopic = value!;
                                      });
                                    },
                                    items: topic.map((topic) => DropdownMenuItem<String>(value: topic.name, child: Text(topic.name))).toList(),
                                  )
                                  // Column(children: <Widget>[
                                  //   MultiSelectDialogField(
                                  //       items: topic
                                  //           .map((topic) =>
                                  //               MultiSelectItem<Topic>(
                                  //                   topic, topic.name))
                                  //           .toList(),
                                  //       title: const Text("Topics"),
                                  //       selectedColor: ColorConstant.orange40,
                                  //       decoration: BoxDecoration(
                                  //           color: ColorConstant.white,
                                  //           borderRadius:
                                  //               const BorderRadius.all(
                                  //                   Radius.circular(8)),
                                  //           border: Border.all(
                                  //               color:
                                  //                   ColorConstant.whiteBlack60,
                                  //               width: 1)),
                                  //       buttonIcon: const Icon(
                                  //         Icons.arrow_drop_down_rounded,
                                  //         color: ColorConstant.whiteBlack90,
                                  //       ),
                                  //       buttonText: const Text(
                                  //         "Select Topic",
                                  //         style: TextStyle(
                                  //             color: ColorConstant.whiteBlack90,
                                  //             fontSize: 16),
                                  //       ),
                                  //       onConfirm: (results) {
                                  //         for (int i = 0;
                                  //             i < results.length;
                                  //             i++) {
                                  //           topics.add(results[i].name);
                                  //         }
                                  //       })
                                  // ]),
                                ),
                              );
                            })),
                          ),
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
                        "Question",
                        style: TextStyle(
                            color: ColorConstant.whiteBlack90, fontSize: 18),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(Radius.circular(8)),
                        border: Border.all(color: ColorConstant.whiteBlack40)
                      ),
                      padding: const EdgeInsets.all(16),
                      height: 140,
                      child: TextField(
                        maxLines: null,
                        controller: titleTextController,
                        onTap: () {
                          context
                              .read<CommunityBoardViewModel>()
                              .setIsTitleNotEmpty = true;
                        },
                        decoration: InputDecoration.collapsed(
                          hintText:
                              !isTitleNotEmpty ? "Please fill in information" : "",
                          hintStyle: TextStyle(
                              color: !isTitleNotEmpty
                                  ? ColorConstant.red40
                                  : ColorConstant.whiteBlack60,
                              fontSize: 16),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(bottom: 8),
                      child: Text(
                        "Answer",
                        style: TextStyle(
                            color: ColorConstant.whiteBlack90, fontSize: 18),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(Radius.circular(8)),
                        border: Border.all(color: ColorConstant.whiteBlack40)
                      ),
                      padding: const EdgeInsets.all(16),
                      height: 140,
                      child: TextField(
                        onTap: () {
                          context
                              .read<CommunityBoardViewModel>()
                              .setIsDetailNotEmpty = true;
                        },
                        maxLines: null,
                        controller: detailTextController,
                        decoration: InputDecoration.collapsed(
                          hintText: !isDetailNotEmpty
                              ? "Please fill in information"
                              : "",
                          hintStyle: TextStyle(
                              color: !isDetailNotEmpty
                                  ? ColorConstant.red40
                                  : ColorConstant.whiteBlack60,
                              fontSize: 16),
                        ),
                      ),
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
                        child: Text(
                          widget.isEdit ? "Save" : "Add",
                          style: const TextStyle(
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
                      isDetailNotEmpty = context
                          .read<CommunityBoardViewModel>()
                          .getIsDetailNotEmpty;
                      isTitleNotEmpty = context
                          .read<CommunityBoardViewModel>()
                          .getIsTitleNotEmpty;
                      if (selectedTopic!.isNotEmpty && isTitleNotEmpty && isDetailNotEmpty) {
                        showDialog(
                          context: context, 
                          builder: (context) => ConfirmationPopup(
                            title: "Are you sure to ${widget.isEdit ? "save" : "add"} the FAQ", 
                            detail: "This action can be undone", 
                            widget: null, 
                            onCancel: () {
                              Navigator.pop(context);
                            }, 
                            onConfirm: () async {
                              if (widget.isEdit) {
                                await context.read<CommunityBoardViewModel>().editFaq(
                                  widget.detail["id"], 
                                  {
                                    "question": title,
                                    "answer": detail,
                                    "category": selectedTopic
                                  }
                                );
                                context.read<CommunityBoardViewModel>().setIsSafeLoad = true;
                                Navigator.pushAndRemoveUntil(context,
                                    MaterialPageRoute(builder: (context) {
                                  return const CommunityBoardView();
                                }), (route) => false);
                              } else {
                                await context.read<CommunityBoardViewModel>().createFaq({
                                  "question": title,
                                  "answer": detail,
                                  "category": selectedTopic
                                });
                                context.read<CommunityBoardViewModel>().setIsSafeLoad = true;
                                Navigator.pushAndRemoveUntil(context,
                                    MaterialPageRoute(builder: (context) {
                                  return const CommunityBoardView();
                                }), (route) => false);
                              }
                            }
                          )
                        );
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
