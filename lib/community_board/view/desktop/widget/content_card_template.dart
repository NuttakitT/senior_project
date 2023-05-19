import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senior_project/assets/color_constant.dart';
import 'package:senior_project/assets/font_style.dart';
import 'package:senior_project/community_board/view/desktop/widget/create_post.dart';
import 'package:senior_project/core/view_model/app_view_model.dart';

class ContentCardTemplate extends StatefulWidget {
  final Map<String, dynamic> info;
  final String category;
  const ContentCardTemplate({super.key, required this.info, required this.category});

  @override
  State<ContentCardTemplate> createState() => _ContentCardTemplateState();
}

class _ContentCardTemplateState extends State<ContentCardTemplate> {
  TextEditingController asnwerController = TextEditingController();

  List<Widget> getTopic(List<dynamic> topic) {
    List<Widget> topicWidget = [
      const Padding(
        padding: EdgeInsets.only(right: 24),
        child: Text(
          "Topic : ",
          style: TextStyle(
              color: ColorConstant.whiteBlack50, fontSize: 20),
        ),
      ),
    ];
    for (int i = 0; i < topic.length; i++) {
      topicWidget.add(
        Padding(
          padding: const EdgeInsets.only(right: 24),
          child: Text(
            topic[i].toString(),
            style: const TextStyle(
                color: ColorConstant.whiteBlack70, fontSize: 18),
          ),
        ),
      );
    }
    return topicWidget;
  }

  @override
  Widget build(BuildContext context) {
    asnwerController.text = widget.info["answer"];
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
          color: ColorConstant.whiteBlack5,
          border: Border(
              left: BorderSide(width: 1, color: ColorConstant.whiteBlack40),
              bottom: BorderSide(width: 1, color: ColorConstant.whiteBlack40),
              right:
                  BorderSide(width: 1, color: ColorConstant.whiteBlack40))),
      padding: const EdgeInsets.only(top: 8, bottom: 16, left: 16, right: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Row(
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
                            color: ColorConstant.whiteBlack80, fontSize: 24),
                      ),
                    ),
                    SizedBox(
                      width: 880,
                      child: RichText(
                        maxLines: null,
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: widget.info["question"],
                              style: const TextStyle(
                                color: ColorConstant.whiteBlack80, 
                                fontSize: 24
                              ),
                            )
                          ]
                        ),
                      ),
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
                          showDialog(
                            context: context, 
                            builder: (context) {
                              return AlertDialog(
                                content: CreatePost(
                                  isEdit: true, 
                                  detail: {
                                    "category": widget.category,
                                    "question": widget.info["question"],
                                    "answer": widget.info["answer"],
                                    "id": widget.info["id"]
                                  }, isFromReply: false, 
                                ),
                              );
                            }
                          );
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
                                  fontSize: 16,
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
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(right: 16),
                  child: Text(
                    "A:",
                    style: TextStyle(
                        color: ColorConstant.whiteBlack80, fontSize: 20),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: SizedBox(
                    width: 940,
                    child: TextField(
                      readOnly: true,
                      maxLines: null,
                      controller: asnwerController,
                      decoration: const InputDecoration.collapsed(
                        hintText: ""
                      ),
                      style: const TextStyle(
                        color: ColorConstant.whiteBlack50, 
                        fontSize: 20
                      ),
                    )
                  ),
                ),
              ],
            ),
          ),
          // Row(
          //   children: [
          //     Padding(
          //       padding: const EdgeInsets.only(right: 40),
          //       child: Text(
          //         widget.info["ownerName"],
          //         style: const TextStyle(
          //             color: ColorConstant.whiteBlack70, fontSize: 18),
          //       ),
          //     ),
          //     Text(
          //       widget.info["dateCreate"],
          //       style: const TextStyle(
          //           color: ColorConstant.whiteBlack50, fontSize: 16),
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
          //               ),
          //             ),
          //             Text(
          //               widget.info["comments"].toString(),
          //               style: const TextStyle(
          //                   color: ColorConstant.whiteBlack80, fontSize: 18),
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
