import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senior_project/assets/color_constant.dart';
import 'package:senior_project/help_desk/admin/help_desk_main/assets/status_color.dart';
import 'package:senior_project/help_desk/admin/help_desk_main/view/widget/core/priority_icon.dart';
import 'package:senior_project/help_desk/admin/help_desk_main/view_model/task_view_model.dart';

class TaskCard extends StatefulWidget {
  final Map<String, dynamic> detail;
  const TaskCard({super.key, required this.detail});

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  TextStyle detailStyle(Color color) {
    return TextStyle(
      fontFamily: ColorConstant.font,
      fontWeight: FontWeight.w400,
      fontSize: 14,
      color: color
    );
  }  

  @override
  Widget build(BuildContext context) {
    String status = context.watch<TaskViewModel>().convertToString(true, widget.detail["status"]);
    String priority = context.watch<TaskViewModel>().convertToString(false, widget.detail["priority"]);
    List<Color> statusColor = StatusColor.getColor(true, widget.detail["status"]);
    IconData priorityIcon = PriorityIcon.getIcon(widget.detail["priority"]);
    double cardWidth = 396;
    TextStyle labelStyle = const TextStyle(
      fontFamily: ColorConstant.font,
      fontWeight: FontWeight.w300,
      fontSize: 14,
      color: ColorConstant.whiteBlack80
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Container(
          width: cardWidth,
          decoration: BoxDecoration(
            border: Border.all(color: ColorConstant.orange50),
            borderRadius: BorderRadius.circular(8),
            color: Colors.white
          ),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 220,
                        padding: const EdgeInsets.only(right: 16),
                        child: RichText(
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: widget.detail["taskHeader"],
                                style: const TextStyle(
                                  fontFamily: ColorConstant.font,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20,
                                  color: ColorConstant.whiteBlack80
                                ),
                              )
                            ],
                          ),
                        )
                      ),
                      Text(
                        widget.detail["id"],
                        style: const TextStyle(
                          fontFamily: ColorConstant.font,
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                          color: ColorConstant.whiteBlack60
                        ),
                      ),
                    ],
                  ),
                  const RotatedBox(
                    quarterTurns: 1,
                    child: Icon(
                      Icons.keyboard_control, 
                      size: 20,
                    ),
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
                                fontFamily: ColorConstant.font,
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                                color: statusColor[1]
                              ),
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
                            )
                          ),
                          Text(
                            priority,
                            style: const TextStyle(
                              fontFamily: ColorConstant.font,
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                              color: ColorConstant.whiteBlack50
                            ),
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
                                style: detailStyle(ColorConstant.whiteBlack80),
                              )
                            ],
                          ),
                        ),
                      )
                    ),
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
                        widget.detail["time"],
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
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: ColorConstant.whiteBlack15),
                    borderRadius: BorderRadius.circular(4)
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
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
    );
  }
}