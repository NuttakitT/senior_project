import 'package:flutter/material.dart';
import 'package:senior_project/assets/color_constant.dart';

class TagBarHelpDesk extends StatefulWidget {
  final String name; //ชื่อเมนู
  const TagBarHelpDesk({
    super.key,
    required this.name,
  });

  @override
  State<TagBarHelpDesk> createState() => _TagBarHelpDeskState();
}

class _TagBarHelpDeskState extends State<TagBarHelpDesk> {
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
          height: 40,
          width: 280,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.name,
                    style: const TextStyle(
                        fontSize: 20,
                        color: ColorConstant.whiteBlack80,
                        fontWeight: FontWeight.normal),
                    textAlign: TextAlign.left,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: select == true
                            ? ColorConstant.white
                            : ColorConstant.blue5),
                    height: 24,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                    child: const Text(
                      //TODO Pull data from back-end
                      "191",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: ColorConstant.whiteBlack80),
                    ),
                  ),
                ],
              ),
            ),
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
