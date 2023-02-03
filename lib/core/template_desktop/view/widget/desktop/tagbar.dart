import 'package:flutter/material.dart';
import 'package:senior_project/assets/color_constant.dart';

class TagBar extends StatefulWidget {
  final String name;
  const TagBar({super.key, required this.name});

  @override
  State<TagBar> createState() => _TagBarState();
}

class _TagBarState extends State<TagBar> {
  bool select = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: InkWell(
        child: Container(
          decoration: BoxDecoration(
              //TODO set state -> change color when select
              color:
                  select == true ? ColorConstant.orange20 : ColorConstant.blue0,
              borderRadius: BorderRadius.circular(8)),
          height: 40, //height = 40
          width: 280, //lenght = 280
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: Expanded(
                  child: Text(
                    widget.name,
                    style: const TextStyle(
                        fontSize: 20,
                        color: ColorConstant.whiteBlack80,
                        fontWeight: FontWeight.normal),
                  ),
                ),
              ),
            ],
          ),
        ),
        onTap: () {
          setState(() {
            select = true;
          });
        },
      ),
    );
  }
}
