import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senior_project/assets/color_constant.dart';
import 'package:senior_project/help_desk/help_desk_reply/view_model/reply_channel_view_model.dart';

const List<String> priority = <String>['Urgent', 'High', 'Medium', 'Low'];
const List<String> status = <String>['Not start', 'Progress', 'Closed'];

class DescriptionDesktop extends StatefulWidget {
  final bool isAdmin;
  const DescriptionDesktop({super.key, required this.isAdmin});

  @override
  State<DescriptionDesktop> createState() => _DescriptionDesktopState();
}

class _DescriptionDesktopState extends State<DescriptionDesktop> {
  String dropdownValuePriority = priority.first;
  String dropdownValueStatus = status.first;
  @override
  Widget build(BuildContext context) {
    String taskDetail = context.watch<ReplyChannelViewModel>().getTaskData["detail"];
    String category = context.watch<ReplyChannelViewModel>().getTaskData["category"];

    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: ColorConstant.whiteBlack5,
              boxShadow: [
                BoxShadow(
                  offset: const Offset(5, 5),
                  color: ColorConstant.black.withOpacity(0.05),
                  blurRadius: 10,
                ),
              ]),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                alignment: Alignment.centerLeft,
                child: const Text(
                  "Description",
                  style: TextStyle(
                      color: ColorConstant.whiteBlack90,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                child: Text(
                  taskDetail,
                  style: const TextStyle(
                    color: ColorConstant.whiteBlack70, 
                    fontSize: 16,
                    fontWeight: FontWeight.w400
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 16),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: ColorConstant.whiteBlack5,
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(5, 5),
                    color: ColorConstant.black.withOpacity(0.05),
                    blurRadius: 10,
                  ),
                ]),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    "Category",
                    style: TextStyle(
                        color: ColorConstant.whiteBlack90,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                  child: Text(
                    category,
                    style: const TextStyle(
                      color: ColorConstant.whiteBlack70, 
                      fontSize: 16,
                      fontWeight: FontWeight.w400
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
