// ignore_for_file: use_build_context_synchronously, prefer_is_empty

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
  final List<Map<String, dynamic>> q;
  const DescriptionDesktop({super.key, required this.isAdmin, required this.q});

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
  void initState() {
    if (widget.q.isNotEmpty) {
      selectedValue = "Q: ${widget.q[0]["question"]}";
      for (int i = 0; i < widget.q.length; i++) {
        answer.addAll({
          "Q: ${widget.q[i]["question"]}": widget.q[i]["answer"]
        });
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String taskDetail = context.watch<ReplyChannelViewModel>().getTaskData["detail"];
    String category = context.watch<ReplyChannelViewModel>().getTaskData["category"];
    String docId = context.watch<ReplyChannelViewModel>().getTaskData["docId"];

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
        Builder(
          builder: (context) {
            bool isAdmin = context.read<AppViewModel>().app.getUser.getRole == 0;
            if (!isAdmin) {
              return Container();
            }
            return Padding(
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
                          value: selectedValue,
                          onChanged: (value) {
                            setState(() {
                              selectedValue = value!;
                              isInit = false;
                            });
                          },
                          items: widget.q.map((e) {
                            return DropdownMenuItem<String>(
                              value: "Q: ${e["question"]}",
                              child: Text("Q: ${e["question"]}",),
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
                                      await context.read<HelpDeskViewModel>().setTicketResponsibility(docId, userId, false);
                                      await context.read<HelpDeskViewModel>().editTask(
                                        docId, 
                                        true, 
                                        1
                                      );
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
                ),
              ),
            );
          }
        ),
        Builder(
          builder: (context) {
            bool isAdmin = context.read<AppViewModel>().app.getUser.getRole == 0;
            if (!isAdmin) {
              return Container();
            }
            return Padding(
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
            );
          }
        )
      ],
    );
  }
}
