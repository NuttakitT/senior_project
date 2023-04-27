// ignore_for_file: depend_on_referenced_packages

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:senior_project/assets/color_constant.dart';
import 'package:senior_project/community_board/view/desktop/widget/content_card_template.dart';
import 'package:senior_project/community_board/view/mobile/widget/community_board_content_card_mobile.dart';
import 'package:senior_project/community_board/view_model/community_board_view_model.dart';
import 'package:senior_project/core/datasource/firebase_services.dart';
import 'package:senior_project/core/template/template_desktop/view_model/template_desktop_view_model.dart';

class PostLoader extends StatefulWidget {
  final bool isMobile;
  const PostLoader({super.key, required this.isMobile});

  @override
  State<PostLoader> createState() => _PostLoaderState();
}

class _PostLoaderState extends State<PostLoader> {
  final postService = FirebaseServices("post");

  List<Widget> generateCardCommunityBoard(List<Map<String, dynamic>> listPost, bool isMobile) {
    List<Widget> card = [];
    for (int i = 0; i < listPost.length; i++) {
      if (isMobile) {
        card.add(CommunityBoardContentCardMobile(
          info: listPost[i],
        ));
      } else {
        card.add(ContentCardTemplate(
          info: listPost[i],
        ));
      }
      
    }
    return card;
  }

