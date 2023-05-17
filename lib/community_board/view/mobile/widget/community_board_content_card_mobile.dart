import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senior_project/assets/color_constant.dart';
import 'package:senior_project/assets/font_style.dart';
import 'package:senior_project/community_board/view/desktop/widget/create_post.dart';
import 'package:senior_project/core/template/template_mobile/view/template_menu_mobile.dart';
import 'package:senior_project/core/view_model/app_view_model.dart';

class CommunityBoardContentCardMobile extends StatefulWidget {
  final String category;
  final Map<String, dynamic> info;
  const CommunityBoardContentCardMobile({super.key, required this.info, required this.category});

  @override
  State<CommunityBoardContentCardMobile> createState() =>
      _CommunityBoardContentCardMobileState();
}

class _CommunityBoardContentCardMobileState
    extends State<CommunityBoardContentCardMobile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
          color: ColorConstant.whiteBlack5,
          border: Border(
            bottom: BorderSide(width: 1, color: ColorConstant.whiteBlack20),
          )),
      padding: const EdgeInsets.only(top: 8, bottom: 16, left: 16, right: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(right: 16),
                    child: Text(
                      "Q:",
                      style: TextStyle(
                          color: ColorConstant.whiteBlack80, fontSize: 16),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: DefaultTextStyle(
                      maxLines: null,
                      style: const TextStyle(
                          color: ColorConstant.whiteBlack80, fontSize: 16),
                      child: Text(widget.info["question"]),
                    )
                  ),
                ],
              ),
              Builder(
                  builder: (context) {
                    bool isAdmin = context.watch<AppViewModel>().app.getUser.getRole == 0;
                    bool isLogin = context.watch<AppViewModel>().isLogin;
                    if (isLogin && isAdmin) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                              return TemplateMenuMobile(
                                content: CreatePost(
                                  isEdit: true, 
                                  detail: {
                                    "category": widget.category,
                                    "question": widget.info["question"],
                                    "answer": widget.info["answer"],
                                    "id": widget.info["id"]
                                  }, isFromReply: false, 
                                )
                              );
                          }));
                        },
                        child: Row(
                          children: const [
                            Icon(Icons.edit_rounded, color: ColorConstant.whiteBlack60,),
                            Padding(
                              padding: EdgeInsets.only(left: 8.0),
                              child: Text(
                                "แก้ไข",
                                style: TextStyle(
                                  fontWeight: AppFontWeight.regular,
                                  fontSize: 12,
                                  color: ColorConstant.whiteBlack60
                                ),
                              ),
                            )
                          ],
                        ),
                      );
                    }
                    return Container();
                  }
                ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(right: 16),
                child: Text(
                  "A:",
                  style: TextStyle(
                      color: ColorConstant.whiteBlack70, fontSize: 12),
                ),
              ),
              DefaultTextStyle(
                maxLines: null,
                style: const TextStyle(
                  color: ColorConstant.whiteBlack70, 
                  fontSize: 12
                ),
                child: Text(
                  widget.info["answer"],
                ),
              ),
            ],
          ),
          // Row(
          //   children: [
          //     Padding(
          //       padding: const EdgeInsets.only(right: 24),
          //       child: Text(
          //         widget.info["ownerName"],
          //         style: const TextStyle(
          //             color: ColorConstant.whiteBlack70, fontSize: 12),
          //       ),
          //     ),
          //     Text(
          //       widget.info["dateCreate"],
          //       style: const TextStyle(
          //           color: ColorConstant.whiteBlack50, fontSize: 12),
          //     ),
          //     const Spacer(),
          //     Builder(
          //       builder: (context) {
          //         if (widget.info["comments"] == 0) {
          //           return Container();
          //         }
          //         return Row(
          //           children: [
          //             const Padding(
          //               padding: EdgeInsets.only(right: 8),
          //               child: Icon(
          //                 Icons.chat_rounded,
          //                 color: ColorConstant.whiteBlack60,
          //                 size: 14,
          //               ),
          //             ),
          //             Text(
          //               widget.info["comments"].toString(),
          //               style: const TextStyle(
          //                   color: ColorConstant.whiteBlack80, fontSize: 14),
          //             ),
          //           ],
          //         );
          //       }
          //     )
          //   ],
          // )
        ],
      ),
    );
  }
}
