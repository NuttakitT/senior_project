import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senior_project/assets/color_constant.dart';
import 'package:senior_project/assets/font_style.dart';
import 'package:senior_project/core/template_desktop/view_model/template_desktop_view_model.dart';

class TagBar extends StatefulWidget {
  final String name;
  final bool state;
  final int index;
  final int type;
  const TagBar(
      {super.key,
      required this.name,
      required this.state,
      required this.index,
      required this.type});

  @override
  State<TagBar> createState() => _TagBarState();
}

class _TagBarState extends State<TagBar> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: InkWell(
        child: Container(
          decoration: BoxDecoration(
              color: widget.state == true
                  ? ColorConstant.orange80
                  : ColorConstant.whiteBlack85,
              borderRadius: BorderRadius.circular(8)),
          height: 40,
          width: 280,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: Text(
                  widget.name,
                  style: const TextStyle(
                    fontFamily: AppFontStyle.font,
                    fontWeight: AppFontWeight.regular,
                    color: ColorConstant.white,
                    fontSize: 20),
                  textAlign: TextAlign.left,
                ),
              ),
            ],
          ),
        ),
        onTap: () {
          context
              .read<TemplateDesktopViewModel>()
              .changeState(context, widget.index, widget.type);
          // TODO tag bar logic
        },
      ),
    );
  }
}
