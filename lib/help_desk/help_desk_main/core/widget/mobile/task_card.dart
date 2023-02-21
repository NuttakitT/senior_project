// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:senior_project/assets/color_constant.dart';
import 'package:senior_project/assets/font_style.dart';
import 'package:senior_project/help_desk/help_desk_main/assets/status_color.dart';
import 'package:senior_project/help_desk/help_desk_main/core/widget/priority_icon.dart';
import 'package:senior_project/help_desk/help_desk_main/view_model/help_desk_view_model.dart';

class TaskCard extends StatefulWidget {
  final Map<String, dynamic> detail;
  const TaskCard({super.key, required this.detail});

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  TextStyle detailStyle(Color color) {
    return TextStyle(
        fontFamily: AppFontStyle.font,
        fontWeight: AppFontWeight.regular,
        fontSize: 14,
        color: color);
  }

  @override
  Widget build(BuildContext context) {
    String status = context
        .watch<HelpDeskViewModel>()
        .convertToString(true, widget.detail["status"]);
    String priority = context
        .watch<HelpDeskViewModel>()
        .convertToString(false, widget.detail["priority"]);
    List<Color> statusColor =
        StatusColor.getColor(true, widget.detail["status"]);
    IconData priorityIcon = PriorityIcon.getIcon(widget.detail["priority"]);
    String time = DateFormat('hh:mm a').format(widget.detail["time"]);
    double cardWidth = 396;
    TextStyle labelStyle = AppFontStyle.wb80L14;

    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 8),
      child: InkWell(
        onTap: () {
          // TODO link to reply channel
        },
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Container(
            width: cardWidth,
            decoration: BoxDecoration(
                border: Border.all(color: ColorConstant.orange50),
                borderRadius: BorderRadius.circular(8),
                color: Colors.white),
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 220),
                          child: Padding(
                              padding: const EdgeInsets.only(right: 16),
                              child: RichText(
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: widget.detail["taskHeader"],
                                      style: AppFontStyle.wb80SemiB20,
                                    )
                                  ],
                                ),
                              )),
                        ),
                        Text(
                          "#${widget.detail["id"][0]}${widget.detail["id"][1]}${widget.detail["id"][2]}",
                          style: const TextStyle(
                            fontFamily: AppFontStyle.font,
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                            color: ColorConstant.whiteBlack60
                          ),
                        ),
                      ],
                    ),
                    const Icon(
                      Icons.turn_right_rounded,
                      size: 20,
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 4),
                        child: Container(
                          height: 18,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: statusColor[0],
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 4),
                                child: Container(
                                  width: 8,
                                  height: 8,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: statusColor[1],
                                  ),
                                ),
                              ),
                              Text(
                                status,
                                style: TextStyle(
                                    fontFamily: AppFontStyle.font,
                                    fontWeight: AppFontWeight.regular,
                                    fontSize: 12,
                                    color: statusColor[1]),
                              )
                            ],
                          ),
                        ),
                      ),
                      Container(
                        height: 18,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: ColorConstant.whiteBlack5,
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                                padding: const EdgeInsets.only(right: 5.2),
                                child: Icon(
                                  priorityIcon,
                                  size: 14,
                                  color: ColorConstant.whiteBlack70,
                                )),
                            Text(
                              priority,
                              style: AppFontStyle.wb50R12,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        flex: 2,
                        fit: FlexFit.tight,
                        child: Text(
                          "Sender name:",
                          style: labelStyle,
                        ),
                      ),
                      Flexible(
                          flex: 2,
                          fit: FlexFit.tight,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: RichText(
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: widget.detail["username"],
                                    style:
                                        detailStyle(ColorConstant.whiteBlack80),
                                  )
                                ],
                              ),
                            ),
                          )),
                      Flexible(
                        fit: FlexFit.tight,
                        child: Text(
                          "Time:",
                          style: labelStyle,
                        ),
                      ),
                      Flexible(
                        flex: 2,
                        fit: FlexFit.tight,
                        child: Text(
                          time,
                          style: detailStyle(ColorConstant.whiteBlack80),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Row(
                    children: [
                      Flexible(
                        flex: 2,
                        fit: FlexFit.tight,
                        child: Text(
                          "Category:",
                          style: labelStyle,
                        ),
                      ),
                      Flexible(
                        flex: 5,
                        fit: FlexFit.tight,
                        child: RichText(
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: widget.detail["category"],
                                style: detailStyle(ColorConstant.whiteBlack80),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(
                    "Detail",
                    style: labelStyle,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Container(
                    height: 64,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: ColorConstant.whiteBlack15),
                        borderRadius: BorderRadius.circular(4)),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    child: RichText(
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: widget.detail["taskDetail"],
                            style: detailStyle(ColorConstant.whiteBlack60),
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
