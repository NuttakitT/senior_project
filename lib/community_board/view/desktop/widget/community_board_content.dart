import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senior_project/assets/color_constant.dart';
import 'package:senior_project/community_board/view/desktop/widget/create_post.dart';
import 'package:senior_project/community_board/view/widget/post_loader.dart';
import 'package:senior_project/community_board/view/widget/text_search_result.dart';
import 'package:senior_project/core/view_model/app_view_model.dart';
import 'package:senior_project/core/view_model/text_search.dart';

class CommunityBoardContent extends StatefulWidget {
  const CommunityBoardContent({super.key});

  @override
  State<CommunityBoardContent> createState() =>
      _TemplateCommunityBoardContentState();
}

class _TemplateCommunityBoardContentState extends State<CommunityBoardContent> {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 40, right: 40, left: 40),
          child: Row(
            children: [
              const Text(
                "Frequently Ask Questions",
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
                  bool isAdmin = context.watch<AppViewModel>().app.getUser.getRole == 0;
                  if (isLogin && isAdmin) {
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
                              "Add FAQ",
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
                  return Container();
                }
              )
            ],
          ),
        ),
        Builder(
          builder: (context) {
            String searchText = context.watch<TextSearch>().getSearchText;
            if (searchText.isEmpty) {
              return const PostLoader(isMobile: false);
            }
            return const TextSearchResult(isMobile: false);
          },
        ),
      ],
    );
  }
}