  Widget desktopContent(
    String topicName, 
    String? topicDescription, 
    List<Map<String, dynamic>> listPost, 
    DocumentSnapshot? nextPost
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        children: [
          Container(
            alignment: Alignment.topLeft,
            padding:
                const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            decoration: BoxDecoration(
                color: ColorConstant.white,
                border:
                    Border.all(color: ColorConstant.whiteBlack40, width: 1),
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Text(
                    topicName,
                    style: const TextStyle(
                        color: ColorConstant.orange70,
                        fontSize: 28,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                Text(
                  topicDescription!,
                  style: const TextStyle(
                      color: ColorConstant.whiteBlack80,
                      fontSize: 18,
                      fontWeight: FontWeight.normal),
                ),
              ],
            ),
          ),
          Column(
            children: generateCardCommunityBoard(listPost, false),
          ),
          StreamBuilder(
            stream: postService.listenToDocumentByKeyValuePair(
              ["topics", "isApproved"], 
              [[topicName], true],
              orderingField: "dateCreate",
              descending: true
            ),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.active) {
                if (snapshot.data!.size != listPost.length) {
                  return InkWell(
                    child: Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.only(top: 16, bottom: 16),
                      decoration: BoxDecoration(
                          color: ColorConstant.white,
                          border: Border.all(
                              color: ColorConstant.whiteBlack40, width: 1),
                          borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(16),
                              bottomRight: Radius.circular(16))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            "ดูเพิ่มเติม",
                            style: TextStyle(
                                color: ColorConstant.orange60, fontSize: 20),
                          ),
                          Icon(
                            Icons.expand_more_rounded,
                            color: ColorConstant.orange60,
                            size: 24,
                          )
                        ],
                      ),
                    ),
                    onTap: () {
                      context.read<CommunityBoardViewModel>().getNextPost(topicName, nextPost);
                    },
                  );
                }
                return Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.only(top: 16, bottom: 16),
                  decoration: BoxDecoration(
                    color: ColorConstant.white,
                    border: Border.all(
                      color: ColorConstant.whiteBlack40, width: 1),
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(16),
                      bottomRight: Radius.circular(16)
                    )
                  )
                );
              }
              return Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.only(top: 16, bottom: 16),
                decoration: BoxDecoration(
                  color: ColorConstant.white,
                  border: Border.all(
                    color: ColorConstant.whiteBlack40, width: 1),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(16),
                    bottomRight: Radius.circular(16)
                  )
                )
              );
            },
          ),
        ],
      ),
    );
  }

  Widget mobileContent(
    String topicName, 
    String? topicDescription, 
    List<Map<String, dynamic>> listPost,
    DocumentSnapshot? nextPost
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(0, -2),
                    color: ColorConstant.black.withOpacity(0.10),
                    blurRadius: 4,
                  )
                ],
                color: ColorConstant.white,
                border: const Border(
                    top: BorderSide(color: ColorConstant.whiteBlack20, width: 1),
                    bottom:
                        BorderSide(color: ColorConstant.whiteBlack20, width: 1))),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Text(
                      topicName,
                      style: const TextStyle(
                          color: ColorConstant.orange70,
                          fontSize: 20,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  Text(
                    topicDescription!,
                    style: const TextStyle(
                        color: ColorConstant.whiteBlack80, fontSize: 12),
                  )
                ]),
          ),
          Column(
            children: generateCardCommunityBoard(listPost, true),
          ),
          StreamBuilder(
            stream: postService.listenToDocumentByKeyValuePair(
              ["topics", "isApproved"], 
              [[topicName], true],
              orderingField: "dateCreate",
              descending: true
            ),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.active) {
                if (snapshot.data!.size != listPost.length) {
                  return InkWell(
                    child: Container(
                      height: 40,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.only(right: 8, left: 8),
                      decoration: const BoxDecoration(
                        color: ColorConstant.white,
                        border: Border(
                            bottom:
                                BorderSide(color: ColorConstant.whiteBlack20, width: 1)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            "ดูเพิ่มเติม",
                            style: TextStyle(color: ColorConstant.orange70, fontSize: 16),
                          ),
                          Icon(
                            Icons.expand_more_rounded,
                            color: ColorConstant.orange70,
                            size: 24,
                          )
                        ],
                      ),
                    ),
                    onTap: () {
                      context.read<CommunityBoardViewModel>().getNextPost(topicName, nextPost);
                    },
                  );
                }
                return Container(
                  height: 40,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.only(right: 8, left: 8),
                  decoration: const BoxDecoration(
                    color: ColorConstant.white,
                    border: Border(
                      bottom:
                          BorderSide(color: ColorConstant.whiteBlack20, width: 1)),
                  ),
                );
              }
              return Container(
                height: 40,
                alignment: Alignment.center,
                padding: const EdgeInsets.only(right: 8, left: 8),
                decoration: const BoxDecoration(
                  color: ColorConstant.white,
                  border: Border(
                      bottom:
                          BorderSide(color: ColorConstant.whiteBlack20, width: 1)),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  List<Widget> generateContent(List<Map<String, dynamic>> detail, bool isMobile) {
    List<Widget> content = [];
    for (int i = 0; i < detail.length; i++) {
      if (isMobile) {
        content.add(mobileContent(detail[i]["topic"], detail[i]["description"], detail[i]["post"], detail[i]["lastDoc"]));
      } else {
        content.add(desktopContent(detail[i]["topic"], detail[i]["description"], detail[i]["post"], detail[i]["lastDoc"]));
      }
    }
    return content;
  }

  List<Map<String, dynamic>> getPostDetail() {
    List<Map<String, dynamic>> post = context.watch<CommunityBoardViewModel>().getPost;
    List<Map<String, dynamic>> allPost = [];
    for (int i = 0; i < post.length; i++) {
      int index = post[i]["post"].getPost.length;
      int allPostIndex = i;
      if (post[i]["topic"] == "General") {
        allPostIndex = 0;
        allPost.insert(0, {
          "topic": post[i]["topic"],
          "description": post[i]["description"],
          "post": <Map<String, dynamic>>[],
          "lastDoc": post[i]["lastDoc"],
        });
      } else {
        allPost.add({
          "topic": post[i]["topic"],
          "description": post[i]["description"],
          "post": <Map<String, dynamic>>[],
          "lastDoc": post[i]["lastDoc"],
        });
      }
      
      for (int j = 0; j < index; j++) {
        String docId = post[i]["post"].getPost[j].getDocId;
        String title = post[i]["post"].getPost[j].getContent.getText;
        String detail = post[i]["post"].getPost[j].getContent.getOptionalString;
        String ownerName = post[i]["post"].getPost[j].getOwnerName;
        String dateCreate = DateFormat("d MMMM.").format(post[i]["post"].getPost[j].getDateCreate).toString();
        int comments = post[i]["post"].getPost[j].getComment;
        List<dynamic> topic = post[i]["post"].getPost[j].getTopic;
        List<Map<String, dynamic>>  postDetail = allPost[allPostIndex]["post"];
        postDetail.add({
          "title": title,
          "detail": detail,
          "topic": topic,
          "ownerName": ownerName.split(" ")[0],
          "dateCreate": dateCreate,
          "comments": comments,
          "docId": docId
        });
        allPost[allPostIndex]["post"] = postDetail;
      }
    }
    return allPost;
  }

  @override
  Widget build(BuildContext context) {
    int tagBarSelected = context.watch<TemplateDesktopViewModel>().selectedTagBar(2);
    Map<String, dynamic> tagBarName = context.watch<TemplateDesktopViewModel>().getHomeTagBarNameSelected(tagBarSelected);
    bool isSafeLoad = context.watch<CommunityBoardViewModel>().getIsSafeLoad;
    context.read<CommunityBoardViewModel>().setIsSafeClick = false;

    if (!isSafeLoad) {
      context.read<CommunityBoardViewModel>().setIsSafeClick = true;
      List<Map<String, dynamic>> allPost = getPostDetail();
      return Padding(
        padding: EdgeInsets.all(widget.isMobile ? 0 : 40),
        child: Builder(
          builder: (context) {
            return Column(
              children: generateContent(allPost, widget.isMobile),
            );
          },
        ),
      );
    }
    context.read<CommunityBoardViewModel>().clearPost();
    return Padding(
      padding: EdgeInsets.all(widget.isMobile ? 0 : 40),
      child: Column(
        children: [
          FutureBuilder(
            future: context.read<CommunityBoardViewModel>().getPostByTopic(
              tagBarSelected == 0 ? "" : tagBarName["name"].toString(),
              isLoadAll: tagBarSelected == 0 ? true : false
            ),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                context.read<CommunityBoardViewModel>().setIsSafeClick = true;
                List<Map<String, dynamic>> allPost = getPostDetail();
                return Builder(
                  builder: (context) {
                    return Column(
                      children: generateContent(allPost, widget.isMobile),
                    );
                  },
                );
              }
              return const CircularProgressIndicator();
            },
          ),
        ],
      ),
    );
  }
}