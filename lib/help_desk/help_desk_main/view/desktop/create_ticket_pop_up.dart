// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senior_project/assets/color_constant.dart';
import 'package:senior_project/help_desk/help_desk_main/view_model/help_desk_view_model.dart';
import 'package:senior_project/assets/font_style.dart';

class CreateTicketPopup extends StatefulWidget {
  const CreateTicketPopup({super.key});

  @override
  State<CreateTicketPopup> createState() => _CreateTicketPopupState();
}

class _CreateTicketPopupState extends State<CreateTicketPopup> {
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
    return AlertDialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      content: SizedBox(
        width: 1000,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 24),
              child: RichText(
                text: const TextSpan(children: [
                  TextSpan(
                      text: "Create a task\n", style: AppFontStyle.wb80Md28),
                  TextSpan(
                      text:
                          "Fill in more information for create task in Help-Desk System.",
                      style: AppFontStyle.wb60L18)
                ]),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(right: 24),
                    child: SizedBox(
                      width: 100,
                      child: Text(
                        "Title",
                        style: AppFontStyle.wb80L24,
                      ),
                    ),
                  ),
                  Flexible(
                    fit: FlexFit.tight,
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(color: isTitleEmpty 
                        ? ColorConstant.red50 
                        : ColorConstant.whiteBlack40)
                      ),
                      padding: const EdgeInsets.fromLTRB(16, 12, 0, 12),
                      child: TextField(
                        decoration: const InputDecoration.collapsed(
                            hintText: "Ex. caption",
                            hintStyle: AppFontStyle.wb30R14),
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
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(right: 24),
                    child: SizedBox(
                      width: 100,
                      child: Text(
                        "Priority",
                        style: AppFontStyle.wb80L24,
                      ),
                    ),
                  ),
                  Flexible(
                    fit: FlexFit.tight,
                    child: Container(
                      height: 45,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          border:
                              Border.all(color: ColorConstant.whiteBlack40)),
                      padding: const EdgeInsets.fromLTRB(16, 12, 8, 12),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton(
                          value: priorityValue,
                          style: AppFontStyle.wb60R16,
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
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(right: 24),
                    child: SizedBox(
                      width: 100,
                      child: Text(
                        "Category",
                        style: AppFontStyle.wb80L24,
                      ),
                    ),
                  ),
                  Flexible(
                    fit: FlexFit.tight,
                    child: Container(
                      height: 45,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          border:
                              Border.all(color: ColorConstant.whiteBlack40)),
                      padding: const EdgeInsets.fromLTRB(16, 12, 8, 12),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton(
                          value: categoryValue, 
                          style: AppFontStyle.wb60R16,
                          items:
                              category.map<DropdownMenuItem<String>>((value) {
                            return DropdownMenuItem(
                                value: value, child: Text(value));
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
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 24),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(right: 24),
                    child: SizedBox(
                      width: 100,
                      child: Text(
                        "Detail",
                        style: AppFontStyle.wb80L24,
                      ),
                    ),
                  ),
                  Flexible(
                    fit: FlexFit.tight,
                    child: Container(
                      height: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(color: isDetailEmpty 
                        ? ColorConstant.red50 
                        : ColorConstant.whiteBlack40)
                      ),
                      padding: const EdgeInsets.fromLTRB(16, 12, 0, 12),
                      child: TextField(
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        decoration: const InputDecoration.collapsed(
                            hintText: "Fill your information...",
                            hintStyle: AppFontStyle.wb30R14),
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
                ],
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 16),
                    child: SizedBox(
                      height: 40,
                      child: TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.white),
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    side: const BorderSide(
                                        color: ColorConstant.orange40)))),
                        child: const Text(
                          "Cancle",
                          style: AppFontStyle.orange40B16,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: SizedBox(
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
                          await context.read<HelpDeskViewModel>().createTask(title, detail, priorityIndex, categoryValue);
                          Navigator.pop(context);
                        }
                      },
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(ColorConstant.orange40),
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  side: const BorderSide(
                                      color: ColorConstant.orange40)))),
                      child: const Text(
                        "Confirm",
                        style: AppFontStyle.whiteB16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
