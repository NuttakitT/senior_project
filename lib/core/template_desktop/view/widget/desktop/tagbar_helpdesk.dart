import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senior_project/assets/color_constant.dart';
import 'package:senior_project/assets/font_style.dart';
import 'package:senior_project/core/template_desktop/view_model/template_desktop_view_model.dart';

class TagBarHelpDesk extends StatefulWidget {
  final String name;
  final bool state;
  final int index;
  const TagBarHelpDesk({
    super.key,
    required this.name,
    required this.index,
    required this.state,
  });

  @override
  State<TagBarHelpDesk> createState() => _TagBarHelpDeskState();
}

class _TagBarHelpDeskState extends State<TagBarHelpDesk> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: InkWell(
        child: Container(
          decoration: BoxDecoration(
              color: widget.state == true
                  ? ColorConstant.orange20
                  : ColorConstant.blue0,
              borderRadius: BorderRadius.circular(8)),
          height: 40,
          width: 280,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.name,
                  style: AppFontStyle.wb80R20,
                  textAlign: TextAlign.left,
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: widget.state == true
                          ? ColorConstant.white
                          : ColorConstant.blue5),
                  height: 24,
                  width: 40,
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
        onTap: () {
          context.read<TemplateDesktopViewModel>().changeState(widget.index, 4);
          // TODO tag bar logic
        },
      ),
    );
  }
}
