import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senior_project/assets/color_constant.dart';
import 'package:senior_project/community_board/model/community_board_model.dart';
import 'package:senior_project/community_board/view_model/community_board_view_model.dart';
import 'package:senior_project/core/view_model/app_view_model.dart';

class CommentField extends StatefulWidget {
  final String docId;
  const CommentField({super.key, required this.docId});

  @override
  State<CommentField> createState() => _CommentFieldState();
}

class _CommentFieldState extends State<CommentField> {
  String comment = "";

  @override
  Widget build(BuildContext context) {
    String commentText = context.watch<AppViewModel>().isLogin 
    ? "ช่องแสดงความคิดเห็น" 
    : "กรุณาลงชื่อเข้าสู่ระบบ";
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
                        TextButton(
                          onPressed: () {
                            if(!context.watch<AppViewModel>().isLogin) {
                              //TODO add image
                            }
                          },
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
                                size: 12,
                              ),
                              Text("Add Image"),
                            ],
                          ),
                        ),
                      ],
                    )),
                TextField(
                  maxLines: 5,
                  readOnly: !context.watch<AppViewModel>().isLogin,
                  onChanged: (value) {
                    comment = value;
                  },
                  decoration: InputDecoration(
                    fillColor: ColorConstant.whiteBlack10,
                    labelStyle: const TextStyle(
                        color: ColorConstant.whiteBlack90, fontSize: 16),
                    hintText: commentText,
                    hintStyle: const TextStyle(
                        color: ColorConstant.whiteBlack50, fontSize: 16),
                    border: const OutlineInputBorder(
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
              Builder(
                builder: (context) {
                  if (!context.watch<AppViewModel>().isLogin) {
                    return Container();
                  }
                  return TextButton(
                    onPressed: () async {
                      if (context.read<AppViewModel>().isLogin && comment.isNotEmpty) {
                        String ownerId = context.read<AppViewModel>().app.getUser.getId;
                        CreateCommentRequest request = CreateCommentRequest(widget.docId, ownerId, comment);
                        await context.read<CommunityBoardViewModel>().createComment(request);
                      }
                    },
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
                  );
                }
              ),
            ],
          ),
        ],
      ),
    );
  }
}
