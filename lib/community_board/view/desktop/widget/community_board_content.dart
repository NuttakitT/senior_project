import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senior_project/assets/color_constant.dart';
import 'package:senior_project/community_board/view/desktop/widget/content_card_template.dart';
import 'package:senior_project/community_board/view/desktop/widget/create_post.dart';
import 'package:senior_project/community_board/view_model/community_board_view_model.dart';
import 'package:senior_project/core/view_model/app_view_model.dart';

class CommunityBoardContent extends StatefulWidget {
  const CommunityBoardContent({super.key});

  @override
  State<CommunityBoardContent> createState() =>
      _TemplateCommunityBoardContentState();
}

class _TemplateCommunityBoardContentState extends State<CommunityBoardContent> {
  List<Widget> generateCardCommunityBoard(List<Map<String, dynamic>> listPost) {
    List<Widget> card = [];
    for (int i = 0; i < listPost.length; i++) {
      card.add(ContentCardTemplate(
        info: listPost[i],
      ));
    }
    return card;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 40, right: 40, left: 40),
          child: Row(
            children: [
              const Text(
                "Community Board",
                style: TextStyle(
                    color: ColorConstant.whiteBlack90,
                    fontSize: 32,
                    fontWeight: FontWeight.w500),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Container(
                    decoration:
                        const BoxDecoration(color: ColorConstant.whiteBlack30),
                    height: 1,
                  ),
                ),
              ),
              Builder(
                builder: (context) {
                  bool isLogin = context.watch<AppViewModel>().isLogin;
                  if (!isLogin) {
                    return Container();
                  }
                  return InkWell(
                    child: Container(
                      padding:
                          const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                          color: ColorConstant.orange50,
                          borderRadius: BorderRadius.circular(8)),
                      child: Row(
                        children: const [
                          Padding(
                            padding: EdgeInsets.only(right: 4),
                            child: Icon(
                              Icons.add,
                              color: ColorConstant.white,
                            ),
                          ),
                          Text(
                            "Create Post",
                            style: TextStyle(
                                color: ColorConstant.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: ((context) {
                            return const AlertDialog(
                              content: CreatePost(),
                            );
                          }));
                    },
                  );
                }
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(40),
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
                  children: const [
                    //TODO Topic from back-end
                    Padding(
                      padding: EdgeInsets.only(bottom: 4),
                      child: Text(
                        "การลงทะเบียน",
                        style: TextStyle(
                            color: ColorConstant.orange70,
                            fontSize: 28,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    Text(
                      "คำถามเกี่ยวกับการลงทะเบียนเรียน",
                      style: TextStyle(
                          color: ColorConstant.whiteBlack80,
                          fontSize: 18,
                          fontWeight: FontWeight.normal),
                    ),
                  ],
                ),
              ),
              FutureBuilder(
                future: context.read<CommunityBoardViewModel>().fetchAllPosts(),
                builder: ((context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    List<Map<String, dynamic>> listPost =
                        context.read<CommunityBoardViewModel>().getPost();
                    return Column(
                      children: generateCardCommunityBoard(listPost),
                    );
                  }
                  return const Text("Loading...");
                }),
              ),
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.only(top: 16, bottom: 16),
                decoration: BoxDecoration(
                    color: ColorConstant.white,
                    border:
                        Border.all(color: ColorConstant.whiteBlack40, width: 1),
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
            ],
          ),
        ),
      ],
    );
  }
}
