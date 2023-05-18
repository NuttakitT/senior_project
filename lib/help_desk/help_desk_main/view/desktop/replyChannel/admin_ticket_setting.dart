// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senior_project/assets/color_constant.dart';
import 'package:senior_project/assets/font_style.dart';
import 'package:senior_project/core/datasource/firebase_services.dart';
import 'package:senior_project/core/view_model/app_view_model.dart';
import 'package:senior_project/help_desk/help_desk_main/view_model/help_desk_view_model.dart';
import 'package:senior_project/help_desk/help_desk_reply/view_model/reply_channel_view_model.dart';
import 'package:senior_project/role_management/view_model/role_management_view_model.dart';

class AdminTicketSetting extends StatefulWidget {
  const AdminTicketSetting({super.key});

  @override
  State<AdminTicketSetting> createState() => _AdminTicketSettingState();
}

class _AdminTicketSettingState extends State<AdminTicketSetting> {
  static List<String> priority = ["Low", "Medium", "High", "Urgent"];
  static List<String> status = ["Not Start", "Pending", "Complete"];
  List<String> admin = [];
  String priorityValue = priority[0];
  String stausValue = status[0];
  String? adminValue;
  String hintText = "Assign to";
  dynamic taskAdmin = "";
  
  @override
  Widget build(BuildContext context) {
    String uid = context.watch<AppViewModel>().app.getUser.getId;
    context.read<RoleManagementViewModel>().initModel();

    return FutureBuilder(
      future: context.read<RoleManagementViewModel>().fetchPage(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          admin = [];
          for (int i = 0; i < snapshot.data!.admins.length; i++) {
            admin.add(snapshot.data!.admins[i].firstName);
          }
          String docId = context.watch<ReplyChannelViewModel>().getTaskData["docId"];
          return StreamBuilder(
            stream: FirebaseServices("ticket").listenToDocument(docId),
            builder: (context, streamSnapshot) {
              if (streamSnapshot.connectionState == ConnectionState.active) {
                taskAdmin = streamSnapshot.data!.get("adminId");
                if (taskAdmin == uid) {
                  hintText = "You";
                }
                return Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 16),
                      child: Container(
                        height: 32,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: ColorConstant.whiteBlack30)
                        ),
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                            value: priority[streamSnapshot.data!.get("priority")],
                            style: const TextStyle(
                              fontFamily: AppFontStyle.font,
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                              color: ColorConstant.whiteBlack90
                            ),
                            items:
                                priority.map<DropdownMenuItem<String>>((value) {
                              return DropdownMenuItem(
                                  value: value, child: Text(value));
                            }).toList(),
                            onChanged: (value) async {
                              await context.read<HelpDeskViewModel>().editTask(
                                  context.read<ReplyChannelViewModel>().getTaskData["docId"], 
                                  false, 
                                  priority.indexOf(value!)
                              );
                            },
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                    ),
                    Builder(
                      builder: (context) {
                        bool isItemRequest = context.watch<ReplyChannelViewModel>().getTaskData["isItemRequest"];
                        if (isItemRequest) {
                          return Container();
                        }
                        return Padding(
                          padding: const EdgeInsets.only(right: 16),
                          child: Container(
                            height: 32,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: ColorConstant.whiteBlack30)
                            ),
                            alignment: Alignment.center,
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton(
                                value: status[streamSnapshot.data!.get("status")],
                                style: const TextStyle(
                                  fontFamily: AppFontStyle.font,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16,
                                  color: ColorConstant.whiteBlack90
                                ),
                                items:
                                    status.map<DropdownMenuItem<String>>((value) {
                                  return DropdownMenuItem(
                                      value: value, child: Text(value));
                                }).toList(),
                                onChanged: (value) async {
                                  await context.read<HelpDeskViewModel>().editTask(
                                    context.read<ReplyChannelViewModel>().getTaskData["docId"], 
                                    true, 
                                    status.indexOf(value!)
                                  );
                                },
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                          ),
                        );
                      }
                    ),
                    Container(
                      height: 32,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: ColorConstant.whiteBlack30)
                      ),
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Builder(
                        builder: (context) {
                          if (taskAdmin != uid && taskAdmin != null) {
                            return Text(
                              adminValue!,
                              style: const TextStyle(
                                fontFamily: AppFontStyle.font,
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                                color: ColorConstant.whiteBlack90
                              ),
                            );
                          }
                          return DropdownButtonHideUnderline(
                            child: DropdownButton(
                              hint: Text(
                                  hintText,
                                  style: const TextStyle(
                                    fontFamily: AppFontStyle.font,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                    color: ColorConstant.whiteBlack90
                                  ),
                              ),
                              value: adminValue,
                              style: const TextStyle(
                                fontFamily: AppFontStyle.font,
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                                color: ColorConstant.whiteBlack90
                              ),
                              items:
                                  admin.map<DropdownMenuItem<String>>((value) {
                                return DropdownMenuItem(
                                    value: value, child: Text(value));
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  adminValue = value!;
                                });
                                int index = admin.indexOf(adminValue!);
                                context.read<HelpDeskViewModel>().setTicketResponsibility(
                                  docId, 
                                  snapshot.data!.admins[index].userId,
                                  true
                                );
                              },
                              borderRadius: BorderRadius.circular(4),
                            ),
                          );
                        }
                      ),
                    ),
                    Builder(
                      builder: (context) {
                        if (taskAdmin == uid || taskAdmin != null) {
                          return Container();
                        } else {
                          return Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: TextButton(
                              onPressed: () async {
                                await context.read<HelpDeskViewModel>().setTicketResponsibility(docId, uid, false);
                                setState(() {
                                  adminValue = null;
                                });
                              }, 
                              child: const Text(
                                "Assign to me",
                                style: TextStyle(
                                  fontFamily: AppFontStyle.font,
                                  fontSize: 18,
                                  color: ColorConstant.blue50
                                ),
                              )
                            ),
                          );
                        } 
                      }
                    )
                  ],
                );
              }
              return Container();
            }
          );
        }
        return Container();
      }
    );
  }
}