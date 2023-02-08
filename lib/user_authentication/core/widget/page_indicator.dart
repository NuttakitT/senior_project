import 'package:flutter/material.dart';
import 'package:senior_project/assets/color_constant.dart';

class PageIndicator extends StatefulWidget {
  final double width;
  final List<bool> indicatorsState;
  final bool isMobileSize;
  const PageIndicator({
    super.key, 
    required this.width, 
    required this.indicatorsState,
    required this.isMobileSize
  });

  @override
  State<PageIndicator> createState() => _PageIndicatorState();
}

class _PageIndicatorState extends State<PageIndicator> {
  static List<Color> _getColor(bool isMobile) {
    if (isMobile) {
      return [
        ColorConstant.orange40, 
        ColorConstant.whiteBlack15, 
        ColorConstant.orange50, 
        ColorConstant.whiteBlack40,
        ColorConstant.orange40,
        ColorConstant.whiteBlack20,
        ColorConstant.whiteBlack15, 
      ];
    } else {
      return [
        ColorConstant.blue50, 
        Colors.white, 
        ColorConstant.blue90, 
        ColorConstant.blue50,
        ColorConstant.blue10,
        ColorConstant.blue10,
        Colors.white
      ];
    }
  }

  static Widget _indicatorIcon(
    String pageNumber, 
    String pageName, 
    bool pageState,
    bool isMobileSize
    ) {
    return Column(
      children: [
        Container(
          width: isMobileSize ? 28 : 48,
          height: isMobileSize ? 28 : 48,
          padding: const EdgeInsets.all(2),
          decoration: BoxDecoration(
            border: Border.all(
              color: pageState ? _getColor(isMobileSize)[0] : _getColor(isMobileSize)[5], 
              width: 2
            ),
            shape: BoxShape.circle,
            color:  pageState ? Colors.white : _getColor(isMobileSize)[1]
          ),
          child: Container(
            alignment: Alignment.center,
            width: isMobileSize ? 24 : 44,
            height: isMobileSize ? 24 : 44,
            decoration: BoxDecoration(
              color: pageState ? _getColor(isMobileSize)[0] : _getColor(isMobileSize)[6],
              shape: BoxShape.circle,
            ),
            child: Text(
              pageNumber,
              style: TextStyle(
                color: isMobileSize 
                  ? Colors.white 
                  : pageState ? Colors.white : ColorConstant.blue40,
                fontFamily: ColorConstant.font,
                fontWeight: FontWeight.w600,
                fontSize: isMobileSize ? 16 : 24
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Text(
            pageName,
            style: TextStyle(
              color: pageState ? _getColor(isMobileSize)[2] : _getColor(isMobileSize)[3],
              fontFamily: ColorConstant.font,
              fontWeight: pageState ? FontWeight.w600 : FontWeight.w400,
              fontSize: isMobileSize ? 14 : 18
            ),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment(0, widget.isMobileSize ? -0.5 : -0.45),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Container(
            width: widget.width,
            height: 2,
            color: widget.indicatorsState[1] 
              ? _getColor(widget.isMobileSize)[4] 
              : widget.isMobileSize ? ColorConstant.whiteBlack15 : ColorConstant.blue10,
          ),
        ),
        Container(
          width: 502,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: _indicatorIcon("1", "Login", widget.indicatorsState[0], widget.isMobileSize)
              ),
              const Divider(),
              Expanded(
                child: _indicatorIcon("2", "Selecte role", widget.indicatorsState[1], widget.isMobileSize)
              )
            ],
          ),
        ),
      ]
    );
  }
}