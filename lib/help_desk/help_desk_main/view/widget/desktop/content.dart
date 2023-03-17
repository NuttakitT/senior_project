import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senior_project/assets/color_constant.dart';
import 'package:senior_project/assets/font_style.dart';
import 'package:senior_project/help_desk/help_desk_main/view/widget/priority_icon.dart';
import 'package:senior_project/help_desk/help_desk_main/view/widget/status_color.dart';
import 'package:senior_project/help_desk/help_desk_main/view_model/help_desk_view_model.dart';

class Content extends StatefulWidget {
  final double size;
  const Content({super.key, required this.size});

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
    int status = 1;
    int priority = 3;

    return InkWell(
      onTap: () {
        print("test");
      },
      child: Container(
        height: widget.size,
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(color: ColorConstant.whiteBlack30),
          )
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                width: 22,
                height: 22,
                decoration: const BoxDecoration(
                  color: ColorConstant.red50,
                  shape: BoxShape.circle
                ),
                alignment: Alignment.center,
                child: const Text(
                  "1", 
                  style: TextStyle(
                    fontFamily: AppFontStyle.font,
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w500
                  ),
                ),
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
                      text: "Nuttakit Pliankhunthud Tiew",
                      style: textStyle(false, ColorConstant.whiteBlack90, AppFontStyle.font)
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
                      text: "การฝึกงาน",
                      style: textStyle(false, ColorConstant.whiteBlack90, AppFontStyle.thaiFont)
                    ),
                    TextSpan(
                      text: " - aaaaaa aaaaa aaaaaa aaaaa aaaaaaa aaaaa aaaaaaa aaaaa aaaaaaaa aaaaaaaaa aaaaaa aaaaaa aaaaaa aaaaaaaa aaaaaaaaaaaaaaaaaa",
                      style: textStyle(false, ColorConstant.whiteBlack60, AppFontStyle.thaiFont)
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
                child: const Text(
                  "09:41 AM",
                  style: TextStyle(
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