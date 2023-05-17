// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senior_project/assets/color_constant.dart';
import 'package:senior_project/assets/font_style.dart';
import 'package:senior_project/community_board/view/desktop/widget/create_post.dart';
import 'package:senior_project/core/datasource/firebase_services.dart';
import 'package:senior_project/core/template/template_desktop/view/widget/desktop/confirmation_popup.dart';
import 'package:senior_project/core/view_model/app_view_model.dart';
import 'package:senior_project/help_desk/help_desk_main/view_model/help_desk_view_model.dart';
import 'package:senior_project/help_desk/help_desk_reply/view_model/reply_channel_view_model.dart';

const List<String> priority = <String>['Urgent', 'High', 'Medium', 'Low'];
const List<String> status = <String>['Not start', 'Progress', 'Closed'];

class DescriptionDesktop extends StatefulWidget {
  final bool isAdmin;
  const DescriptionDesktop({super.key, required this.isAdmin});

  @override
  State<DescriptionDesktop> createState() => _DescriptionDesktopState();
}

class _DescriptionDesktopState extends State<DescriptionDesktop> {
  String dropdownValuePriority = priority.first;
  String dropdownValueStatus = status.first;
  String selectedValue = "";
  bool isInit = true;
  Map<String, dynamic> answer = {};
  @override
  Widget build(BuildContext context) {
    String taskDetail = context.watch<ReplyChannelViewModel>().getTaskData["detail"];
    String category = context.watch<ReplyChannelViewModel>().getTaskData["category"];

    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: ColorConstant.whiteBlack5,
              boxShadow: [
                BoxShadow(
                  offset: const Offset(5, 5),
                  color: ColorConstant.black.withOpacity(0.05),
                  blurRadius: 10,
                ),
              ]),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                alignment: Alignment.centerLeft,
                child: const Text(
                  "Description",
                  style: TextStyle(
                      color: ColorConstant.whiteBlack90,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                child: Text(
                  taskDetail,
                  style: const TextStyle(
                    color: ColorConstant.whiteBlack70, 
                    fontSize: 16,
                    fontWeight: FontWeight.w400
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 16),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: ColorConstant.whiteBlack5,
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(5, 5),
                    color: ColorConstant.black.withOpacity(0.05),
                    blurRadius: 10,
                  ),
                ]),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    "Category",
                    style: TextStyle(
                        color: ColorConstant.whiteBlack90,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                  child: Text(
                    category,
                    style: const TextStyle(
                      color: ColorConstant.whiteBlack70, 
                      fontSize: 16,
                      fontWeight: FontWeight.w400
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 16),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: ColorConstant.whiteBlack5,
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(5, 5),
                    color: ColorConstant.black.withOpacity(0.05),
                    blurRadius: 10,
                  ),
                ]),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    "FAQ",
                    style: TextStyle(
                        color: ColorConstant.whiteBlack90,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                FutureBuilder(
                  future: FirebaseServices("faq").getDocumnetByKeyValuePair(
                    ["category"], 
                    [category]
                  ),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState != ConnectionState.done) {
                      return Container();
                    }
                    if (isInit) {
                      selectedValue = snapshot.data!.docs.first.get("question");
                    }
                    answer = {};
                    for (int i = 0; i < snapshot.data!.docs.length; i++) {
                      answer.addAll({
                        snapshot.data!.docs[i].get("question"): snapshot.data!.docs[i].get("answer") 
                      });
                    }
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            alignment: Alignment.centerLeft,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(color: ColorConstant.whiteBlack40)
                            ),
                            child: DropdownButton<String>(
                              underline: Container(),
                              isExpanded:  true,
                              value: "Q: $selectedValue",
                              onChanged: (value) {
                                setState(() {
                                  selectedValue = value!;
                                  isInit = false;
                                });
                              },
                              items: snapshot.data!.docs.map((e) {
                                return DropdownMenuItem<String>(
                                  value: "Q: ${e.get("question")}",
                                  child: Text("Q: ${e.get("question")}",),
                                );
                              }).toList(),
                            )
                          ),
                        ),
                        StreamBuilder(
                          stream: FirebaseServices("ticket").listenToDocument(
                            context.read<ReplyChannelViewModel>().getTaskData["docId"],
                          ),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState != ConnectionState.active) {
                              return Container();
                            } else if (snapshot.data!.get("status") == 2) {
                              return Container();
                            }
                            return Container(
                              alignment: Alignment.centerRight,
                              child: TextButton(
                                onPressed: () {
                                  showDialog(
                                    context: context, 
                                    builder: (context) {
                                      return ConfirmationPopup(
                                        detail: "", 
                                        onCancel: () {
                                          Navigator.pop(context);
                                        }, 
                                        onConfirm: () async {
                                          String userId = context.read<AppViewModel>().app.getUser.getId;
                                          await context.read<ReplyChannelViewModel>().createMessage(
                                            context,
                                            context.read<ReplyChannelViewModel>().getTaskData["docId"], 
                                            {
                                              "ownerId": userId,
                                              "message": "FAQ\nQ: $selectedValue\nA: ${answer[selectedValue]}",
                                              "time": DateTime.now(),
                                              "seen": false,
                                              "imageUrl": null
                                            }
                                          );
                                          Navigator.pop(context);
                                        }, 
                                        title: "Are you sure to send FAQ?", 
                                        widget: Text(
                                          "Q: $selectedValue\nA: ${answer[selectedValue]}",
                                          style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: AppFontWeight.bold,
                                            color: ColorConstant.whiteBlack60
                                          ),
                                        )
                                      );
                                    }
                                  );
                                },
                                style: ButtonStyle(
                                  fixedSize: MaterialStateProperty.all(
                                    const Size(120, 32)
                                  ),
                                  backgroundColor: MaterialStateProperty.all(
                                    ColorConstant.orange50
                                  )
                                ),
                                child: const Text(
                                  "Send FAQ",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                    fontWeight: AppFontWeight.bold
                                  ),
                                ),
                              ),
                            );
                          }
                        ),
                      ],
                    );
                  }
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 16),
          child: TextButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: ((context) {
                  return AlertDialog(
                    content: CreatePost(isEdit: false, detail: {
                      "category": category,
                      "question": taskDetail,
                      "answer": "",
                    }, isFromReply: true,),
                  );
                }));
            },
            style: ButtonStyle(
              fixedSize: MaterialStateProperty.all(
                const Size(332, 56)
              ),
              backgroundColor: MaterialStateProperty.all(
                ColorConstant.orange50
              ),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)
                )
              )
            ),
            child: const Text(
              "Create FAQ",
              style: TextStyle(
                fontSize: 18,
                fontWeight: AppFontWeight.bold,
                color: Colors.white
              ),
            ),
          ),
        )
      ],
    );
  }
}
