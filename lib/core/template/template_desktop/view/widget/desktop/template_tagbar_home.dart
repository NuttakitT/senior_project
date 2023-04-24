import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senior_project/assets/font_style.dart';
import 'package:senior_project/core/template/widget/search_bar.dart';
import 'package:senior_project/core/template/template_desktop/view/widget/desktop/tagbar.dart';
import 'package:senior_project/assets/color_constant.dart';
import 'package:senior_project/core/template/template_desktop/view_model/template_desktop_view_model.dart';

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
                child: const SearchBar(isHelpDeskPage: false,)
              ),
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
            FutureBuilder(
              future: context.read<TemplateDesktopViewModel>().getCategory(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  List<Map<String, dynamic>> category = context.watch<TemplateDesktopViewModel>().getHomeTagBarName;
                  return Column(
                    children: generateTopic(category)
                  );
                }
                return Container();
              },
            ),
          ],
        ),
      ),
    );
  }
}
