// ignore_for_file: depend_on_referenced_packages, use_build_context_synchronously, prefer_is_empty

import 'package:firebase_auth/firebase_auth.dart';
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

class Content extends StatefulWidget {
  final double size;
  final Map<String, dynamic> detail;
  final int index;
  const Content({super.key, required this.size, required this.detail, required this.index});

  @override
  State<Content> createState() => _ContentState();
}

class _ContentState extends State<Content> {
  TextStyle textStyle(bool isRead, Color color, String font) => TextStyle(
    fontFamily: font,
    fontSize: 16,
    fontWeight: isRead ? FontWeight.w400 : FontWeight.w600,
    color: color
  );

  @override
  Widget build(BuildContext context) {
    int status = widget.detail["status"];
    int priority = widget.detail["priority"];
    String localTime = "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}";
    String taskTime = "${widget.detail["time"].day}/${widget.detail["time"].month}/${widget.detail["time"].year}";
    String uid = context.watch<AppViewModel>().app.getUser.getId;
    bool isAdmin = context.watch<AppViewModel>().app.getUser.getRole == 0;
    bool isSeen = widget.detail["isSeen"].contains(uid) || FirebaseAuth.instance.currentUser!.uid == widget.detail["ownerId"];

    return InkWell(
      onTap: () {
        context.read<HelpDeskViewModel>().setSelectedTicket = widget.index;
        context.read<HelpDeskViewModel>().setShowMessagePageState(true);
      },
      child: Container(
        height: widget.size,
        decoration: BoxDecoration(
          color: isSeen ? ColorConstant.blue5 : Colors.white,
          border: Border(
            bottom: BorderSide(color: isSeen 
            ? ColorConstant.blue10 
            : ColorConstant.whiteBlack30
            ),
          )
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: StreamBuilder(
                stream: FirebaseServices("ticket").listenToSubDocumentByKeyValuePair(
                  widget.detail["docId"],
                  "replyChannel",
                  ["seen"],
                  [false],
                ),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.active) {
                    if (snapshot.data == null) {
                      return Container(
                        width: 22,
                        height: 22,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle
                        ),
                      );
                    }
                    else if (snapshot.data!.docs.length != 0) {
                      int unseen = 0;
                      for(int i = 0; i < snapshot.data!.docs.length; i++) {
                        if (!isAdmin && snapshot.data!.docs[i].get("ownerId") != widget.detail["ownerId"]) {
                          unseen++;
                        } else if(isAdmin && snapshot.data!.docs[i].get("ownerId") == widget.detail["ownerId"]) {
                          unseen++;
                        }
                      }
                      if (unseen > 0) {
                        return Container(
                          width: 22,
                          height: 22,
                          decoration: const BoxDecoration(
                            color: ColorConstant.red50,
                            shape: BoxShape.circle
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            unseen.toString(),
                            style: const TextStyle(
                              fontFamily: AppFontStyle.font,
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w500
                            ),
                          ),
                        );
                      }
                      return Container(
                        width: 22,
                        height: 22,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle
                        ),
                      );
                    }
                    return Container(
                      width: 22,
                      height: 22,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle
                      ),
                    );
                  }
                  return Container(
                    width: 22,
                    height: 22,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle
                    ),
                  );
                }
              ),
            ),
            SizedBox(
              width: 164,
              child: RichText(
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: widget.detail["name"],
                      style: textStyle(isSeen, ColorConstant.whiteBlack90, AppFontStyle.font)
                    )
                  ]
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: SizedBox(
                width: 146,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 70,
                      height: 24,
                      decoration: BoxDecoration(
                        color: StatusColor.statusColor(status)![0],
                        border: Border.all(color: StatusColor.statusColor(status)![2]),
                        borderRadius: BorderRadius.circular(6)
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        context.watch<HelpDeskViewModel>().convertToString(true, status),
                        style: TextStyle(
                          fontFamily: AppFontStyle.font,
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                          color: StatusColor.statusColor(status)![1]
                        ),
                      ),
                    ),
                    Container(
                      width: 70,
                      height: 24,
                      decoration: BoxDecoration(
                        color: ColorConstant.whiteBlack5,
                        border: Border.all(color: ColorConstant.whiteBlack30),
                        borderRadius: BorderRadius.circular(6)
                      ),
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Icon(
                            PriorityIcon.getIcon(priority),
                            color: ColorConstant.whiteBlack70,
                            size: 15,
                          ),
                          Text(
                            context.watch<HelpDeskViewModel>().convertToString(false, priority),
                            style: const TextStyle(
                              fontFamily: AppFontStyle.font,
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                              color: ColorConstant.whiteBlack70
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              child: RichText(
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: widget.detail["title"],
                      style: textStyle(isSeen, ColorConstant.whiteBlack90, AppFontStyle.thaiFont)
                    ),
                    TextSpan(
                      text: " - ${widget.detail["detail"]}",
                      style: textStyle(isSeen, ColorConstant.whiteBlack60, AppFontStyle.thaiFont)
                    )
                  ]
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                alignment: Alignment.center,
                width: 70,
                child: Text(
                  localTime == taskTime 
                    ? DateFormat('hh:mm a').format(widget.detail["time"]) 
                    : DateFormat('dd MMM').format(widget.detail["time"]),
                  style: const TextStyle(
                    fontFamily: AppFontStyle.font,
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                    color: ColorConstant.whiteBlack60
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}