import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senior_project/approval/view/widget/card_approval.dart';
import 'package:senior_project/approval/view_model/approval_view_model.dart';
import 'package:senior_project/assets/color_constant.dart';
import 'package:senior_project/assets/font_style.dart';
import 'package:senior_project/core/template/template_desktop/view_model/template_desktop_view_model.dart';

class Content extends StatefulWidget {
  final bool isTextSearch;
  const Content({super.key, required this.isTextSearch});

  @override
  State<Content> createState() => _ContentState();
}

class _ContentState extends State<Content> {
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
    List<Map<String, dynamic>> post = context.watch<ApprovalViewModel>().getPost;
    return Builder(
      builder: (context) {
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
          child: Text(
            widget.isTextSearch ? "No result" : "No post in this category", 
            style:  const TextStyle(
              fontFamily: AppFontStyle.font,
              fontWeight: FontWeight.w400,
              fontSize: 20,
              color: ColorConstant.whiteBlack60
            ),),
        );
      }
    );
  }
}