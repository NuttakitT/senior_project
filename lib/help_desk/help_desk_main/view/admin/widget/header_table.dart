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
          const Flexible(
            flex: 2,
            fit: FlexFit.tight,
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
          const Flexible(
            fit: FlexFit.tight,
            child: Text(
              "Priority",
              style: _headerTextStyle,
            ),
          ),
          const Flexible(
            fit: FlexFit.tight,
            child: Text(
              "Status",
              style: _headerTextStyle,
            ),
          ),
          const Flexible(
            flex: 2,
            fit: FlexFit.tight,
            child: Text(
              "Category",
              style: _headerTextStyle,
            ),
          ),
          Flexible(
            fit: FlexFit.tight,
            child: Container(
              alignment: Alignment.center,
              child: const Text(
                "Time",
                style: _headerTextStyle,
              ),
            ),
          ),
          Flexible(
            fit: FlexFit.tight,
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
