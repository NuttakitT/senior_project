// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:senior_project/assets/color_constant.dart';
import 'package:senior_project/community_board/view/desktop/widget/content_card_template.dart';
import 'package:senior_project/community_board/view/mobile/widget/community_board_content_card_mobile.dart';
import 'package:senior_project/community_board/view_model/community_board_view_model.dart';
import 'package:senior_project/core/template/template_desktop/view_model/template_desktop_view_model.dart';
import 'package:senior_project/core/view_model/text_search.dart';

class TextSearchResult extends StatefulWidget {
  final bool isMobile;
  const TextSearchResult({super.key, required this.isMobile});

  @override
  State<TextSearchResult> createState() => _TextSearchResultState();
}

class _TextSearchResultState extends State<TextSearchResult> {
  List<Widget> generateCardCommunityBoard(String category, bool isMobile, List<Map<String, dynamic>> listPost) {
    List<Widget> card = [];
    for (int i = 0; i < listPost.length; i++) {
      if (isMobile) {
        card.add(CommunityBoardContentCardMobile(
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

  List<Map<String, dynamic>> generatePostDetail() {
    List<Map<String, dynamic>> post = context.watch<CommunityBoardViewModel>().getPost;
    List<Map<String, dynamic>> allPost = [];
    for (int i = 0; i < post[0]["post"].getPost.length; i++) {
      String docId = post[0]["post"].getPost[i].getDocId;
      String title = post[0]["post"].getPost[i].getContent.getText;
      String detail = post[0]["post"].getPost[i].getContent.getOptionalString;
      String ownerName = post[0]["post"].getPost[i].getOwnerName;
      String dateCreate = DateFormat("d MMMM.").format(post[0]["post"].getPost[i].getDateCreate).toString();
      int comments = post[0]["post"].getPost[i].getComment;
      List<dynamic> topic = post[0]["post"].getPost[i].getTopic;
      allPost.add({
        "title": title,
        "detail": detail,
        "topic": topic,
        "ownerName": ownerName.split(" ")[0],
        "dateCreate": dateCreate,
        "comments": comments,
        "docId": docId
      });
    }
    return allPost;
  }

  @override
  void initState() {
    context.read<TextSearch>().initHitSearcher("post");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String topicName = "Result";
    int tagBarSelected = context.watch<TemplateDesktopViewModel>().selectedTagBar(2);
    Map<String, dynamic> tagBarName = context.watch<TemplateDesktopViewModel>().getHomeTagBarNameSelected(tagBarSelected);
    String topicDescription = "ผลการค้นหา ${context.watch<TextSearch>().getSearchText} ${tagBarSelected != 0 ? "จากโพสต์ในหวมดหมู่ ${tagBarName["name"]}" : "จากโพสต์ทั้งหมด"}";

    context.read<TextSearch>().getHitsSearcher.query(context.watch<TextSearch>().getSearchText);
    return StreamBuilder(
      stream: context.watch<TextSearch>().getHitsSearcher.responses,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          List<dynamic> result = snapshot.data!.hits.toList();
          context.read<CommunityBoardViewModel>().reconstructSearchResult(
            result, 
            tagBarSelected != 0 ? tagBarName["name"] : ""
          );
          List<Map<String, dynamic>> allPost = generatePostDetail();
          if (widget.isMobile) {
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
                            topicDescription,
                            style: const TextStyle(
                                color: ColorConstant.whiteBlack80, fontSize: 12),
                          )
                        ]),
                  ),
                  Builder(
                    builder: (context) {
                      if (result.isEmpty) {
                        return Container(
                          width: double.infinity,
                          alignment: Alignment.center,
                          decoration: const BoxDecoration(
                            color: ColorConstant.whiteBlack5,
                            border: Border(
                              bottom: BorderSide(
                                width: 1, 
                                color: ColorConstant.whiteBlack20
                              ),
                            )
                          ),
                          padding: const EdgeInsets.only(top: 8, bottom: 16, left: 16, right: 16),
                          child: const Text(
                            "No result", 
                            style: TextStyle(
                              color: ColorConstant.whiteBlack80, 
                              fontSize: 16
                            ),
                          ),
                        );
                      }
                      return Column(
                        children: generateCardCommunityBoard(topicName, true, allPost),
                      );
                    }
                  ),
                  Container(
                    height: 40,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.only(right: 8, left: 8),
                    decoration: const BoxDecoration(
                      color: ColorConstant.white,
                      border: Border(
                          bottom:
                              BorderSide(color: ColorConstant.whiteBlack20, width: 1)),
                    ),
                  )
                ],
              ),
            );
          }
          return Padding(
            padding: const EdgeInsets.all(40),
            child: Padding(
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
                          topicDescription,
                          style: const TextStyle(
                              color: ColorConstant.whiteBlack80,
                              fontSize: 18,
                              fontWeight: FontWeight.normal),
                        ),
                      ],
                    ),
                  ),
                  Builder(
                    builder: (context) {
                      if (result.isEmpty) {
                        return Container(
                          alignment: Alignment.center,
                          width: double.infinity,
                          decoration: const BoxDecoration(
                            color: ColorConstant.whiteBlack5,
                            border: Border(
                                left: BorderSide(width: 1, color: ColorConstant.whiteBlack40),
                                bottom: BorderSide(width: 1, color: ColorConstant.whiteBlack40),
                                right: BorderSide(width: 1, color: ColorConstant.whiteBlack40))),
                            padding: const EdgeInsets.only(top: 8, bottom: 16, left: 16, right: 16),
                          child: const Text(
                            "No result", 
                            style: TextStyle(
                              color: ColorConstant.whiteBlack80, 
                              fontSize: 24
                            ),
                          ),
                        );
                      }
                      return Column(
                        children: generateCardCommunityBoard(topicName, false, allPost),
                      );
                    }
                  ),
                  Container(
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
                  )
                ],
              ),
            ),
          );
        }
        return const CircularProgressIndicator();
      },
    );
  }
}