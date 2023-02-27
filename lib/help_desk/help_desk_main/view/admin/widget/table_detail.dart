// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:senior_project/assets/color_constant.dart';
import 'package:senior_project/assets/font_style.dart';
import 'package:senior_project/help_desk/help_desk_main/assets/status_color.dart';
import 'package:senior_project/help_desk/help_desk_main/view/admin/widget/action_button.dart';
import 'package:senior_project/help_desk/help_desk_main/core/widget/priority_icon.dart';
import 'package:senior_project/help_desk/help_desk_main/view_model/help_desk_view_model.dart';

class TableDetail {
  static TextStyle _detailTextStyle(double size, Color color) {
    return TextStyle(
        fontFamily: AppFontStyle.font,
        fontWeight: FontWeight.w400,
        color: color,
        fontSize: size);
  }

  static List<Widget> widget(
      BuildContext context, Map<String, dynamic> detail) {
    List<Color> statusColor = StatusColor.getColor(false, detail["status"]);
    String priority = context.watch<HelpDeskViewModel>().convertToString(false, detail["priority"]);
    String status = context.watch<HelpDeskViewModel>().convertToString(true, detail["status"]);
    String localTime = "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}";
    String taskTime = "${detail["time"].day}/${detail["time"].month}/${detail["time"].year}";
    
    return [
      SizedBox(
        width: 200,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Container(
                  width: 40,
                  height: 40,
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: Color(0x6629B6F6)),
                  child: const Icon(Icons.person)),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    text: TextSpan(children: [
                      TextSpan(
                        text: detail["username"],
                        style: _detailTextStyle(20, ColorConstant.whiteBlack80),
                      )
                    ]),
                  ),
                  RichText(
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    text: TextSpan(children: [
                      TextSpan(
                        text: detail["email"],
                        style: _detailTextStyle(12, ColorConstant.whiteBlack60),
                      )
                    ]),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      Flexible(
        flex: 3,
        fit: FlexFit.tight,
        child: Padding(
          padding: const EdgeInsets.only(right: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                text: TextSpan(children: [
                  TextSpan(
                    text: detail["title"],
                    style: _detailTextStyle(16, ColorConstant.whiteBlack80),
                  )
                ]),
              ),
              RichText(
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                text: TextSpan(children: [
                  TextSpan(
                    text: detail["detail"],
                    style: _detailTextStyle(12, ColorConstant.whiteBlack60),
                  )
                ]),
              ),
            ],
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(right: 20),
        child: Container(
          height: 24,
          width: 100,
          padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 6),
          decoration: BoxDecoration(
            border: Border.all(color: ColorConstant.whiteBlack15),
            borderRadius: BorderRadius.circular(8),
            color: ColorConstant.whiteBlack5
          ),
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Icon(
                  PriorityIcon.getIcon(detail["priority"]),
                  color: ColorConstant.whiteBlack80,
                  size: 12,
                ),
                Text(
                  priority,
                  style: _detailTextStyle(10.5, ColorConstant.whiteBlack80),
                )
              ],
            ),
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(right: 20),
        child: Container(
          height: 24,
          width: 100,
          padding: const EdgeInsets.symmetric(horizontal: 9.5, vertical: 4),
          decoration: BoxDecoration(
            border: Border.all(color: statusColor[1]),
            borderRadius: BorderRadius.circular(8),
            color: statusColor[0]
          ),
          child: Text(
            status,
            textAlign: TextAlign.center,
            style: _detailTextStyle(10.5, statusColor[2]),
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(right: 20),
        child: SizedBox(
          width: 120,
          child: RichText(
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            text: TextSpan(
              children: [
                TextSpan(
                  text: detail["category"],
                  style: _detailTextStyle(14, ColorConstant.whiteBlack70), 
                )
              ]
            ),
          ),
        ),
      ),
      Container(
        width: 70,
        alignment: Alignment.centerLeft,
        child: Text(
            localTime == taskTime 
              ? DateFormat('hh:mm a').format(detail["time"]) 
              : DateFormat('dd MMM').format(detail["time"]),
            style: _detailTextStyle(14, ColorConstant.whiteBlack60),
          ),
      ),
      SizedBox(
        width: 105,
        child: 
        Align(
          alignment: Alignment.center,
          child: ActionButton(id: detail["id"],),
        )
      )
    ];
  }
}
