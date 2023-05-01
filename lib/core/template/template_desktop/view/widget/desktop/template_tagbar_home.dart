import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senior_project/approval/view/page/template_approval.dart';
import 'package:senior_project/approval/view_model/approval_view_model.dart';
import 'package:senior_project/assets/font_style.dart';
import 'package:senior_project/community_board/view/page/community_board_view.dart';
import 'package:senior_project/community_board/view_model/community_board_view_model.dart';
import 'package:senior_project/core/template/widget/search_bar.dart';
import 'package:senior_project/core/template/template_desktop/view/widget/desktop/tagbar.dart';
import 'package:senior_project/assets/color_constant.dart';
import 'package:senior_project/core/template/template_desktop/view_model/template_desktop_view_model.dart';
import 'package:senior_project/core/view_model/app_view_model.dart';
import 'package:senior_project/core/view_model/text_search.dart';

//call function from tagbar.dart
class TemplateTagBarHome extends StatefulWidget {
  const TemplateTagBarHome({super.key});
  @override
  State<TemplateTagBarHome> createState() => _TemplateTagBarHomeState();
}

class _TemplateTagBarHomeState extends State<TemplateTagBarHome> {
  List<Widget> generateTopic(List<dynamic> name) {
    List<Widget> list = [];
    for (int i = 0; i < name.length; i++) {
      list.add(
        Padding(
          padding: const EdgeInsets.only(top: 8, bottom: 8),
          child: TagBar(
            name: name[i]["name"].toString(),
            index: i,
            type: 2,
          ),
        ),
      );
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: ColorConstant.whiteBlack85),
      height: double.infinity,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  top: 24, right: 24, left: 24, bottom: 40),
              child: Container(
                  decoration: BoxDecoration(
                      color: ColorConstant.white,
                      borderRadius: BorderRadius.circular(16)),
                  height: 50,
                  width: 280,
                  child: const SearchBar(
                    isHelpDeskPage: false,
                  )),
            ),
            Container(
              width: 326,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(right: 8),
                    child: Text(
                      "Topic",
                      style: TextStyle(
                          fontFamily: AppFontStyle.font,
                          color: ColorConstant.white,
                          fontWeight: AppFontWeight.bold,
                          fontSize: 20),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: 1,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            Builder(
              builder: (context) {
                if (context.watch<AppViewModel>().app.getUser.getRole == 0) {
                  if (context.watch<TemplateDesktopViewModel>().getIsApprovedPage) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 24, bottom: 24),
                      child: TextButton(
                          onPressed: () {
                            context.read<TextSearch>().clearSearchText();
                            context.read<TemplateDesktopViewModel>().setIsApprovedPage = false;
                            context.read<TemplateDesktopViewModel>().setIsSafeLoad = true;
                            context.read<ApprovalViewModel>().setIsSafeClick = false;
                            context.read<CommunityBoardViewModel>().clearController();
                            Navigator.pushAndRemoveUntil(
                              context, 
                              MaterialPageRoute(builder: (context) {
                                return const CommunityBoardView();
                              }), 
                              (route) => false
                            );
                          },
                          style: TextButton.styleFrom(
                              fixedSize: const Size(280, 40),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16)),
                              side: const BorderSide(
                                  color: ColorConstant.orange70, width: 1),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8),
                              textStyle: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                              foregroundColor: ColorConstant.orange70,
                              backgroundColor: ColorConstant.white),
                          child: const Text("Back")),
                    );
                  }
                  return Padding(
                    padding: const EdgeInsets.only(left: 24, bottom: 24),
                    child: TextButton(
                        onPressed: () {
                          context.read<TextSearch>().clearSearchText();
                          context.read<TemplateDesktopViewModel>().setIsApprovedPage = true;
                          context.read<TemplateDesktopViewModel>().setIsSafeLoad = true;
                          context.read<CommunityBoardViewModel>().setIsSafeClick = false;
                          context.read<ApprovalViewModel>().setIsSafeClick = true;
                          Navigator.pushAndRemoveUntil(
                            context, 
                            MaterialPageRoute(builder: (context) {
                              return const TemplateApproval();
                            }), 
                            (route) => false
                          );
                        },
                        style: TextButton.styleFrom(
                            fixedSize: const Size(280, 40),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16)),
                            side: const BorderSide(
                                color: ColorConstant.orange70, width: 1),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            textStyle: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                            foregroundColor: ColorConstant.orange70,
                            backgroundColor: ColorConstant.white),
                        child: const Text("Approval")),
                  );
                }
                return Container();
              }
            ),
            Builder(
              builder: (context) {
                if (context.watch<TemplateDesktopViewModel>().getIsSafeLoad) {
                  return FutureBuilder(
                    future: context.read<TemplateDesktopViewModel>().getCategory(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        List<Map<String, dynamic>> category = context
                            .watch<TemplateDesktopViewModel>()
                            .getHomeTagBarName;
                        return Column(children: generateTopic(category));
                      }
                      return Container();
                    },
                  );
                }
                List<Map<String, dynamic>> category = context
                    .watch<TemplateDesktopViewModel>()
                    .getHomeTagBarName;
                return Column(children: generateTopic(category));   
              }
            ),
          ],
        ),
      ),
    );
  }
}
