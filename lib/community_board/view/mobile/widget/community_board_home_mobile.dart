import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senior_project/assets/color_constant.dart';
import 'package:senior_project/community_board/view/desktop/widget/create_post.dart';
import 'package:senior_project/community_board/view/mobile/widget/create_post_mobile.dart';
import 'package:senior_project/community_board/view/widget/post_loader.dart';
import 'package:senior_project/community_board/view/widget/text_search_result.dart';
import 'package:senior_project/core/template/template_mobile/view/template_menu_mobile.dart';
import 'package:senior_project/core/view_model/app_view_model.dart';
import 'package:senior_project/core/view_model/text_search.dart';

class CommunityBoardHomeMobile extends StatefulWidget {
  const CommunityBoardHomeMobile({super.key});

  @override
  State<CommunityBoardHomeMobile> createState() =>
      _CommunityBoardHomeMobileState();
}

class _CommunityBoardHomeMobileState extends State<CommunityBoardHomeMobile> {

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
                    "Frequently Ask Questions(CPE)",
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
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: SizedBox(
                            height: 38,
                            child: TextField(
                              onChanged: (value) {
                                context.read<TextSearch>().setSearchText(value);
                              },
                              maxLines: 1,
                              maxLength: 512,
                              decoration: const InputDecoration(
                                counterText: "",
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
                                  // return const CreatePostMobile();
                                  // ignore: prefer_const_constructors
                                  return TemplateMenuMobile(content: CreatePost(isEdit: false, detail: const {}, isFromReply: false,));
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
                                    size: 12,
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
        Builder(
          builder: (context) {
            String searchText = context.watch<TextSearch>().getSearchText;
            if (searchText.isEmpty) {
              return const PostLoader(isMobile: true);
            }
            return const TextSearchResult(isMobile: true);
          },
        ),
      ],
    );
  }
}
