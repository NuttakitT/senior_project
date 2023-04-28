import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senior_project/approval/view/widget/card_approval.dart';
import 'package:senior_project/approval/view/widget/content.dart';
import 'package:senior_project/approval/view_model/approval_view_model.dart';
import 'package:senior_project/assets/color_constant.dart';
import 'package:senior_project/assets/font_style.dart';
import 'package:senior_project/core/template/template_desktop/view_model/template_desktop_view_model.dart';
import 'package:senior_project/core/view_model/text_search.dart';

class TextSearchResult extends StatefulWidget {
  const TextSearchResult({super.key});

  @override
  State<TextSearchResult> createState() => _TextSearchResultState();
}

class _TextSearchResultState extends State<TextSearchResult> {
  @override
  void initState() {
    context.read<TextSearch>().initHitSearcher("post");
    super.initState();
  }

  List<Widget> generateCardApproval(List<Map<String, dynamic>> listPost) {
    context.read<TemplateDesktopViewModel>().setIsSafeClick = false;
    List<Widget> card = [];
    for (int i = 0; i < listPost.length; i++) {
      card.add(CardApproval(
        info: listPost[i],
        checknumcard: i,
      ));
    }
    return card;
  }

  @override
  Widget build(BuildContext context) {
    int tagBarSelected = context.watch<TemplateDesktopViewModel>().selectedTagBar(2);
    Map<String, dynamic> tagBarName = context.read<TemplateDesktopViewModel>().getHomeTagBarNameSelected(tagBarSelected);
    context.read<TextSearch>().getHitsSearcher.query(context.watch<TextSearch>().getSearchText);

    return StreamBuilder(
      stream: context.read<TextSearch>().getHitsSearcher.responses,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          List<dynamic> result = snapshot.data!.hits.toList();
          context.read<ApprovalViewModel>().reconstreuctTextSearch(
            result, 
            tagBarSelected == 0 ? "" : tagBarName["name"]
          );
          int postNumber = context.read<ApprovalViewModel>().getPost.length;
          return Column(
            children: [
              Container(
                padding: const EdgeInsets.fromLTRB(16, 24, 16, 24),
                decoration: const BoxDecoration(
                    color: ColorConstant.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16))),
                child: Row(
                  children: [
                    InkWell(
                      child: const Icon(
                        Icons.refresh_rounded,
                        color: ColorConstant.whiteBlack70,
                        size: 24,
                      ),
                      onTap: () {
                        setState(() {});
                      },
                    ),
                    const Spacer(),
                    Builder(
                      builder: (context) {
                        if (postNumber == 0) {
                          return Container();
                        }
                        return Text(
                          postNumber.toString(),
                          style: const TextStyle(
                              color: ColorConstant.whiteBlack70,
                              fontSize: 16),
                        );
                      }
                    )
                  ],
                ),
              ),
              Builder(
                builder: (context) {
                  List<Map<String, dynamic>> post = context.watch<ApprovalViewModel>().getPost;
                  if (post.isNotEmpty) {
                    return Column(
                      children: generateCardApproval(post));
                  }
                  return Container(
                    width: double.infinity,
                    height: 58,
                    padding: const EdgeInsets.all(16),
                    decoration: const BoxDecoration(
                      color: ColorConstant.white,
                      border: Border(
                          top: BorderSide(color: ColorConstant.whiteBlack30),
                          bottom: BorderSide(color: ColorConstant.whiteBlack30)
                      )
                    ),
                    alignment: Alignment.center,
                    child: const Text(
                      "No result", 
                      style:  TextStyle(
                        fontFamily: AppFontStyle.font,
                        fontWeight: FontWeight.w400,
                        fontSize: 20,
                        color: ColorConstant.whiteBlack60
                      ),),
                  );
                }
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(0, 24, 16, 24),
                decoration: const BoxDecoration(
                    color: ColorConstant.white,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(16),
                        bottomRight: Radius.circular(16))),
                child: Row(
                  children: [
                    const Spacer(),
                    Builder(
                      builder: (context) {
                        if (postNumber == 0) {
                          return Container();
                        }
                        return Text(
                          postNumber.toString(),
                          style: const TextStyle(
                              color: ColorConstant.whiteBlack70,
                              fontSize: 16),
                        );
                      }
                    ),
                  ],
                ),
              )
            ],
          );
        }
        return const CircularProgressIndicator();
      },
    );
  }
}