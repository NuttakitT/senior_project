import 'package:flutter/material.dart';
import 'package:senior_project/assets/color_constant.dart';

class HeaderTable {
  static const _headerTextStyle = TextStyle(
      fontFamily: ColorConstant.font,
      fontSize: 18,
      fontWeight: FontWeight.w700,
      color: Colors.white
  );

  static Widget widget() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      color: ColorConstant.orange40,
      height: 69,
      child: Row(
        children: const [
          Flexible(
            flex: 2,
            fit: FlexFit.tight,
            child: Text(
              "Requester",
              style: _headerTextStyle,
            ),
          ),
          Flexible(
            flex: 3,
            fit: FlexFit.tight,
            child: Text(
              "Detail",
              style: _headerTextStyle,
            ),
          ),
          Flexible(
            fit: FlexFit.tight,
            child: Text(
              "Priority",
              style: _headerTextStyle,
            ),
          ),
          Flexible(
            fit: FlexFit.tight,
            child: Text(
              "Status",
              style: _headerTextStyle,
            ),
          ),
          Flexible(
            flex: 2,
            fit: FlexFit.tight,
            child: Text(
              "Category",
              style: _headerTextStyle,
            ),
          ),
          Flexible(
            fit: FlexFit.tight,
            child: Text(
              "Time",
              style: _headerTextStyle,
            ),
          ),
          Flexible(
            fit: FlexFit.tight,
            child: Text(
              "Action",
              style: _headerTextStyle,
            ),
          ),
        ],
      ),
    );
  }
}