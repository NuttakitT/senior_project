// ignore_for_file: depend_on_referenced_packages
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:senior_project/assets/color_constant.dart';
import 'package:senior_project/assets/font_style.dart';
import 'package:senior_project/core/datasource/firebase_services.dart';
import 'package:senior_project/core/view_model/app_view_model.dart';
import 'package:senior_project/help_desk/help_desk_main/view/widget/priority_icon.dart';
import 'package:senior_project/help_desk/help_desk_main/view/widget/status_color.dart';
import 'package:senior_project/help_desk/help_desk_main/view_model/help_desk_view_model.dart';
import 'package:senior_project/help_desk/help_desk_reply/view/widget/chat_input.dart';
import 'package:senior_project/help_desk/help_desk_main/view/desktop/replyChannel/description_desktop.dart';
import 'package:senior_project/help_desk/help_desk_reply/view/widget/message.dart';
import 'package:senior_project/help_desk/help_desk_reply/view_model/reply_channel_view_model.dart';

Stream? query(String docId) {
  return FirebaseServices("ticket").listenToSubDocument(docId, "replyChannel");
}

class BodyReplyDesktop extends StatefulWidget {
  const BodyReplyDesktop({super.key});

  @override
  State<BodyReplyDesktop> createState() => _BodyReplyDesktopState();
}

