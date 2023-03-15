import 'package:flutter/material.dart';
import 'package:senior_project/assets/color_constant.dart';
import 'package:senior_project/assets/font_style.dart';

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  Widget _iconLoader() {
    return Row(
      children: [
        const Padding(
          padding: EdgeInsets.only(right: 16),
          child: Text(
            "1-5 of 5",
            style: TextStyle(
              fontFamily: AppFontStyle.font,
              fontWeight: FontWeight.normal,
              fontSize: 16,
              color: ColorConstant.whiteBlack70
            ),
          ),
        ),
        IconButton(
          onPressed: () {
            // TODO load more
          }, 
          icon: const Icon(Icons.keyboard_arrow_right_rounded)
        ),
        IconButton(
          onPressed: () {
            // TODO load more
          }, 
          icon: const Icon(Icons.keyboard_double_arrow_right_rounded)
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        children: [
          Container(
            height: 72,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              )
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            alignment: AlignmentDirectional.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    // TODO refresh
                  },
                  icon: const Icon(Icons.refresh_rounded, 
                    color: ColorConstant.whiteBlack70,
                  ),
                ),
                _iconLoader()
              ],
            ),
          ),
          // TODO body
          Container(
            height: 100,
            color: Colors.amber,
          ),
          Container(
            height: 72,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16),
              )
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                _iconLoader(),
              ],
            )
          )
        ],
      )
    );
  }
}