import 'package:flutter/material.dart';
import 'package:senior_project/assets/color_constant.dart';
import 'package:senior_project/help_desk/help_desk_main/view/widget/create_task_pop_up.dart';
import 'package:senior_project/help_desk/help_desk_main/view/admin/widget/desktop/task_table.dart';

class DesktopWidget extends StatelessWidget {
  const DesktopWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(
        maxWidth: 1500
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: Column(
        children: [
          Row(
            children: [
              const Text(
                "HelpDesk",
                style: TextStyle(
                  fontFamily: ColorConstant.font,
                  fontWeight: FontWeight.w500,
                  fontSize: 32,
                  color: ColorConstant.whiteBlack80
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Container(
                    height: 1,
                    color: ColorConstant.whiteBlack20,
                  ),
                ),
              ),
              SizedBox(
                height: 40,
                child: TextButton(
                  onPressed: () {
                    showDialog(
                      context: context, 
                      builder: (context) {
                        return const CreateTaskPopup();
                      }
                    );
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(ColorConstant.orange40),
                    side: MaterialStateProperty.all(
                      const BorderSide(color: ColorConstant.orange40)
                    ),
                    shape: MaterialStateProperty.all(
                      const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8))
                      )
                    )
                  ),
                  child: Row(
                    children: const [
                      Icon(Icons.add, color: Colors.white,),
                      Text(
                        "Create task",
                        style: TextStyle(
                          fontFamily: ColorConstant.font,
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                          color: Colors.white
                        ),
                      )
                    ],
                  )
                ),
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.only(top: 33),
            child: TaskTable(),
          ),
        ],
      ),
    );
  }
}