import 'package:flutter/material.dart';
import 'package:senior_project/assets/color_constant.dart';
import 'package:senior_project/assets/font_style.dart';

class HeaderTable {
  static const _headerTextStyle = AppFontStyle.whiteB18;

  static Widget widget() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      color: ColorConstant.orange40,
      height: 69,
      child: Row(
        children: [
          const SizedBox(
            width: 200,
            child: Text(
              "Requester",
              style: _headerTextStyle,
            ),
          ),
          const Flexible(
            flex: 3,
            fit: FlexFit.tight,
            child: Text(
              "Detail",
              style: _headerTextStyle,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Container(
              alignment: Alignment.centerLeft,
              width: 100,
              child: const Text(
                "Priority",
                style: _headerTextStyle,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Container(
              alignment: Alignment.centerLeft,
              width: 100,
              child: const Text(
                "Status",
                style: _headerTextStyle,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Container(
              alignment: Alignment.centerLeft,
              width: 120,
              child: const Text(
                "Category",
                style: _headerTextStyle,
              ),
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            width: 70,
            child: const Text(
              "Time",
              style: _headerTextStyle,
            ),
          ),
          SizedBox(
            width: 105,
            child: Container(
              alignment: Alignment.center,
              child: const Text(
                "Action",
                style: _headerTextStyle,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
