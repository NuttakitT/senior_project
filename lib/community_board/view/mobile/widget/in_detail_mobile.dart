import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senior_project/assets/color_constant.dart';
import 'package:senior_project/community_board/view/mobile/widget/comment_field_mobile.dart';
import 'package:senior_project/community_board/view/mobile/widget/comment_template_mobile.dart';
import 'package:senior_project/community_board/view/page/community_board_view.dart';
import 'package:senior_project/community_board/view/widget/commenet_loader.dart';
import 'package:senior_project/community_board/view_model/community_board_view_model.dart';
import 'package:senior_project/core/template/template_mobile/view/template_menu_mobile.dart';
import 'package:senior_project/core/view_model/app_view_model.dart';

class InDetailMobile extends StatefulWidget {
  final Map<String, dynamic> info;
  const InDetailMobile({super.key, required this.info});

  @override
  State<InDetailMobile> createState() => _InDetailMobileState();
}

class _InDetailMobileState extends State<InDetailMobile> {
  List<Widget> getTopic(List<dynamic> topic) {
    List<Widget> list = [];
    for (int i = 0; i < topic.length; i++) {
      list.add(
        Padding(
          padding: const EdgeInsets.only(bottom: 40),
          child: Container(
            width: 100,
            padding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: ColorConstant.white,
                border: Border.all(color: ColorConstant.whiteBlack30),
                borderRadius: BorderRadius.circular(8)),
            child: Text(
              topic[i].toString(),
              style: const TextStyle(
                  color: ColorConstant.whiteBlack70, fontSize: 12),
            ),
          ),
        ),
      );
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    bool isMobile = context.watch<AppViewModel>().getMobileSiteState(MediaQuery.of(context).size.width);
    context.read<CommunityBoardViewModel>().setIsShowPostDetail(true, true, widget.info);
    if (!isMobile) {
      return const CommunityBoardView();
    }
    return TemplateMenuMobile(
      content: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: InkWell(
              onTap: () {
                context.read<CommunityBoardViewModel>().setIsShowPostDetail(true, false, {});
                Navigator.pop(context);
              },
              child: const Padding(
                padding: EdgeInsets.fromLTRB(16, 24, 0, 24),
                child: Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: ColorConstant.whiteBlack90,
                  size: 24,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
            child: Container(
              padding: const EdgeInsets.fromLTRB(8, 16, 8, 16),
              decoration: BoxDecoration(
                  color: ColorConstant.whiteBlack5,
                  border: Border.all(color: ColorConstant.whiteBlack40),
                  borderRadius: BorderRadius.circular(8)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Text(
                      widget.info["title"],
                      style: const TextStyle(
                          color: ColorConstant.orange70,
                          fontSize: 20,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 16),
                          child: Text(
                            widget.info["ownerName"],
                            style: const TextStyle(
                                color: ColorConstant.whiteBlack70, fontSize: 14),
                          ),
                        ),
                        Text(
                          widget.info["dateCreate"],
                          style: const TextStyle(
                              color: ColorConstant.whiteBlack50, fontSize: 12),
                        )
                      ],
                    ),
                  ),
                  Row(
                    children: getTopic(widget.info["topic"]),
                  ),
                  Text(
                    widget.info["detail"],
                    style: const TextStyle(
                        color: ColorConstant.whiteBlack90, fontSize: 14),
                  )
                ],
              ),
            ),
          ),
          CommentLoader(docId: widget.info["docId"], isMobile: true)
        ],
      ),
    );
  }
}
