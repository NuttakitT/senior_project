import 'package:flutter/material.dart';
import 'package:senior_project/assets/color_constant.dart';
import 'package:senior_project/assets/font_style.dart';
import 'package:senior_project/help_desk/help_desk_main/view/widget/desktop/content.dart';
import 'package:senior_project/help_desk/help_desk_reply/view/widget/desktop/body_reply_desktop.dart';

class Body extends StatefulWidget {
  final bool isAdmin;
  const Body({super.key, required this.isAdmin});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  ScrollController controller = ScrollController();
  static List<String> priority = ["Low", "Medium", "High", "Urgent"];
  static List<String> status = ["Not Start", "Pending", "Complete"];
  static List<String> admin = ["Admin1", "Admin2", "Admin3"];
  String priorityValue = priority[0];
  String stausValue = status[0];
  String adminValue = admin[0];

  Widget _iconLoader(bool isFirst) {
    return Row(
      children: [
        IconButton(
          onPressed: () {
            // TODO go back
          }, 
          icon: const Icon(Icons.keyboard_arrow_left_rounded)
        ),
        IconButton(
          onPressed: () {
            // TODO go back
          }, 
          icon: const Icon(Icons.keyboard_double_arrow_left_rounded)
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            "1-5 of 5",
            style: TextStyle(
              fontFamily: AppFontStyle.font,
              fontWeight: FontWeight.normal,
              fontSize: 16,
              color: ColorConstant.whiteBlack70
            ),
          ),
        ),
        IconButton(
          onPressed: () {
            // TODO load more
          }, 
          icon: const Icon(Icons.keyboard_arrow_right_rounded)
        ),
        IconButton(
          onPressed: () {
            // TODO load more
          }, 
          icon: const Icon(Icons.keyboard_double_arrow_right_rounded)
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    bool isShowMesg = true;
    double contentSize = 56;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                height: 73,
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: ColorConstant.whiteBlack40)
                  )
                ),
              ),
              Container(
                height: 72,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                ),
                padding: const EdgeInsets.only(left: 10, right: 16),
                alignment: AlignmentDirectional.center,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 40),
                      child: IconButton(
                        onPressed: () {
                          // TODO refresh
                        },
                        icon: Icon(
                          isShowMesg 
                          ?  Icons.arrow_back_rounded
                          : Icons.refresh_rounded, 
                          color: ColorConstant.whiteBlack70,
                        ),
                      ),
                    ),
                    Builder(
                      builder: (context) {
                        if (isShowMesg && widget.isAdmin) {
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
                                      value: priorityValue,
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
                                      onChanged: (value) {
                                        setState(() {
                                          priorityValue = value!;
                                        });
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
                                      value: stausValue,
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
                                      onChanged: (value) {
                                        setState(() {
                                          stausValue = value!;
                                        });
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
                        return Container();
                      }
                    ),
                    const Spacer(),
                    _iconLoader(false)
                  ],
                ),
              ),
            ]
          ),
          Builder(
            builder: (context) {
              if (isShowMesg) {
                return ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: screenHeight < 500 ? 500 : screenHeight - 300
                  ),
                  child: Scrollbar(
                    controller: controller,
                    thumbVisibility: true,
                    child: SingleChildScrollView(
                      controller: controller,
                      scrollDirection: Axis.vertical,
                      child: const BodyReplyDesktop()
                    ),
                  )
                );
              }
              return ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: screenHeight < 500 ? 500 : screenHeight - 376
                ),
                child: Scrollbar(
                  controller: controller,
                  thumbVisibility: true,
                  child: SingleChildScrollView(
                    controller: controller,
                    scrollDirection: Axis.vertical,
                    child: Column(
                      children: [
                        Content(size: contentSize),
                        Content(size: contentSize),
                        Content(size: contentSize),
                        Content(size: contentSize),
                        Content(size: contentSize),
                        Content(size: contentSize),
                        Content(size: contentSize),
                        Content(size: contentSize),
                        Content(size: contentSize),
                        Content(size: contentSize),
                        Content(size: contentSize),
                        Content(size: contentSize),
                        Content(size: contentSize),
                      ],
                    ),
                  ),
                ),
              );
            }
          ),
          Builder(
            builder: (context) {
              if (!isShowMesg) {
                return Container(
                  height: 56,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(16),
                      bottomRight: Radius.circular(16),
                    )
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      _iconLoader(false),
                    ],
                  )
                );
              }
              return Container();
            }
          )
        ],
      )
    );
  }
}