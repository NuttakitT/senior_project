// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senior_project/assets/color_constant.dart';
import 'package:senior_project/assets/font_style.dart';
import 'package:senior_project/core/template/template_desktop/view/widget/desktop/confirmation_popup.dart';
import 'package:senior_project/core/template/template_mobile/view/template_menu_mobile.dart';
import 'package:senior_project/help_desk/help_desk_main/view/page/help_desk_main_view.dart';
import 'package:senior_project/help_desk/help_desk_main/view/widget/priority_icon.dart';
import 'package:senior_project/help_desk/help_desk_main/view_model/help_desk_view_model.dart';

class CreateTask extends StatefulWidget {
  final bool isAdmin;
  const CreateTask({super.key, required this.isAdmin});

  @override
  State<CreateTask> createState() => _CreateTaskState();
}

class _CreateTaskState extends State<CreateTask> {
  final TextStyle _titleStyle = AppFontStyle.wb80R20;
  static List<String> priority = ["Low", "Medium", "High", "Urgent"];
  late List<String> category;
  String priorityValue = priority.first;
  late String categoryValue;
  String title = "";
  String detail = "";
  bool isTitleEmpty = false;
  bool isDetailEmpty = false;

  @override
  void initState() {
    category = context.read<HelpDeskViewModel>().getCategory;
    categoryValue = category.first;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TemplateMenuMobile(
      content:
          // SafeArea(child:
          Container(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        color: Colors.white,
        padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 2),
              child: Text(
                "Create tasks ${widget.isAdmin ? "" : "to admin"}",
                style: AppFontStyle.wb80R24,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 24),
              child: Text(
                "Fill in more information ${widget.isAdmin ? "" : "for admin to help you"}",
                style: AppFontStyle.wb60L14,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Text(
                "Title",
                style: _titleStyle,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Container(
                height: 40,
                decoration: BoxDecoration(
                    border: Border.all(
                        color: isTitleEmpty
                            ? ColorConstant.red50
                            : ColorConstant.whiteBlack20),
                    borderRadius: BorderRadius.circular(4)),
                alignment: AlignmentDirectional.centerStart,
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: TextField(
                  decoration: const InputDecoration.collapsed(
                      hintText: "Ex. caption", hintStyle: AppFontStyle.wb30R14),
                  onChanged: (value) {
                    title = value;
                  },
                  onTap: () {
                    setState(() {
                      isTitleEmpty = false;
                    });
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Text(
                "Priority",
                style: _titleStyle,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Container(
                height: 45,
                width: double.infinity,
                decoration: BoxDecoration(
                    border: Border.all(color: ColorConstant.whiteBlack20),
                    borderRadius: BorderRadius.circular(4)),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Row(
                  children: [
                    Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: Icon(
                          PriorityIcon.getIcon(priority.indexOf(priorityValue)),
                          size: 20,
                        )),
                    Expanded(
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton(
                          value: priorityValue,
                          style: AppFontStyle.wb80R16,
                          items: priority.map<DropdownMenuItem>((value) {
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
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Text(
                "Category",
                style: _titleStyle,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Container(
                height: 45,
                width: double.infinity,
                decoration: BoxDecoration(
                    border: Border.all(color: ColorConstant.whiteBlack20),
                    borderRadius: BorderRadius.circular(4)),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton(
                    value: categoryValue,
                    style: AppFontStyle.wb80R16,
                    items: category.map<DropdownMenuItem>((value) {
                      return DropdownMenuItem(value: value, child: Text(value));
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        categoryValue = value!;
                      });
                    },
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Text(
                "Detail",
                style: _titleStyle,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Container(
                height: 100,
                decoration: BoxDecoration(
                    border: Border.all(
                        color: isTitleEmpty
                            ? ColorConstant.red50
                            : ColorConstant.whiteBlack20),
                    borderRadius: BorderRadius.circular(4)),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: TextField(
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  decoration: const InputDecoration.collapsed(
                      hintText: "Ex. caption", hintStyle: AppFontStyle.wb30R14),
                  onChanged: (value) {
                    detail = value;
                  },
                  onTap: () {
                    setState(() {
                      isDetailEmpty = false;
                    });
                  },
                ),
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: SizedBox(
                width: double.infinity,
                height: 40,
                child: TextButton(
                  onPressed: () async {
                    if (title.isEmpty) {
                      setState(() {
                        isTitleEmpty = true;
                      });
                    }
                    if (detail.isEmpty) {
                      setState(() {
                        isDetailEmpty = true;
                      });
                    }
                    if (title.isNotEmpty && detail.isNotEmpty) {
                      int priorityIndex = priority.indexOf(priorityValue);
                      showDialog(
                          context: context,
                          builder: (context) {
                            return ConfirmationPopup(
                                title:
                                    "Are you sure you want to create a ticket?",
                                detail:
                                    " The ticket will be automatically sent to IT support.",
                                widget: null,
                                onCancel: () {
                                  Navigator.pop(context);
                                },
                                onConfirm: () async {
                                  await context
                                      .read<HelpDeskViewModel>()
                                      .createTask(title, detail, priorityIndex,
                                          categoryValue, false);
                                  context
                                      .read<HelpDeskViewModel>()
                                      .clearModel();
                                  context
                                      .read<HelpDeskViewModel>()
                                      .setIsSafeLoad = true;
                                  Navigator.pushAndRemoveUntil(context,
                                      MaterialPageRoute(builder: (context) {
                                    return HelpDeskMainView(
                                        isAdmin: widget.isAdmin);
                                  }), (route) => false);
                                });
                          });
                    }
                  },
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(ColorConstant.orange40),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)))),
                  child: const Text(
                    "Confirm",
                    style: AppFontStyle.whiteB16,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              height: 40,
              child: TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.white),
                    side: MaterialStateProperty.all(
                        const BorderSide(color: ColorConstant.orange40)),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)))),
                child: const Text(
                  "Back",
                  style: AppFontStyle.orange40B16,
                ),
              ),
            )
          ],
        ),
      ),
    );
    // );
  }
}
