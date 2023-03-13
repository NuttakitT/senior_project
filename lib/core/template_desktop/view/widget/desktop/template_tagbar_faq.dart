import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senior_project/assets/font_style.dart';
import 'package:senior_project/core/template_desktop/view/widget/desktop/tagbar.dart';
import 'package:senior_project/assets/color_constant.dart';
import 'package:senior_project/core/template_desktop/view_model/template_desktop_view_model.dart';

//call function from tabtag.dart
class TemplateTagBarFaq extends StatefulWidget {
  const TemplateTagBarFaq({super.key});
  @override
  State<TemplateTagBarFaq> createState() => _TemplateTagBarFaqState();
}

class _TemplateTagBarFaqState extends State<TemplateTagBarFaq> {
  @override
  Widget build(BuildContext context) {
    // TODO query menu from db
    bool menu1 = context.watch<TemplateDesktopViewModel>().getFaqState(0);
    bool menu2 = context.watch<TemplateDesktopViewModel>().getFaqState(1);

    return Container(
      decoration: const BoxDecoration(color: ColorConstant.blue0),
      height: double.infinity,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  top: 16, right: 24, left: 24, bottom: 40),
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
              child: Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(right: 8),
                    child: Text(
                      "Category",
                      style: AppFontStyle.wb80B20,
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: 1,
                      color: ColorConstant.whiteBlack20,
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 8),
              child: TagBar(
                name: "All category",
                state: menu1,
                index: 0,
                type: 3,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 8),
              child: TagBar(
                name: "Test tag",
                state: menu2,
                index: 1,
                type: 3,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
