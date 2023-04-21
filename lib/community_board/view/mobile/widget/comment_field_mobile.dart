import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senior_project/assets/color_constant.dart';
import 'package:senior_project/community_board/model/community_board_model.dart';
import 'package:senior_project/community_board/view_model/community_board_view_model.dart';
import 'package:senior_project/core/view_model/app_view_model.dart';

class CommentFieldMobile extends StatefulWidget {
  final String docId;
  const CommentFieldMobile({super.key, required this.docId});

  @override
  State<CommentFieldMobile> createState() => _CommentFieldMobileState();
}

class _CommentFieldMobileState extends State<CommentFieldMobile> {
  String comment = "";

  @override
  Widget build(BuildContext context) {
    String commentText = context.watch<AppViewModel>().isLogin 
    ? "ช่องแสดงความคิดเห็น" 
    : "กรุณาลงชื่อเข้าสู่ระบบ";
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
        height: 344,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
            color: ColorConstant.whiteBlack5,
            border: Border.all(color: ColorConstant.whiteBlack40),
            borderRadius: BorderRadius.circular(8)),
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(bottom: 8),
                  child: Text(
                    "ช่องแสดงความคิดเห็น",
                    style: TextStyle(
                        color: ColorConstant.orange70,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                TextField(
                  maxLines: 5,
                  onChanged: (value) {
                    comment = value;
                  },
                  decoration: InputDecoration(
                    fillColor: ColorConstant.whiteBlack40,
                    hintText: commentText,
                    hintStyle: const TextStyle(
                        color: ColorConstant.whiteBlack60, fontSize: 14),
                    border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                  ),
                ),
              ],
            ),
          ),
          Container(
              width: double.infinity,
              padding: const EdgeInsets.only(bottom: 16),
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
          SizedBox(
            width: double.infinity,
            child: TextButton(
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
                  side: const BorderSide(color: ColorConstant.orange50, width: 1),
                  alignment: Alignment.center,
                  fixedSize: const Size(105, 40),
                  foregroundColor: ColorConstant.white,
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                  backgroundColor: ColorConstant.orange50,
                  textStyle:
                      const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Padding(
                    padding: EdgeInsets.only(right: 8),
                    child: Icon(
                      Icons.send_rounded,
                      color: ColorConstant.white,
                      size: 16,
                    ),
                  ),
                  Text("Send"),
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
