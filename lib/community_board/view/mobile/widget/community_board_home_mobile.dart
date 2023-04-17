import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senior_project/assets/color_constant.dart';
import 'package:senior_project/community_board/view/mobile/widget/community_board_content_card_mobile.dart';
import 'package:senior_project/community_board/view/mobile/widget/create_post_mobile.dart';
import 'package:senior_project/community_board/view_model/community_board_view_model.dart';
import 'package:senior_project/core/view_model/app_view_model.dart';

class CommunityBoardHomeMobile extends StatefulWidget {
  const CommunityBoardHomeMobile({super.key});

  @override
  State<CommunityBoardHomeMobile> createState() =>
      _CommunityBoardHomeMobileState();
}

class _CommunityBoardHomeMobileState extends State<CommunityBoardHomeMobile> {
  List<Widget> generateCardCommunityBoard(List<Map<String, dynamic>> listPost) {
    List<Widget> card = [];
    for (int i = 0; i < listPost.length; i++) {
      card.add(CommunityBoardContentCardMobile(
        info: listPost[i],
      ));
    }
    return card;
  }

  Widget getContent(String topicName, String? topicDescription, List<Map<String, dynamic>> listPost) {
    return Column(
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
          children: generateCardCommunityBoard(listPost),
        ),
        InkWell(
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
            //TODO view more post
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 16, bottom: 16),
          child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: ColorConstant.white, boxShadow: [
              BoxShadow(
                offset: const Offset(-1, 2),
                color: ColorConstant.black.withOpacity(0.10),
                blurRadius: 4,
              )
            ]),
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.only(bottom: 16),
                  child: Text(
                    "Community Board",
                    style: TextStyle(
                        color: ColorConstant.whiteBlack90,
                        fontSize: 28,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 430),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(right: 8),
                          child: SizedBox(
                            height: 38,
                            child: TextField(
                              maxLines: 1,
                              decoration: InputDecoration(
                                fillColor: ColorConstant.whiteBlack40,
                                hintText: "Search",
                                hintStyle: TextStyle(
                                    color: ColorConstant.whiteBlack60,
                                    fontSize: 14),
                                border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8))),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Builder(
                        builder: (context) {
                          bool isLogin = context.watch<AppViewModel>().isLogin;
                          if (!isLogin) {
                            return Container();
                          }
                          return TextButton(
                            onPressed: () {
                              Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                                  return const CreatePostMobile();
                              }));
                            },
                            style: TextButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8)),
                                side: const BorderSide(
                                    color: ColorConstant.orange50, width: 1),
                                fixedSize: const Size(95, 40),
                                foregroundColor: ColorConstant.orange50,
                                padding: const EdgeInsets.fromLTRB(6, 8, 8, 8),
                                backgroundColor: ColorConstant.white,
                                textStyle: const TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.w500)),
                            child: Row(
                              children: const [
                                Padding(
                                  padding: EdgeInsets.only(right: 4.0),
                                  child: Icon(
                                    Icons.add_photo_alternate_rounded,
                                    color: ColorConstant.orange50,
                                    size: 14,
                                  ),
                                ),
                                Text("Create Post"),
                              ],
                            ),
                          );
                        }
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        FutureBuilder(
          future: context.read<CommunityBoardViewModel>().getPostByTopic("General"),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              List<Map<String, dynamic>> post = context.read<CommunityBoardViewModel>().getPost;
              List<Map<String, dynamic>> postDetail = [];
              for (int i = 0; i < post.length; i++) {
                int index = post[i]["post"].getPost.length;
                for (int j = 0; j < index; j++) {
                  String title = post[i]["post"].getPost[j].getContent.getText;
                  String detail = post[i]["post"].getPost[j].getContent.getOptionalString;
                  List<dynamic> topic = post[i]["post"].getPost[j].getTopic;
                  postDetail.add({
                    "title": title,
                    "detail": detail,
                    "topic": topic
                  });
                }
              }
              return getContent("การลงทะเบียน", "คำถามเกี่ยวกับการลงทะเบียนเรียน", postDetail);
            }
            return const Text("Loading...");
          },
        ),
      ],
    );
  }
}
