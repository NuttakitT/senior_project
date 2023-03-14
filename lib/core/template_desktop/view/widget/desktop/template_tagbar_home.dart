import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senior_project/assets/font_style.dart';
import 'package:senior_project/core/template_desktop/view/widget/desktop/tagbar.dart';
import 'package:senior_project/assets/color_constant.dart';
import 'package:senior_project/core/template_desktop/view_model/template_desktop_view_model.dart';

//call function from tagbar.dart
class TemplateTagBarHome extends StatefulWidget {
  const TemplateTagBarHome({super.key});
  @override
  State<TemplateTagBarHome> createState() => _TemplateTagBarHomeState();
}

class _TemplateTagBarHomeState extends State<TemplateTagBarHome> {
  @override
  Widget build(BuildContext context) {
    // TODO query menu from db
    bool menu1 = context.watch<TemplateDesktopViewModel>().getHomeState(0);
    bool menu2 = context.watch<TemplateDesktopViewModel>().getHomeState(1);

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
                height: 40,
                width: 280,
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(right: 4, left: 16),
                      child: const Icon(
                        Icons.search_rounded,
                        color: ColorConstant.whiteBlack30,
                      ),
                    ),
                    const Expanded(
                      child: TextField(
                        decoration: InputDecoration.collapsed(
                            hintText: "search...",
                            hintStyle: TextStyle(
                                color: ColorConstant.whiteBlack30,
                                fontSize: 16)),
                      ),
                    ),
                  ],
                ),
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
            Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 8),
              child: TagBar(
                name: "All tag post",
                state: menu1,
                index: 0,
                type: 2,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 8),
              child: TagBar(
                name: "Test tag",
                state: menu2,
                index: 1,
                type: 2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
