import 'package:flutter/material.dart';
import 'package:senior_project/assets/constant.dart';

// TODO fix this to listen state from view model
class PageIndicator extends StatefulWidget {
  final double width;
  const PageIndicator({super.key, required this.width});

  @override
  State<PageIndicator> createState() => _PageIndicatorState();
}

class _PageIndicatorState extends State<PageIndicator> {
  static Widget _indicatorIcon(String pageNumber, String pageName, bool pageState) {
    return Column(
      children: [
        Container(
          width: 48,
          height: 48,
          padding: const EdgeInsets.all(2),
          decoration: BoxDecoration(
            border: Border.all(
              color: pageState ? Constant.orange40 : Constant.whiteBlack20, 
              width: 2
            ),
            shape: BoxShape.circle,
            color: pageState ? Colors.white : Constant.whiteBlack15,
          ),
          child: Container(
            alignment: Alignment.center,
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: pageState ? Constant.orange40 : Constant.whiteBlack15,
              shape: BoxShape.circle,
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

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: const Alignment(0, -0.45),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Container(
            width: widget.width,
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