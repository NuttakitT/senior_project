import 'package:flutter/material.dart';
import 'package:senior_project/assets/color_constant.dart';
import 'package:senior_project/help_desk/help_desk_main/view/widget/priority_icon.dart';

class CreateTask extends StatefulWidget {
  final bool isAdmin;
  const CreateTask({super.key, required this.isAdmin});

  @override
  State<CreateTask> createState() => _CreateTaskState();
}

class _CreateTaskState extends State<CreateTask> { 
  final TextStyle _titleStyle = const TextStyle(
    fontFamily: ColorConstant.font,
    fontWeight: FontWeight.w400,
    fontSize: 20,
    color: ColorConstant.whiteBlack80
  );
  // TODO set provider state
  static List<String> priority = ["Low", "Medium", "High", "Urgent"];
  static List<String> category = ["Test", "Cat_A", "Cat_B", "Cat_X"];
  String priorityValue = priority.first;
  String categoryValue = category.first;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
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
                  style: const TextStyle(
                    fontFamily: ColorConstant.font,
                    fontWeight: FontWeight.w500,
                    fontSize: 24,
                    color: ColorConstant.whiteBlack80
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 24),
                child: Text(
                  "Fill in more information ${widget.isAdmin ? "" : "for admin to help you"}",
                  style: const TextStyle(
                    fontFamily: ColorConstant.font,
                    fontWeight: FontWeight.w300,
                    fontSize: 14,
                    color: ColorConstant.whiteBlack60
                  ),
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
                    border: Border.all(color: ColorConstant.whiteBlack20),
                    borderRadius: BorderRadius.circular(4)
                  ),
                  alignment: AlignmentDirectional.centerStart,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: TextField(
                    decoration: const InputDecoration.collapsed(
                      hintText: "Ex. caption",
                      hintStyle: TextStyle(
                        fontFamily: ColorConstant.font,
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: ColorConstant.whiteBlack30
                      )
                    ),
                    onChanged: (value) {
                      // TODO get title
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
                    borderRadius: BorderRadius.circular(4)
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: Icon(
                          // TODO listen to state
                          PriorityIcon.getIcon(priority.indexOf(priorityValue)), 
                          size: 20,
                        )
                      ),
                      Expanded(
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                            value: priorityValue, // TODO listen to state
                            style: const TextStyle(
                              fontFamily: ColorConstant.font,
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                              color: ColorConstant.whiteBlack80
                            ),
                            items: priority.map<DropdownMenuItem>((value) {
                              return DropdownMenuItem(
                                value: value,
                                child: Text(value)
                              );
                            }).toList(), 
                            onChanged: (value) {
                              // TODO set state
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
                    borderRadius: BorderRadius.circular(4)
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton(
                      value: categoryValue, // TODO listen to state
                      style: const TextStyle(
                        fontFamily: ColorConstant.font,
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        color: ColorConstant.whiteBlack80
                      ),
                      items: category.map<DropdownMenuItem>((value) {
                        return DropdownMenuItem(
                          value: value,
                          child: Text(value)
                        );
                      }).toList(), 
                      onChanged: (value) {
                        // TODO set state
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
                    border: Border.all(color: ColorConstant.whiteBlack20),
                    borderRadius: BorderRadius.circular(4)
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: TextField(
                    keyboardType:  TextInputType.multiline,
                    maxLines: null,
                    decoration: const InputDecoration.collapsed(
                      hintText: "Ex. caption",
                      hintStyle: TextStyle(
                        fontFamily: ColorConstant.font,
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: ColorConstant.whiteBlack30
                      )
                    ),
                    onChanged: (value) {
                      // TODO get title
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
                    onPressed: () {
                      // TODO confirm logic
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        ColorConstant.orange40
                      ),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)
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
              SizedBox(
                width: double.infinity,
                height: 40,
                child: TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                      Colors.white
                    ),
                    side: MaterialStateProperty.all(
                      const BorderSide(color: ColorConstant.orange40)
                    ),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)
                      )
                    )
                  ),
                  child: const Text(
                    "Back",
                    style: TextStyle(
                      fontFamily: ColorConstant.font,
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                      color: ColorConstant.orange40
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