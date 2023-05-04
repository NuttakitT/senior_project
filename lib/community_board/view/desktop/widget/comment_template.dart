// ignore_for_file: depend_on_referenced_packages, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:senior_project/assets/color_constant.dart';
import 'package:senior_project/community_board/model/community_board_model.dart';
import 'package:senior_project/community_board/view_model/community_board_view_model.dart';
import 'package:senior_project/core/datasource/firebase_services.dart';
import 'package:senior_project/core/view_model/app_view_model.dart';

class CommentTemplate extends StatefulWidget {
  final Map<String, dynamic> info;
  final int index;
  final String parentId;
  const CommentTemplate({super.key, required this.info, required this.index, required this.parentId});

  @override
  State<CommentTemplate> createState() => _CommentTemplateState();
}

class _CommentTemplateState extends State<CommentTemplate> {
  bool isEditiing = false;
  String editText = "";
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    controller.text = widget.info["detail"];
    controller.addListener(() {
      editText = controller.text;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirebaseServices("user").getDocumentById(widget.info["ownerId"]),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
                color: ColorConstant.whiteBlack5,
                borderRadius: const BorderRadius.all(Radius.circular(16)),
                border: Border.all(color: ColorConstant.whiteBlack40)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 24),
                      child: Text(
                        "ความคิดเห็นที่ ${widget.index}",
                        style: const TextStyle(
                            color: ColorConstant.orange70,
                            fontSize: 20,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    const Spacer(),
                    Builder(
                      builder: (context) {
                        String uid = context.read<AppViewModel>().app.getUser.getId;
                        if (widget.info["ownerId"] != uid) {
                          return Container();
                        }
                        return Row(
                          children: [
                            TextButton(
                              onPressed: () {
                                if (!(!editText.isNotEmpty && isEditiing) && editText != widget.info["detail"]) {
                                  showDialog(context: context, builder: (context) {
                                    return AlertDialog(
                                      content: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text("Confirm ${isEditiing ? "edit" : "delete"}?"),
                                          TextButton(
                                            onPressed: () async {
                                              if (!isEditiing) {
                                                await context.read<CommunityBoardViewModel>().deleteComment(widget.parentId, widget.info["id"]);
                                              } else {
                                                EditCommentRequest request = EditCommentRequest(
                                                  widget.info["parentId"], 
                                                  widget.info["id"], 
                                                  editText
                                                );
                                                await context.read<CommunityBoardViewModel>().editComment(request);
                                                setState(() {isEditiing = false;});
                                                editText = "";
                                              }
                                              Navigator.pop(context);
                                            }, 
                                            child: const Text("OK")
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              setState(() {isEditiing = false;});
                                              controller.text = widget.info["detail"];
                                              editText = "";
                                              Navigator.pop(context);
                                            }, 
                                            child: const Text("Cancel")
                                          )
                                        ],
                                      ),
                                    );
                                  });
                                }
                              },
                              style: TextButton.styleFrom(
                                  padding: const EdgeInsets.fromLTRB(0, 0, 24, 0),
                                  foregroundColor: ColorConstant.whiteBlack80,
                                  textStyle: const TextStyle(fontSize: 16)),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: Icon(
                                      isEditiing 
                                      ? Icons.done_rounded 
                                      : Icons.delete_rounded,
                                      color: ColorConstant.whiteBlack80,
                                      size: 24,
                                    ),
                                  ),
                                  Builder(
                                    builder: (context) {
                                      if (!isEditiing) {
                                        return const Text("ลบข้อความ");
                                      }
                                      return Container();
                                    }
                                  ),
                                ],
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  isEditiing = !isEditiing;
                                });
                              },
                              style: TextButton.styleFrom(
                                  foregroundColor: ColorConstant.whiteBlack80,
                                  textStyle: const TextStyle(fontSize: 16)),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: Icon(
                                      isEditiing 
                                      ? Icons.close_rounded 
                                      : Icons.border_color_rounded,
                                      color: ColorConstant.whiteBlack80,
                                      size: 24,
                                    ),
                                  ),
                                  Builder(
                                    builder: (context) {
                                      if (!isEditiing) {
                                        return const Text("แก้ไขข้อความ");
                                      }
                                      return Container();
                                    }
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      }
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 40),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 16),
                        child: Container(
                          height: 48,
                          width: 48,
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
                      Padding(
                        padding: const EdgeInsets.only(right: 24),
                        child: Text(
                          snapshot.data!.get("name").toString().split(" ")[0],
                          style: const TextStyle(
                              color: ColorConstant.whiteBlack70, fontSize: 24),
                        ),
                      ),
                      Builder(
                        builder: (context) {
                          String text = widget.info["dateEdit"] != null
                          ? "Edited at ${DateFormat("d MMMM h:mm a.").format(widget.info["dateEdit"].toDate()).toString()}"
                          : "Created at ${DateFormat("d MMMM h:mm a.").format(widget.info["dateCreate"]).toString()}";
                          return Text(
                            text,
                            style: const TextStyle(
                                color: ColorConstant.whiteBlack50, fontSize: 16),
                          );
                        },
                      )
                    ],
                  ),
                ),
                Builder(
                  builder: (context) {
                    if (isEditiing) {
                      return TextField(
                        maxLines: 5,
                        controller: controller,
                        style: const TextStyle(
                          color: ColorConstant.whiteBlack90, fontSize: 20),
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(8),
                                  bottomRight: Radius.circular(8))),
                        ),
                      );
                    }
                    return Text(
                      widget.info["detail"],
                      style: const TextStyle(color: ColorConstant.whiteBlack90, fontSize: 20),
                    );
                  },
                ),
                Builder(
                  builder: (context) {
                    if (widget.info["imageUrl"] != null) {
                      return Image.network(widget.info["imageUrl"]);
                    }
                    return Container();
                  },
                ),
              ],
            ),
          );
        }
        return Container();
      }
    );
  }
}
