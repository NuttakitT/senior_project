import 'package:flutter/material.dart';
import 'package:senior_project/assets/color_constant.dart';
import 'package:senior_project/assets/font_style.dart';
import 'package:senior_project/statistic/model/statistic_model.dart';

class ResponseTime extends StatefulWidget {
  final SingleResultChart data;
  const ResponseTime({super.key, required this.data});

  @override
  State<ResponseTime> createState() => _ResponseTimeState();
}

class _ResponseTimeState extends State<ResponseTime> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: 1,
        child: Container(
            height: 180,
            decoration: BoxDecoration(
                color: ColorConstant.white,
                borderRadius: BorderRadius.circular(8.0)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Average Response time",
                    style: AppFontStyle.blackMd18,
                  ),
                  Text(widget.data.data.toString(),
                      style: AppFontStyle.blackMd38),
                  Text(
                    widget.data.detail,
                    style: AppFontStyle.wb60L14,
                  ),
                ],
              ),
            )));
  }
}
