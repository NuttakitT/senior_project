// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:senior_project/assets/color_constant.dart';
import 'package:senior_project/community_board/view_model/community_board_view_model.dart';
import 'package:senior_project/core/datasource/firebase_services.dart';
import 'package:senior_project/core/view_model/app_view_model.dart';

class CommentTemplateMobile extends StatefulWidget {
  final Map<String, dynamic> info;
  final int index;
  final String parentId;
  const CommentTemplateMobile({super.key, required this.info, required this.index, required this.parentId});

  @override
  State<CommentTemplateMobile> createState() => _CommentTemplateMobileState();
}

class _CommentTemplateMobileState extends State<CommentTemplateMobile> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirebaseServices("user").getDocumentById(widget.info["ownerId"]),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
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
                                showDialog(context: context, builder: (context) {
                                  // TODO confirm design?
                                  return AlertDialog(
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const Text("Confirm delete?"),
                                        TextButton(
                                          onPressed: () {
                                            context.read<CommunityBoardViewModel>().deleteComment(widget.parentId, widget.info["id"]);
                                            Navigator.pop(context);
                                          }, 
                                          child: const Text("OK")
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          }, 
                                          child: const Text("Cancel")
                                        )
                                      ],
                                    ),
                                  );
                                });
                              },
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
                        );
                      },
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
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: Text(
                              snapshot.data!.get("name").toString().split(" ")[0],
                              style: const TextStyle(
                                  color: ColorConstant.whiteBlack70, fontSize: 16),
                            ),
                          ),
                          Text(
                            DateFormat("d MMMM.").format(widget.info["dateCreate"]).toString(),
                            style: const TextStyle(
                                color: ColorConstant.whiteBlack50, fontSize: 12),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Text(
                  widget.info["detail"],
                  style: const TextStyle(color: ColorConstant.whiteBlack90, fontSize: 16),
                )
                // TODO picture
              ],
            ),
          );
        }
        return Container();
      }
    );
  }
}
