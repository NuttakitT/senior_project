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

    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: ColorConstant.white,
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
                      color: ColorConstant.whiteBlack80,
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
                      color: ColorConstant.whiteBlack70, fontSize: 16),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        Builder(builder: ((context) {
          if (widget.isAdmin) {
            return Column(
              children: [
                Row(
                  children: [
                    Flexible(
                      fit: FlexFit.tight,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          decoration: BoxDecoration(
                              color: ColorConstant.white,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                  color: ColorConstant.whiteBlack40)),
                          child: DropdownButton(
                            hint: const Text(
                              "Priority",
                              style: TextStyle(
                                  color: ColorConstant.whiteBlack70,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600),
                            ),
                            alignment: AlignmentDirectional.center,
                            isExpanded: true,
                            value: dropdownValuePriority,
                            icon: const Icon(
                              Icons.expand_more_rounded,
                              color: ColorConstant.whiteBlack70,
                            ),
                            underline: Container(
                              height: 0,
                            ),
                            elevation: 16,
                            style: const TextStyle(
                                color: ColorConstant.whiteBlack70),
                            onChanged: (String? value) {
                              setState(() {
                                dropdownValuePriority = value!;
                              });
                            },
                            items: priority
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ),
                    Flexible(
                      fit: FlexFit.tight,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          decoration: BoxDecoration(
                              color: ColorConstant.white,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                  color: ColorConstant.whiteBlack40)),
                          child: DropdownButton(
                            hint: const Text(
                              "Status",
                              style: TextStyle(
                                  color: ColorConstant.whiteBlack70,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600),
                            ),
                            alignment: AlignmentDirectional.center,
                            isExpanded: true,
                            value: dropdownValueStatus,
                            icon: const Icon(
                              Icons.expand_more_rounded,
                              color: ColorConstant.whiteBlack70,
                            ),
                            underline: Container(
                              height: 0,
                            ),
                            elevation: 16,
                            style: const TextStyle(
                                color: ColorConstant.whiteBlack70),
                            onChanged: (String? value) {
                              setState(() {
                                dropdownValueStatus = value!;
                              });
                            },
                            items: status
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: InkWell(
                    child: Container(
                      height: 40,
                      alignment: Alignment.center,
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                          color: ColorConstant.orange40,
                          borderRadius: BorderRadius.circular(16)),
                      child: const Text(
                        "End Task",
                        style: TextStyle(
                            color: ColorConstant.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    onTap: () {
                      //TODO End-task change state to "closed"
                    },
                  ),
                )
              ],
            );
          } else {
            return Container();
          }
        }))
      ],
    );
  }
}
