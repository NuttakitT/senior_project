// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senior_project/assets/color_constant.dart';
import 'package:senior_project/assets/font_style.dart';
import 'package:senior_project/core/view_model/app_view_model.dart';
import 'package:senior_project/role_management/model/role_management_model.dart';
import 'package:senior_project/role_management/view/role_management_view.dart';
import 'package:senior_project/role_management/view_model/role_management_view_model.dart';

class AddCategoryPopup extends StatefulWidget {
  const AddCategoryPopup({super.key});

  @override
  State<AddCategoryPopup> createState() => _AddCategoryPopupState();
}

class _AddCategoryPopupState extends State<AddCategoryPopup> {
  TextEditingController topicController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  bool isTopicEmpty = false;
  bool isDescriptionEmpty = false;

  Color setColorOfTextField(bool emptyFlag) {
    if (!emptyFlag) {
      return ColorConstant.whiteBlack40;
    }
    return ColorConstant.red40;
  }

  @override
  Widget build(BuildContext context) {
    bool isAdmin = context.watch<AppViewModel>().app.getUser.getRole == 0;

    return AlertDialog(
      backgroundColor: ColorConstant.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      content: SizedBox(
        width: 1000,
        height: 400,
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  DefaultTextStyle(
                      style: AppFontStyle.orange70Md28,
                      child: Text(Consts.addCategory)),
                  const Spacer(),
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.close))
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            DefaultTextStyle(
                                style: AppFontStyle.wb80R20,
                                child: Text(Consts.topicNameLabel)),
                            const SizedBox(height: 8),
                            Container(
                              height: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                border: Border.all(
                                    color: setColorOfTextField(isTopicEmpty)),
                              ),
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: TextField(
                                    controller: topicController,
                                    decoration: const InputDecoration.collapsed(
                                        hintText: "CPE"),
                                    // onChanged: (value) {
                                    //   topic = value;
                                    // },
                                    onTap: () {
                                      setState(() {
                                        isTopicEmpty = false;
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ]),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            DefaultTextStyle(
                                style: AppFontStyle.wb80R20,
                                child: Text(Consts.descriptionLabel)),
                            const SizedBox(height: 8),
                            Container(
                              // height: 190,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                border: Border.all(
                                    color: setColorOfTextField(
                                        isDescriptionEmpty)),
                              ),
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 8.0, left: 8.0),
                                  child: TextField(
                                    maxLines: 5,
                                    controller: descriptionController,
                                    decoration: const InputDecoration.collapsed(
                                        hintText: "CPE is great."),
                                    // onChanged: (value) {
                                    //   topic = value;
                                    // },
                                    onTap: () {
                                      setState(() {
                                        isDescriptionEmpty = false;
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ]),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const SizedBox(width: 8),
                  SizedBox(
                    height: 40,
                    width: 186,
                    child: TextButton(
                      onPressed: () async {
                        if (topicController.text.isEmpty) {
                          setState(() {
                            isTopicEmpty = true;
                          });
                        }
                        if (descriptionController.text.isEmpty) {
                          setState(() {
                            isDescriptionEmpty = true;
                          });
                        }
                        if (!isTopicEmpty && !isDescriptionEmpty) {
                          final request = AddCategoryRequest(
                              categoryName: topicController.text,
                              description: descriptionController.text);
                          await context
                              .read<RoleManagementViewModel>()
                              .addCategory(request);
                          Navigator.pushAndRemoveUntil(
                            context, 
                            MaterialPageRoute(builder: (context) {
                              return RoleManagementView(isAdmin: isAdmin);
                            }), 
                            (route) => false
                          );
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
                      child: Text(
                        Consts.confirm,
                        style: AppFontStyle.whiteB16,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8)
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Consts {
  static String addCategory = "Add Category";
  static String topicNameLabel = "Topic name";
  static String descriptionLabel = "Description";
  static String confirm = "Confirm";
}
