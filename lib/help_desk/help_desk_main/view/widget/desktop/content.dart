import 'package:flutter/material.dart';
import 'package:senior_project/assets/color_constant.dart';

class Content extends StatefulWidget {
  final double size;
  const Content({super.key, required this.size});

  @override
  State<Content> createState() => _ContentState();
}

class _ContentState extends State<Content> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.size,
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(color: ColorConstant.whiteBlack30),
        )
      ),
    );
  }
}