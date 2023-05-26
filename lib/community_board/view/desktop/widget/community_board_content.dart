import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senior_project/assets/color_constant.dart';
import 'package:senior_project/assets/font_style.dart';
import 'package:senior_project/community_board/view/desktop/widget/create_post.dart';
import 'package:senior_project/community_board/view/widget/post_loader.dart';
import 'package:senior_project/community_board/view/widget/text_search_result.dart';
import 'package:senior_project/community_board/view_model/community_board_view_model.dart';
import 'package:senior_project/core/template/template_desktop/view_model/template_desktop_view_model.dart';
import 'package:senior_project/core/template/widget/search_bar.dart';
import 'package:senior_project/core/view_model/app_view_model.dart';
import 'package:senior_project/core/view_model/text_search.dart';

class CommunityBoardContent extends StatefulWidget {
  const CommunityBoardContent({super.key});

  @override
  State<CommunityBoardContent> createState() =>
      _TemplateCommunityBoardContentState();
}

class _TemplateCommunityBoardContentState extends State<CommunityBoardContent> {
  String selectedValue = "All FAQ";

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> category = context.read<TemplateDesktopViewModel>().getHomeTagBarName;
    List<String> list = [];
    for (int i = 0; i < category.length; i++) {
      list.add(category[i]["name"]);
    }
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 40, right: 40, left: 40),
          child: Row(
            children: [
              const Text(
                "Frequently Ask Questions(CPE)",
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
                                content: CreatePost(isEdit: false, detail: {}, isFromReply: false,),
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
        Padding(
          padding: const EdgeInsets.only(left: 43, top: 40, right: 40),
          child: Row(
            children: [
              const Padding(
                padding: EdgeInsets.only(right: 6),
                child: Icon(Icons.filter_alt_rounded, size: 16, color: ColorConstant.whiteBlack60,),
              ),
              const Padding(
                padding: EdgeInsets.only(right: 20),
                child: Text(
                  "Filter",
                  style: TextStyle(
                    fontWeight: AppFontWeight.regular,
                    fontSize: 20,
                    color: ColorConstant.whiteBlack60
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: ColorConstant.whiteBlack40),
                  color: Colors.white
                ),
                width: 300,
                height: 40,
                alignment: Alignment.center,
                child: DropdownButton<String>(
                  underline: Container(),
                  isExpanded: true,
                  value: selectedValue,
                  items: list.map((e) {
                    return DropdownMenuItem<String>(
                      value: e,
                      child: Text(e)
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedValue = value!;
                    });
                    context.read<CommunityBoardViewModel>().setIsSafeLoad = true;
                    context.read<CommunityBoardViewModel>().setIsShowPostDetail(false, false, {});
                    context
                      .read<TemplateDesktopViewModel>()
                      .changeState(context, list.indexOf(selectedValue), 2);
                  }
                ),
              ),
              Expanded(
                child: Padding(
                  padding:  const EdgeInsets.only(left: 16),
                  child: Container(
                    decoration: BoxDecoration(
                      color: ColorConstant.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: ColorConstant.whiteBlack40),
                    ),
                    width: 280,
                    height: 50,
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: const SearchBar(
                      isHelpDeskPage: false
                    )
                  ),
                ),
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
