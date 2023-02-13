import 'package:flutter/material.dart';
import 'package:senior_project/assets/color_constant.dart';
import 'package:senior_project/help_desk/help_desk_main/view/user/widget/help_desk_card_widget.dart';

class HelpDeskDesktopBody extends StatefulWidget {
  final List<Map<String, dynamic>> cards;
  const HelpDeskDesktopBody({super.key, required this.cards});

  @override
  State<HelpDeskDesktopBody> createState() => _HelpDeskDesktopBodyState();
}

class _HelpDeskDesktopBodyState extends State<HelpDeskDesktopBody> {
  List<Widget> generateContent() {
    List<Widget> content = [];
    for (int i = 0; i < widget.cards.length; i++) {
      content.add(HelpDeskCardWidget(card: widget.cards[i],context: context).widget());
    }
    return content;
  }

  @override
  Widget build(BuildContext context) {
    var bodyPadding = const EdgeInsets.fromLTRB(77, 40, 20, 0);

    return Padding(
        padding: bodyPadding,
        child: widget.cards.isNotEmpty
            ? SizedBox(
                width: double.infinity,
                child: Column(
                  children: generateContent(),
                )
              )
            : const Center(
                child: Text(
                  "All problems solved!",
                  style: TextStyle(
                    fontFamily: ColorConstant.font,
                    fontWeight: FontWeight.w400,
                    fontSize: 20,
                    color: ColorConstant.whiteBlack60
                  ),
                ),
              ));
  }
}
