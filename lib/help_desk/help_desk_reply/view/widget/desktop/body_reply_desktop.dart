import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senior_project/assets/color_constant.dart';
import 'package:senior_project/assets/font_style.dart';
import 'package:senior_project/core/datasource/firebase_services.dart';
import 'package:senior_project/core/view_model/app_view_model.dart';
import 'package:senior_project/help_desk/help_desk_main/view/widget/priority_icon.dart';
import 'package:senior_project/help_desk/help_desk_main/view/widget/status_color.dart';
import 'package:senior_project/help_desk/help_desk_main/view_model/help_desk_view_model.dart';
import 'package:senior_project/help_desk/help_desk_reply/view/widget/desktop/chat_input_desktop.dart';
import 'package:senior_project/help_desk/help_desk_reply/view/widget/desktop/description_desktop.dart';
import 'package:senior_project/help_desk/help_desk_reply/view/widget/message.dart';
import 'package:senior_project/help_desk/help_desk_reply/view_model/reply_channel_view_model.dart';

Stream? query(String docId) {
  return FirebaseServices("task").listenToSubDocument(docId, "replyChannel");
}

class BodyReplyDesktop extends StatefulWidget {
  const BodyReplyDesktop({super.key});

  @override
  State<BodyReplyDesktop> createState() => _BodyReplyDesktopState();
}

class _BodyReplyDesktopState extends State<BodyReplyDesktop> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    // int? role = context.watch<AppViewModel>().app.getUser.getRole; 
    // String taskTitle = context.watch<ReplyChannelViewModel>().getTaskData["title"];
    // String docId = context.watch<ReplyChannelViewModel>().getTaskData["docId"];
    // String userId = context.watch<AppViewModel>().app.getUser.getId;
    // context.read<ReplyChannelViewModel>().clearModel();
    int role = 0;
    int status = 1;
    int priority = 2;
    String taskTitle = "Test";
    String adminName = "NaYao";
    String dateCreated = "3 Mar - 17:15PM";
    List<Map<String, dynamic>> data = [
      {
        "text": "asdasd as ad asd as ",
        "isSender": true
      },
      {
        "text": "asdasd as ad asd asasd as ",
        "isSender": true
      },
      {
        "text": "asdasdd as ",
        "isSender": false
      },
      {
        "text": "asdasd as ad asd as dfgdfgdfgd",
        "isSender": true
      },
      {
        "text": "aasdasdas",
        "isSender": false
      },
    ];

    return Container(
      padding: const EdgeInsets.only(right: 20),
      decoration: const BoxDecoration(
        color: ColorConstant.whiteBlack10,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(16),
          bottomRight: Radius.circular(16),
        )
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 24),
                  child: Text(
                    taskTitle,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w500,
                      color: ColorConstant.whiteBlack90
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 4),
                  child: Container(
                    width: 90,
                    height: 28,
                    decoration: BoxDecoration(
                      border: Border.all(color: StatusColor.statusColor(status)![2]),
                      color: StatusColor.statusColor(status)![0],
                      borderRadius: BorderRadius.circular(6)
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      context.watch<HelpDeskViewModel>().convertToString(true, status),
                      style: TextStyle(
                        fontFamily: AppFontStyle.font,
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        color: StatusColor.statusColor(status)![1]
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 86,
                  height: 28,
                  decoration: BoxDecoration(
                    border: Border.all(color: ColorConstant.whiteBlack20),
                    color: ColorConstant.whiteBlack40,
                    borderRadius: BorderRadius.circular(6)
                  ),
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: Icon(
                          PriorityIcon.getIcon(priority),
                          color: ColorConstant.whiteBlack5,
                        ),
                      ),
                      Text(
                        context.watch<HelpDeskViewModel>().convertToString(false, priority),
                        style: const TextStyle(
                          fontFamily: AppFontStyle.font,
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                          color: ColorConstant.whiteBlack5
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                Text(
                  dateCreated,
                  style: const TextStyle(
                    fontFamily: AppFontStyle.font,
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    color: ColorConstant.whiteBlack70
                  ),
                )
              ],
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                flex: 2,
                fit: FlexFit.tight,
                child: Container(
                  padding: const EdgeInsets.only(left: 24, right: 24, bottom: 25),
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(16)),
                  child: Column(
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    color: ColorConstant.whiteBlack15,
                                    width: 1,
                                    strokeAlign: StrokeAlign.inside))),
                        child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: ColorConstant.white,
                                boxShadow: [
                                  BoxShadow(
                                      offset: const Offset(1, -2),
                                      color: ColorConstant.black.withOpacity(0.05),
                                      blurRadius: 4)
                                ],
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(16),
                                    topRight: Radius.circular(16))),
                            height: 80,
                            child: Text(
                              adminName,
                              style: const TextStyle(
                                  color: ColorConstant.whiteBlack80,
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold),
                            )),
                      ),
                      Container(
                        constraints: const BoxConstraints(minHeight: 300),
                        height: screenHeight - 560,
                        decoration: const BoxDecoration(color: ColorConstant.whiteBlack5),
                        child: ListView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          itemCount: data.length,
                          itemBuilder: (context, index) => Message(
                            isSender:  data[index]["isSender"],
                            text: data[index]["text"],
                            isMobile: false,
                            time: "3 Mar - 19:13PM",
                          ),
                        ),
                      ),
                      const ChatInputDesktop(),
                    ],
                  ),
                ),
              ),
              Flexible(
                fit: FlexFit.tight,
                child: DescriptionDesktop(
                  isAdmin: role == 0 ? true : false,
                )
              )
            ],
          ),
        ],
      ),
    );
  }
}