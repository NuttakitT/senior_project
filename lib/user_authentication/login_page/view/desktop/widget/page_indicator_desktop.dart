import 'package:flutter/material.dart';
import 'package:senior_project/assets/constant.dart';

// TODO fix this to listen state from view model
class PageIndicatorDesktop {
  static Widget _indicatorIcon(String pageNumber, String pageName, bool pageState) {
    return Column(
      children: [
        Container(
          width: 48,
          height: 48,
          padding: const EdgeInsets.all(2),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            border: Border.all(
              color: pageState ? Constant.orange40 : Constant.whiteBlack20, 
              width: 2
            ),
            color: pageState ? Colors.white : Constant.whiteBlack15,
          ),
          child: Container(
            alignment: Alignment.center,
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: pageState ? Constant.orange40 : Constant.whiteBlack15,
            ),
            child: Text(
              pageNumber,
              style: const TextStyle(
                color: Colors.white,
                fontFamily: Constant.font,
                fontWeight: FontWeight.w600,
                fontSize: 24
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Text(
            pageName,
            style: TextStyle(
              color: pageState ? Constant.orange50 : Constant.whiteBlack40,
              fontFamily: Constant.font,
              fontWeight: FontWeight.w600,
              fontSize: 18
            ),
          ),
        )
      ],
    );
  }

  static Widget widget() {
    return Stack(
      alignment: const Alignment(0, -0.45),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Container(
            width: 200,
            height: 2,
            color: Constant.whiteBlack15, // TODO add state listener to this line
          ),
        ),
        Container(
          width: 502,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: _indicatorIcon("1", "Login", true)
              ),
              const Divider(),
              Expanded(
                child: _indicatorIcon("2", "Selecte role", false)
              )
            ],
          ),
        ),
      ]
    );
  }
}