class _BodyReplyDesktopState extends State<BodyReplyDesktop> {
  @override
  Widget build(BuildContext context) {
    int? role = context.watch<AppViewModel>().app.getUser.getRole;
    String userId = context.watch<AppViewModel>().app.getUser.getId;
    bool isAdmin = context.watch<AppViewModel>().app.getUser.getRole == 0;
    double screenHeight = MediaQuery.of(context).size.height;
    String taskTitle =
        context.watch<ReplyChannelViewModel>().getTaskData["title"];
    String docId = context.watch<ReplyChannelViewModel>().getTaskData["docId"];
    DateTime dateCreated =
        context.watch<ReplyChannelViewModel>().getTaskData["time"];
    context.read<ReplyChannelViewModel>().clearModel();
    String adminName = isAdmin
        ? context.watch<ReplyChannelViewModel>().getTaskData["name"]
        : "Admin";
    String ownerId =
        context.watch<ReplyChannelViewModel>().getTaskData["ownerId"];
    String category = context.watch<ReplyChannelViewModel>().getTaskData["category"];
    return StreamBuilder(
        stream: FirebaseServices("ticket")
            .listenToSubDocument(docId, "replyChannel"),
        // FirebaseServices("ticket").listenToSubDocumentByKeyValuePair(
        //   docId,
        //   "replyChannel",
        //   ["seen"],
        //   [false],
        // ),
        builder: (context, stream) {
          if (stream.connectionState == ConnectionState.active) {
            context.read<HelpDeskViewModel>().clearReplyDocId();
            for (var item in stream.data!.docs) {
              if (!isAdmin && item.get("ownerId") != ownerId) {
                context.read<HelpDeskViewModel>().addReplyDocId(item.id);
              } else if (isAdmin && item.get("ownerId") == ownerId) {
                context.read<HelpDeskViewModel>().addReplyDocId(item.id);
              }
            }
            return FutureBuilder(
                future: context.read<HelpDeskViewModel>().changeSeenStatus(
                      docId,
                      userId,
                      isAdmin,
                    ),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return Container(
                      padding: const EdgeInsets.only(right: 20),
                      decoration: const BoxDecoration(
                          color: ColorConstant.whiteBlack10,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(16),
                            bottomRight: Radius.circular(16),
                          )),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 24, horizontal: 24),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 500,
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 24),
                                    child: DefaultTextStyle(
                                      maxLines: null,
                                      style: const TextStyle(
                                        fontSize: 28,
                                        fontWeight: FontWeight.w500,
                                        color: ColorConstant.whiteBlack90),
                                      child: Text(taskTitle),
                                    ),
                                  ),
                                ),
                                StreamBuilder(
                                    stream: FirebaseServices("ticket")
                                        .listenToDocument(docId),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.active) {
                                        return Padding(
                                          padding:
                                              const EdgeInsets.only(right: 4),
                                          child: Container(
                                            width: 90,
                                            height: 28,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color:
                                                        StatusColor.statusColor(
                                                            snapshot.data!.get(
                                                                "status"))![2]),
                                                color: StatusColor.statusColor(
                                                    snapshot.data!
                                                        .get("status"))![0],
                                                borderRadius:
                                                    BorderRadius.circular(6)),
                                            alignment: Alignment.center,
                                            child: Text(
                                              context
                                                  .watch<HelpDeskViewModel>()
                                                  .convertToString(
                                                      true,
                                                      snapshot.data!
                                                          .get("status")),
                                              style: TextStyle(
                                                  fontFamily: AppFontStyle.font,
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 16,
                                                  color:
                                                      StatusColor.statusColor(
                                                          snapshot.data!.get(
                                                              "status"))![1]),
                                            ),
                                          ),
                                        );
                                      }
                                      return Container();
                                    }),
                                StreamBuilder(
                                    stream: FirebaseServices("ticket")
                                        .listenToDocument(docId),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.active) {
                                        return Container(
                                          width: 100,
                                          height: 28,
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: ColorConstant
                                                      .whiteBlack20),
                                              color: ColorConstant.whiteBlack40,
                                              borderRadius:
                                                  BorderRadius.circular(6)),
                                          alignment: Alignment.center,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 8),
                                                child: Icon(
                                                  PriorityIcon.getIcon(snapshot
                                                      .data!
                                                      .get("priority")),
                                                  color:
                                                      ColorConstant.whiteBlack5,
                                                ),
                                              ),
                                              Text(
                                                context
                                                    .watch<HelpDeskViewModel>()
                                                    .convertToString(
                                                        false,
                                                        snapshot.data!
                                                            .get("priority")),
                                                style: const TextStyle(
                                                    fontFamily:
                                                        AppFontStyle.font,
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 16,
                                                    color: ColorConstant
                                                        .whiteBlack5),
                                              ),
                                            ],
                                          ),
                                        );
                                      }
                                      return Container();
                                    }),
                                const Spacer(),
                                Text(
                                  DateFormat("dd MMMM - hh:mm a")
                                      .format(dateCreated),
                                  style: const TextStyle(
                                      fontFamily: AppFontStyle.font,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400,
                                      color: ColorConstant.whiteBlack70),
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
                                  padding: const EdgeInsets.only(
                                      left: 24, right: 24, bottom: 25),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16)),
                                  child: Column(
                                    children: [
                                      Container(
                                        decoration: const BoxDecoration(
                                            border: Border(
                                                bottom: BorderSide(
                                                    color: ColorConstant
                                                        .whiteBlack15,
                                                    width: 1,
                                                    strokeAlign:
                                                        StrokeAlign.inside))),
                                        child: Container(
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                                color: ColorConstant.white,
                                                boxShadow: [
                                                  BoxShadow(
                                                      offset:
                                                          const Offset(1, -2),
                                                      color: ColorConstant.black
                                                          .withOpacity(0.05),
                                                      blurRadius: 4)
                                                ],
                                                borderRadius:
                                                    const BorderRadius.only(
                                                        topLeft:
                                                            Radius.circular(16),
                                                        topRight:
                                                            Radius.circular(
                                                                16))),
                                            height: 80,
                                            child: Text(
                                              adminName,
                                              style: const TextStyle(
                                                  color: ColorConstant
                                                      .whiteBlack80,
                                                  fontSize: 28,
                                                  fontWeight: FontWeight.bold),
                                            )),
                                      ),
                                      StreamBuilder(
                                          stream: FirebaseServices("ticket")
                                              .listenToDocument(docId),
                                          builder: (context, snapshot) {
                                            if (snapshot.connectionState !=
                                                ConnectionState.active) {
                                              return Container();
                                            }
                                            return Container(
                                                constraints:
                                                    const BoxConstraints(
                                                        minHeight: 300),
                                                height: snapshot.data!
                                                            .get("status") !=
                                                        2
                                                    ? screenHeight - 498
                                                    : screenHeight - 434,
                                                decoration: const BoxDecoration(
                                                    color: ColorConstant
                                                        .whiteBlack5),
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 16),
                                                child: StreamBuilder(
                                                  stream: query(docId),
                                                  builder: (context, snapshot) {
                                                    if (snapshot
                                                            .connectionState ==
                                                        ConnectionState
                                                            .active) {
                                                      if (snapshot.data.docs
                                                          .isNotEmpty) {
                                                        context
                                                            .read<
                                                                ReplyChannelViewModel>()
                                                            .clearModel();
                                                        context
                                                            .read<
                                                                ReplyChannelViewModel>()
                                                            .reconstructData(
                                                                snapshot.data);
                                                        List<
                                                                Map<String,
                                                                    dynamic>>
                                                            data = context
                                                                .watch<
                                                                    ReplyChannelViewModel>()
                                                                .getReply(
                                                                    userId);
                                                        return ListView.builder(
                                                          itemCount:
                                                              data.length,
                                                          itemBuilder: (context,
                                                                  index) =>
                                                              Message(
                                                            isSender: data[
                                                                    index]
                                                                ["isSender"],
                                                            text: data[index]
                                                                ["text"],
                                                            isMobile: false,
                                                            time: data[index]
                                                                ["time"],
                                                            imageUrl: data[index]["imageUrl"],
                                                          ),
                                                        );
                                                      }
                                                      return Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(top: 16),
                                                        child: Container(
                                                            width:
                                                                double.infinity,
                                                            alignment: Alignment
                                                                .topCenter,
                                                            child: const Text(
                                                                "No messages in this ticket")),
                                                      );
                                                    }
                                                    return Center(
                                                        child: Container(
                                                            width: 50,
                                                            height: 50,
                                                            decoration:
                                                                const BoxDecoration(
                                                                    shape: BoxShape
                                                                        .circle),
                                                            child:
                                                                const CircularProgressIndicator()));
                                                  },
                                                ));
                                          }),
                                      StreamBuilder(
                                          stream: FirebaseServices("ticket")
                                              .listenToDocument(docId),
                                          builder: (context, snapshot) {
                                            if (snapshot.connectionState ==
                                                ConnectionState.active) {
                                              dynamic adminId =
                                                  snapshot.data!.get("adminId");
                                              if ((!isAdmin && snapshot.data!.get("status") <
                                                      2) ||
                                                  (isAdmin &&
                                                      (adminId == userId || adminId == null) &&
                                                      snapshot.data!
                                                              .get("status") <
                                                          2)) {
                                                return const ChatInput();
                                              }
                                            }
                                            return Container();
                                          })
                                    ],
                                  ),
                                ),
                              ),
                              Flexible(
                                  fit: FlexFit.tight,
                                  child: FutureBuilder(
                                    future: context.read<HelpDeskViewModel>().fetchQuestion(category),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState == ConnectionState.done) {
                                        return DescriptionDesktop(
                                          isAdmin: role == 0 ? true : false, q: snapshot.data!,
                                        );
                                      }
                                      return Container();
                                    },
                                  )
                              )
                            ],
                          ),
                        ],
                      ),
                    );
                  }
                  return Container(
                    constraints: BoxConstraints(
                        maxHeight:
                            screenHeight < 500 ? 500 : screenHeight - 300,
                        maxWidth: double.infinity),
                    color: Colors.white,
                    alignment: Alignment.center,
                    child: const CircularProgressIndicator(),
                  );
                });
          }
          return Center(
              child: Container(
                  width: 50,
                  height: 50,
                  decoration: const BoxDecoration(shape: BoxShape.circle),
                  child: const CircularProgressIndicator()));
        });
  }
}
