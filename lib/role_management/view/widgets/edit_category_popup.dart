// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senior_project/assets/color_constant.dart';
import 'package:senior_project/assets/font_style.dart';
import 'package:senior_project/core/template/template_desktop/view/widget/desktop/confirmation_popup.dart';
import 'package:senior_project/core/view_model/app_view_model.dart';
import 'package:senior_project/role_management/view/role_management_view.dart';
import 'package:senior_project/role_management/view_model/role_management_view_model.dart';

class EditCategoryPopup extends StatefulWidget {
  final String title;
  final String detail;
  const EditCategoryPopup({super.key, required this.title, required this.detail});

  @override
  State<EditCategoryPopup> createState() => _EditCategoryPopupState();
}

class _EditCategoryPopupState extends State<EditCategoryPopup> {
  TextEditingController titleController = TextEditingController();
  TextEditingController detailController = TextEditingController();
  bool isTitleEmpty = false;
  bool isDetailEmpty = false;

  @override
  void initState() {
    titleController.text = widget.title;
    detailController.text = widget.detail;  
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    bool isAdmin = context.watch<AppViewModel>().app.getUser.getRole == 0;

    return AlertDialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      content: SizedBox(
        width: 647,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RichText(
                      text: const TextSpan(
                        children: [
                          TextSpan(
                            text: "Edit Category",
                            style: TextStyle(
                              fontWeight: AppFontWeight.medium,
                              fontSize: 28,
                              color: ColorConstant.orange70
                            )
                          ),
                          TextSpan(
                            text: "\nEdit detail of category",
                            style: TextStyle(
                              fontWeight: AppFontWeight.light,
                              fontSize: 18,
                              color: ColorConstant.whiteBlack60
                            )
                          ),
                        ]
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        showDialog(
                          context: context, 
                          builder: (context) {
                            return ConfirmationPopup(
                              title: "Are you sure you want to Delete?", 
                              detail: "", 
                              widget: null, 
                              onCancel: () {
                                Navigator.pop(context);
                              }, 
                              onConfirm: () async {
                                await context.read<RoleManagementViewModel>().deleteCategory(
                                  widget.title
                                );
                                Navigator.pushAndRemoveUntil(
                                  context, 
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return RoleManagementView(isAdmin: isAdmin);
                                    }
                                  ), 
                                  (route) => false
                                );
                              }
                            );
                          }
                        );
                      },
                      child: Row(
                        children: const [
                          Padding(
                            padding: EdgeInsets.only(right: 8.0),
                            child: Icon(Icons.delete_rounded),
                          ),
                          Text(
                            "ลบข้อมูล",
                            style: TextStyle(
                              fontWeight: AppFontWeight.regular,
                              fontSize: 16,
                              color: ColorConstant.whiteBlack60
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(bottom: 8.0),
                              child: Text(
                                "Category Name",
                                style: TextStyle(
                                  fontWeight: AppFontWeight.regular,
                                  fontSize: 20,
                                  color: ColorConstant.whiteBlack80
                                ),
                              ),
                            ),
                            Container(
                              height: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                border: Border.all(
                                    color: isTitleEmpty
                                        ? ColorConstant.red50
                                        : ColorConstant.whiteBlack40
                                )
                              ),
                              child: TextField(
                                maxLength: 25,
                                controller: titleController,
                                style: const TextStyle(
                                  fontWeight: AppFontWeight.regular,
                                  fontSize: 16,
                                  color: ColorConstant.whiteBlack90
                                ),
                                decoration: const InputDecoration(
                                  counterText: "",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.zero,
                                    borderSide: BorderSide.none,
                                    gapPadding: 0
                                  )
                                ),
                                onTap: () {
                                  setState(() {
                                    isTitleEmpty = false;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                              padding: EdgeInsets.only(bottom: 8.0),
                              child: Text(
                                "Description",
                                style: TextStyle(
                                  fontWeight: AppFontWeight.regular,
                                  fontSize: 20,
                                  color: ColorConstant.whiteBlack80
                                ),
                              ),
                            ),
                          Container(
                            height: 100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(
                                  color: isDetailEmpty
                                      ? ColorConstant.red50
                                      : ColorConstant.whiteBlack40
                              )
                            ),
                            child: TextField(
                              maxLength: 150,
                              keyboardType: TextInputType.multiline,
                              maxLines: null,
                              controller: detailController,
                              style: const TextStyle(
                                fontWeight: AppFontWeight.regular,
                                fontSize: 16,
                                color: ColorConstant.whiteBlack90
                              ),
                              decoration: const InputDecoration(
                                counterText: "",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.zero,
                                  borderSide: BorderSide.none,
                                  gapPadding: 0
                                )
                              ),
                              onTap: () {
                                setState(() {
                                  isDetailEmpty = false;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 40,
                  width: double.infinity,
                  child: Row(
                    children: [
                      Flexible(
                        fit: FlexFit.tight,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 16),
                          child: SizedBox(
                            height: 40,
                            child: TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                  Colors.white
                                ),
                                shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    side: const BorderSide(color: ColorConstant.orange50)
                                  )
                                ),
                              ),
                              child: const Text(
                                "Cancle",
                                style: TextStyle(
                                  fontWeight: AppFontWeight.bold,
                                  fontSize: 16,
                                  color: ColorConstant.orange50
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Flexible(
                        fit: FlexFit.tight,
                        child: SizedBox(
                          height: 40,
                          child: TextButton(
                            onPressed: () {
                              if (titleController.text.isEmpty) {
                                setState(() {
                                  isTitleEmpty = true;
                                });
                              }
                              if (detailController.text.isEmpty) {
                                setState(() {
                                  isDetailEmpty = true;
                                });
                              }
                              if (!isDetailEmpty && !isTitleEmpty) {
                                showDialog(
                                  context: context, 
                                  builder: (context) {
                                    return ConfirmationPopup(
                                      title: "Are you sure you want to save result?", 
                                      detail: "", 
                                      widget: null, 
                                      onCancel: () {
                                        Navigator.pop(context);
                                      }, 
                                      onConfirm: () async {
                                        await context.read<RoleManagementViewModel>().editCategory(
                                          widget.title, 
                                          titleController.text, 
                                          detailController.text
                                        );
                                        Navigator.pushAndRemoveUntil(
                                          context, 
                                          MaterialPageRoute(
                                            builder: (context) {
                                              return RoleManagementView(isAdmin: isAdmin);
                                            }
                                          ), 
                                          (route) => false
                                        );
                                      }
                                    );
                                  }
                                );
                              }
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                ColorConstant.orange50
                              ),
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                )
                              ),
                            ),
                            child: const Text(
                              "Save",
                              style: TextStyle(
                                fontWeight: AppFontWeight.bold,
                                fontSize: 16,
                                color: Colors.white
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
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