// ignore_for_file: depend_on_referenced_packages

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senior_project/assets/color_constant.dart';
import 'package:senior_project/assets/font_style.dart';
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
  // final postService = FirebaseServices("post");
  final faqService = FirebaseServices("faq");

  List<Widget> generateCardCommunityBoard(String category, List<Map<String, dynamic>> listPost, bool isMobile) {
    List<Widget> card = [];
    for (int i = 0; i < listPost.length; i++) {
      if (isMobile) {
        card.add(CommunityBoardContentCardMobile(
          category: category,
          info: listPost[i],
        ));
      } else {
        card.add(ContentCardTemplate(
          category: category,
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
            children: generateCardCommunityBoard(topicName, listPost, false),
          ),
          StreamBuilder(
            stream: faqService.listenToDocumentByKeyValuePair(
              ["category"], 
              [topicName],
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
                    onTap: () async {
                      await context.read<CommunityBoardViewModel>().getNextFaq(topicName, nextPost);
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
            children: generateCardCommunityBoard(topicName, listPost, true),
          ),
          StreamBuilder(
            stream: faqService.listenToDocumentByKeyValuePair(
              ["category"], 
              [topicName],
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
                      context.read<CommunityBoardViewModel>().getNextFaq(topicName, nextPost);
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
        content.add(mobileContent(detail[i]["category"], detail[i]["description"], detail[i]["faq"], detail[i]["lastDoc"]));
      } else {
        content.add(desktopContent(detail[i]["category"], detail[i]["description"], detail[i]["faq"], detail[i]["lastDoc"]));
      }
    }
    return content;
  }

  @override
  Widget build(BuildContext context) {
    int tagBarSelected = context.watch<TemplateDesktopViewModel>().selectedTagBar(2);
    Map<String, dynamic> tagBarName = context.watch<TemplateDesktopViewModel>().getHomeTagBarNameSelected(tagBarSelected);
    bool isSafeLoad = context.watch<CommunityBoardViewModel>().getIsSafeLoad;
    context.read<CommunityBoardViewModel>().setIsSafeClick = false;

    if (!isSafeLoad) {
      List<Map<String, dynamic>> allFaq = context.watch<CommunityBoardViewModel>().getFaq;
      if (allFaq.isEmpty) {
        return const Text(
          "No FAQ",
          style: TextStyle(
            fontFamily: AppFontStyle.font,
            fontWeight: AppFontWeight.medium,
            fontSize: 20,
            color: ColorConstant.whiteBlack80
          ),
        );
      }
      return Padding(
        padding: EdgeInsets.all(widget.isMobile ? 0 : 40),
        child: Builder(
          builder: (context) {
            context.read<CommunityBoardViewModel>().setIsSafeClick = true;
            return Column(
              children: generateContent(allFaq, widget.isMobile),
            );
          },
        ),
      );
    }
    return Padding(
      padding: EdgeInsets.all(widget.isMobile ? 0 : 40),
      child: Column(
        children: [
          FutureBuilder(
            future: context.read<CommunityBoardViewModel>().fetchFaq(
              tagBarSelected == 0 ? "" : tagBarName["name"]
            ),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                context.read<CommunityBoardViewModel>().setIsSafeClick = true;
                List<Map<String, dynamic>> allFaq = context.watch<CommunityBoardViewModel>().getFaq;
                if (allFaq.isEmpty) {
                  return const Text(
                    "No FAQ",
                    style: TextStyle(
                      fontFamily: AppFontStyle.font,
                      fontWeight: AppFontWeight.medium,
                      fontSize: 20,
                      color: ColorConstant.whiteBlack80
                    ),
                  );
                }
                return Builder(
                  builder: (context) {
                    return Column(
                      children: generateContent(allFaq, widget.isMobile),
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