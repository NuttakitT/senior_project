// ignore_for_file: depend_on_referenced_packages, use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:senior_project/assets/color_constant.dart';
import 'package:senior_project/assets/font_style.dart';
import 'package:senior_project/core/view_model/app_view_model.dart';
import 'package:senior_project/help_desk/help_desk_main/view_model/help_desk_view_model.dart';
import 'package:senior_project/help_desk/help_desk_reply/view/page/help_desk_reply_page.dart';

class TicketCard extends StatefulWidget {
  final Map<String, dynamic> detail;
  const TicketCard({super.key, required this.detail});

  @override
  State<TicketCard> createState() => _TicketCardState();
}

class _TicketCardState extends State<TicketCard> {
  TextStyle detailStyle(double size, bool isRead, Color color) {
    return TextStyle(
        fontFamily: AppFontStyle.font,
        fontWeight: isRead ? AppFontWeight.regular : AppFontWeight.medium,
        fontSize: size,
        color: color);
  }

  @override
  Widget build(BuildContext context) {
    String status = context
        .watch<HelpDeskViewModel>()
        .convertToString(true, widget.detail["status"]);
    double cardWidth = 396;
    String localTime =
        "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}";
    String taskTime =
        "${widget.detail["time"].day}/${widget.detail["time"].month}/${widget.detail["time"].year}";
    String uid = context.watch<AppViewModel>().app.getUser.getId;
    bool isRead = widget.detail["isSeen"].contains(uid) ||
        FirebaseAuth.instance.currentUser!.uid == widget.detail["ownerId"];

    return FutureBuilder(
        future: context.read<HelpDeskViewModel>().formatTaskDetail(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Padding(
              padding:
                  const EdgeInsets.only(left: 16, right: 8, bottom: 4, top: 4),
              child: InkWell(
                onTap: () async {
                  String docId = await context
                      .read<HelpDeskViewModel>()
                      .getTaskDocId(widget.detail["id"]);
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return HelpDeskReplyPage(
                      isItemRequest: widget.detail["isItemRequest"],
                      docId: docId,
                      id: widget.detail["id"],
                      title: widget.detail["title"],
                      detail: widget.detail["detail"],
                      priority: widget.detail["priority"],
                      status: widget.detail["status"],
                      category: widget.detail["category"],
                      time: widget.detail["time"],
                      adminId: widget.detail["adminId"],
                      ownerId: widget.detail["ownerId"],
                    );
                  }));
                },
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Container(
                    decoration: const BoxDecoration(
                        border: Border(
                      bottom: BorderSide(
                        color: ColorConstant.whiteBlack20,
                        width: 1.0,
                      ),
                    )),
                    width: cardWidth,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        children: [
                          Container(
                            width: 48,
                            height: 48,
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: ColorConstant.blue20),
                            child: const Icon(
                              Icons.person_rounded,
                              color: ColorConstant.whiteBlack90,
                            ),
                          ),
                          Container(
                            width: 332,
                            padding: const EdgeInsets.only(left: 16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Flexible(
                                        fit: FlexFit.tight,
                                        flex: 2,
                                        child: RichText(
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          text: TextSpan(children: [
                                            TextSpan(
                                                text: widget.detail["name"],
                                                style: detailStyle(
                                                    16,
                                                    isRead,
                                                    isRead
                                                        ? ColorConstant
                                                            .whiteBlack60
                                                        : ColorConstant
                                                            .whiteBlack90))
                                          ]),
                                        )),
                                    Text(
                                        localTime == taskTime
                                            ? DateFormat('hh:mm a')
                                                .format(widget.detail["time"])
                                            : DateFormat('dd MMM')
                                                .format(widget.detail["time"]),
                                        style: detailStyle(
                                            14,
                                            isRead,
                                            isRead
                                                ? ColorConstant.whiteBlack40
                                                : ColorConstant.whiteBlack80)),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text("[$status] ",
                                        style: detailStyle(
                                            14,
                                            isRead,
                                            isRead
                                                ? ColorConstant.whiteBlack60
                                                : ColorConstant.whiteBlack80)),
                                    Flexible(
                                      fit: FlexFit.tight,
                                      flex: 3,
                                      child: RichText(
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        text: TextSpan(children: [
                                          TextSpan(
                                              text: widget.detail["title"],
                                              style: detailStyle(
                                                  14,
                                                  isRead,
                                                  isRead
                                                      ? ColorConstant
                                                          .whiteBlack60
                                                      : ColorConstant
                                                          .whiteBlack80))
                                        ]),
                                      ),
                                    )
                                  ],
                                ),
                                RichText(
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  text: TextSpan(children: [
                                    TextSpan(
                                        text: widget.detail["detail"],
                                        style: detailStyle(
                                            14,
                                            isRead,
                                            isRead
                                                ? ColorConstant.whiteBlack60
                                                : ColorConstant.whiteBlack80))
                                  ]),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          }
          return Container();
        });
  }
}
