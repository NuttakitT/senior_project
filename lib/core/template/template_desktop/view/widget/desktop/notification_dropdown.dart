// ignore_for_file: prefer_is_empty

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senior_project/assets/color_constant.dart';
import 'package:senior_project/assets/font_style.dart';
import 'package:senior_project/core/datasource/firebase_services.dart';
import 'package:senior_project/core/template/template_desktop/view_model/template_desktop_view_model.dart';
import 'package:senior_project/core/view_model/app_view_model.dart';

class NotificationDropdown extends StatefulWidget {
  const NotificationDropdown({super.key});

  @override
  State<NotificationDropdown> createState() => _NotificationDropdownState();
}

class _NotificationDropdownState extends State<NotificationDropdown> {
  FirebaseServices service = FirebaseServices("ticket");
  FirebaseServices userService = FirebaseServices("user");

  Widget popupNotification(List<Map<String, dynamic>> list) {
    DateTime local = DateTime.now();
    TextStyle timeStyle = const TextStyle(
      fontFamily: AppFontStyle.font,
      fontWeight: AppFontWeight.regular,
      fontSize: 12,
      color: ColorConstant.whiteBlack40
    );

    return Padding(
      padding: const EdgeInsets.only(right: 28),
      child: PopupMenuButton(
        padding: const EdgeInsets.all(0),
        child: Stack(
          alignment: list.isNotEmpty ? Alignment.bottomRight : Alignment.center,
          children: [
            const Icon(
              Icons.notifications_rounded,
              color: Colors.white,
            ),
            Builder(
              builder: (context) {
                if (list.isNotEmpty) {
                  return Container(
                    width: 10,
                    height: 10,
                    decoration: const BoxDecoration(
                      color: ColorConstant.red50,
                      shape: BoxShape.circle
                    ),
                  );
                }
                return Container();
              },
            )
          ],
        ),
        itemBuilder: (context) {
          List<PopupMenuItem> result = [
            const PopupMenuItem(
              enabled: false,
              child: Text(
                "Notification",
                style: TextStyle(
                  fontFamily: AppFontStyle.font,
                  fontWeight: AppFontWeight.regular,
                  fontSize: 24,
                  color: ColorConstant.whiteBlack90
                ),
              ),
            )
          ];
          for (int i = 0; i < list.length; i++) {
            List<String> time = local.difference(list[i]["dateCreate"]).toString().split(":");
            result.add(
              PopupMenuItem(
                child: Column(
                  children: [
                    Container(
                      width: 319,
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        border: Border(
                          bottom: BorderSide(color: ColorConstant.whiteBlack20)
                        )
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                list[i]["title"],
                                style: const TextStyle(
                                  fontFamily: AppFontStyle.font,
                                  fontWeight: AppFontWeight.regular,
                                  fontSize: 20,
                                  color: ColorConstant.whiteBlack90
                                ),
                              ),
                              Builder(
                                builder: (context) {
                                  if (time[0] != "0") {
                                    int day = (int.parse(time[0])%24).ceil();
                                    return Text(
                                      day != 0 
                                      ? "$day day ago" 
                                      : "${time[0]} hour ago",
                                      style: timeStyle,
                                    );
                                  }
                                  if (time[1] != "0") {
                                    return Text(
                                    "${time[1]} min ago",
                                    style: timeStyle,
                                  );
                                  }
                                  return Text(
                                    "recently",
                                    style: timeStyle,
                                  );
                                },
                              )
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: RichText(
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: list[i]["detail"],
                                    style: const TextStyle(
                                      fontWeight: AppFontWeight.regular,
                                      fontSize: 14,
                                      color: ColorConstant.whiteBlack60
                                    )
                                  )
                                ]
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              )
            );
          }
          return result;
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    String uid = context.watch<AppViewModel>().app.getUser.getId;

    return StreamBuilder(
      stream: service.listenToDocumentByKeyValuePair(
        ["adminId"], 
        [uid],
        orderingField: "dateCreate",
        descending: true
      ),
      builder: (context, ticketSnapshot) {
        if (ticketSnapshot.connectionState == ConnectionState.active) {
          if (ticketSnapshot.data!.docs.length != 0) {
            context.read<TemplateDesktopViewModel>().clearNotification();
            for (int i = 0; i < ticketSnapshot.data!.docs.length; i++) {
              if (ticketSnapshot.data!.docs[i].get("status") < 2) {
                context.read<TemplateDesktopViewModel>().addPendingTicket({
                  "docId": ticketSnapshot.data!.docs[i].id,
                  "title": ticketSnapshot.data!.docs[i].get("title"),
                  "detail": ticketSnapshot.data!.docs[i].get("detail"),
                  "dateCreate": ticketSnapshot.data!.docs[i].get("dateCreate").toDate(),
                });
              }
            }
            return popupNotification(context.watch<TemplateDesktopViewModel>().getPendingTicket);
          }
          return popupNotification([]);
        }
        return popupNotification([]);
      }
    );
  }
}