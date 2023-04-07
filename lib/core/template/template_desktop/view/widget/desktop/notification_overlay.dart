import 'dart:html';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senior_project/assets/color_constant.dart';
import 'package:senior_project/assets/font_style.dart';
import 'package:senior_project/core/view_model/app_view_model.dart';

class NotificationOverlay extends StatefulWidget {
  const NotificationOverlay({Key? key}) : super(key: key);

  @override
  State<NotificationOverlay> createState() => _NotificationOverlayState();
}

class _NotificationOverlayState extends State<NotificationOverlay> {
  late TimeOfDay startTime;
  late TimeOfDay endTime;
  @override
  void initState() {
    context.read<AppViewModel>().getSettingDetail();
    // TODO: implement initState
    startTime = context.read<AppViewModel>().startTime;
    endTime = context.read<AppViewModel>().endTime;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final startTimeHour = startTime.hour.toString().padLeft(2, '0');
    final startTimeMinute = startTime.minute.toString().padLeft(2, '0');

    final endTimeHour = endTime.hour.toString().padLeft(2, '0');
    final endTimeMinute = endTime.minute.toString().padLeft(2, '0');

    return SizedBox(
      width: 328.0,
      height: 250.0,
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: ColorConstant.whiteBlack80, width: 1),
            borderRadius: BorderRadius.circular(8.0),
            color: Colors.white),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DefaultTextStyle(
                style: AppFontStyle.wb80Md20,
                child: Text(Consts.notificationLabel),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: 280,
                height: 36,
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        DefaultTextStyle(
                            style: AppFontStyle.wb80R16,
                            child: Text(Consts.emailNotificationLabel)),
                        DefaultTextStyle(
                            style: AppFontStyle.wb60L12,
                            child: Text(Consts.emailNotificationDetailLabel))
                      ],
                    ),
                    const Spacer(),
                    SizedBox(
                      width: 72,
                      child: Material(
                        child: Switch(
                            activeColor: ColorConstant.blue40,
                            value: context.read<AppViewModel>().isEmailEnable,
                            onChanged: (value) {
                              setState(() {
                                context
                                    .read<AppViewModel>()
                                    .updateSwitchValue(value);
                              });
                            }),
                      ),
                    )
                  ],
                ),
              ),
              // here
              const SizedBox(height: 16),
              SizedBox(
                width: 288,
                height: 36,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DefaultTextStyle(
                        style: AppFontStyle.wb80R16, child: Text(Consts.time)),
                    DefaultTextStyle(
                        style: AppFontStyle.wb60L12,
                        child: Text(Consts.timeDetailLabel))
                  ],
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 48,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(
                            color: ColorConstant
                                .whiteBlack40), // False is not empty
                      ),
                      child: GestureDetector(
                        child: Text(
                          '$startTimeHour:$startTimeMinute',
                          style: AppFontStyle.wb80R14,
                          textAlign: TextAlign.center,
                        ),
                        onTap: () async {
                          TimeOfDay? newTime = await showTimePicker(
                            context: context,
                            initialTime: startTime,
                          );

                          if (newTime == null) return;

                          setState(() {
                            startTime = newTime;
                          });
                        },
                      ),
                    ),
                    const Spacer(),
                    DefaultTextStyle(
                        style: AppFontStyle.wb60R14, child: Text(Consts.to)),
                    const Spacer(),
                    Container(
                      width: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(color: ColorConstant.whiteBlack40),
                      ),
                      child: GestureDetector(
                        child: Text(
                          '$endTimeHour:$endTimeMinute',
                          style: AppFontStyle.wb80R14,
                          textAlign: TextAlign.center,
                        ),
                        onTap: () async {
                          TimeOfDay? newTime = await showTimePicker(
                            context: context,
                            initialTime: endTime,
                          );

                          if (newTime == null) return;

                          setState(() {
                            endTime = newTime;
                          });
                        },
                      ),
                    ),
                    const Spacer(),
                    TextButton(
                        onPressed: () {
                          context
                              .read<AppViewModel>()
                              .setTime(startTime, endTime);
                        },
                        child: Text(
                          Consts.set,
                          style: AppFontStyle.orange40B16,
                        ))
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Consts {
  static String notificationLabel = "Notification";
  static String emailNotificationLabel = "E-mail Notification";
  static String emailNotificationDetailLabel = "Send task help-desk to e-mail.";
  static String time = "Time";
  static String timeDetailLabel =
      "Set start-time and end-time for notification.";
  static String to = "to";
  static String set = "Set";
}
