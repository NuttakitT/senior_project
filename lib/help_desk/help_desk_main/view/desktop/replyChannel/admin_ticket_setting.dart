import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senior_project/assets/color_constant.dart';
import 'package:senior_project/assets/font_style.dart';
import 'package:senior_project/core/datasource/firebase_services.dart';
import 'package:senior_project/help_desk/help_desk_main/view_model/help_desk_view_model.dart';
import 'package:senior_project/help_desk/help_desk_reply/view_model/reply_channel_view_model.dart';

class AdminTicketSetting extends StatefulWidget {
  const AdminTicketSetting({super.key});

  @override
  State<AdminTicketSetting> createState() => _AdminTicketSettingState();
}

class _AdminTicketSettingState extends State<AdminTicketSetting> {
  static List<String> priority = ["Low", "Medium", "High", "Urgent"];
  static List<String> status = ["Not Start", "Pending", "Complete"];
  static List<String> admin = ["Admin1", "Admin2", "Admin3"];
  String priorityValue = priority[0];
  String stausValue = status[0];
  String? adminValue;
  
  @override
  Widget build(BuildContext context) {
    String docId = context.read<ReplyChannelViewModel>().getTaskData["docId"];

    return StreamBuilder(
      stream: FirebaseServices("ticket").listenToDocument(docId),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.active) {
          return Container();
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
                    value: priority[snapshot.data!.get("priority")],
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
                    value: status[snapshot.data!.get("status")],
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
            ),
            Container(
              height: 32,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: ColorConstant.whiteBlack30)
              ),
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: DropdownButtonHideUnderline(
                child: DropdownButton(
                  hint: const Text(
                      "Assign to",
                      style: TextStyle(
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
                  },
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
          ],
        );
      }
    );
  }
}