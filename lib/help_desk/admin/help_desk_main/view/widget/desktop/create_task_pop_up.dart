import 'package:flutter/material.dart';
import 'package:senior_project/assets/color_constant.dart';

class CreateTaskPopup extends StatefulWidget {
  const CreateTaskPopup({super.key});

  @override
  State<CreateTaskPopup> createState() => _CreateTaskPopupState();
}

class _CreateTaskPopupState extends State<CreateTaskPopup> {
  // TODO set provider state
  static List<String> priority = ["Low", "Medium", "High", "Urgent"];
  static List<String> category = ["Test", "Cat_A", "Cat_B", "Cat_X"];
  String priorityValue = priority.first;
  String categoryValue = category.first;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      content: SizedBox(
        width: 1000,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 24),
              child: RichText(
                text: const TextSpan(
                  children: [
                    TextSpan(
                      text: "Create a task\n",
                      style: TextStyle(
                        fontFamily: ColorConstant.font,
                        fontWeight: FontWeight.w500,
                        fontSize: 28,
                        color: ColorConstant.whiteBlack80
                      )
                    ),
                    TextSpan(
                      text: "Fill in more information for create task in Help-Desk System.",
                      style: TextStyle(
                        fontFamily: ColorConstant.font,
                        fontWeight: FontWeight.w300,
                        fontSize: 18,
                        color: ColorConstant.whiteBlack60
                      )
                    )
                  ]
                ),
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
                        style: TextStyle(
                          fontFamily: ColorConstant.font,
                          fontWeight: FontWeight.w300,
                          fontSize: 24,
                          color: ColorConstant.whiteBlack80
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    fit: FlexFit.tight,
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(color: ColorConstant.whiteBlack40)
                      ),
                      padding: const EdgeInsets.fromLTRB(16, 12, 0, 12),
                      child: TextField(
                        decoration: const InputDecoration.collapsed(
                          hintText: "Ex. caption",
                          hintStyle: TextStyle(
                            fontFamily: ColorConstant.font,
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: ColorConstant.whiteBlack30,
                          )
                        ),
                        onChanged: (value) {
                          // TODO set title
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
                        style: TextStyle(
                          fontFamily: ColorConstant.font,
                          fontWeight: FontWeight.w300,
                          fontSize: 24,
                          color: ColorConstant.whiteBlack80
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    fit: FlexFit.tight,
                    child: Container(
                      height: 45,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(color: ColorConstant.whiteBlack40)
                      ),
                      padding: const EdgeInsets.fromLTRB(16, 12, 8, 12),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton(
                          value: priorityValue, // TODO listen to priority state
                          style: const TextStyle(
                            fontFamily: ColorConstant.font,
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                            color: ColorConstant.whiteBlack60
                          ),
                          items: priority.map<DropdownMenuItem<String>>((value) {
                            return DropdownMenuItem(
                              value: value,
                              child: Text(value)
                            );
                          }).toList(), 
                          onChanged: (value) {
                            // TODO set priority state
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
                        style: TextStyle(
                          fontFamily: ColorConstant.font,
                          fontWeight: FontWeight.w300,
                          fontSize: 24,
                          color: ColorConstant.whiteBlack80
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    fit: FlexFit.tight,
                    child: Container(
                      height: 45,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(color: ColorConstant.whiteBlack40)
                      ),
                      padding: const EdgeInsets.fromLTRB(16, 12, 8, 12),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton(
                          value: categoryValue, // TODO listen to category state
                          style: const TextStyle(
                            fontFamily: ColorConstant.font,
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                            color: ColorConstant.whiteBlack60
                          ),
                          items: category.map<DropdownMenuItem<String>>((value) {
                            return DropdownMenuItem(
                              value: value,
                              child: Text(value)
                            );
                          }).toList(), 
                          onChanged: (value) {
                            // TODO set priority state
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
                        style: TextStyle(
                          fontFamily: ColorConstant.font,
                          fontWeight: FontWeight.w300,
                          fontSize: 24,
                          color: ColorConstant.whiteBlack80
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    fit: FlexFit.tight,
                    child: Container(
                      height: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(color: ColorConstant.whiteBlack40)
                      ),
                      padding: const EdgeInsets.fromLTRB(16, 12, 0, 12),
                      child: TextField(
                        keyboardType:  TextInputType.multiline,
                        maxLines: null,
                        decoration: const InputDecoration.collapsed(
                          hintText: "Fill your information...",
                          hintStyle: TextStyle(
                            fontFamily: ColorConstant.font,
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: ColorConstant.whiteBlack30,
                          )
                        ),
                        onChanged: (value) {
                          // TODO set detail
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
                          backgroundColor: MaterialStateProperty.all(Colors.white),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                              side: const BorderSide(
                                color: ColorConstant.orange40
                              )
                            )
                          )
                        ),
                        child: const Text(
                          "Cancle",
                          style: TextStyle(
                            fontFamily: ColorConstant.font,
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                            color: ColorConstant.orange40
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: SizedBox(
                    height: 40,
                    child: TextButton(
                      onPressed: () {
                        // TODO create task logic
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(ColorConstant.orange40),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                            side: const BorderSide(
                              color: ColorConstant.orange40
                            )
                          )
                        )
                      ),
                      child: const Text(
                        "Confirm",
                        style: TextStyle(
                          fontFamily: ColorConstant.font,
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                          color: Colors.white
                        ),
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