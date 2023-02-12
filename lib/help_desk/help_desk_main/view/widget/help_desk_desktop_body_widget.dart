import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senior_project/assets/color_constant.dart';
import 'package:senior_project/help_desk/help_desk_main/model/help_desk_main_model.dart';
import 'package:senior_project/help_desk/help_desk_main/view/widget/help_desk_card_widget.dart';

class HelpDeskDesktopBody extends StatefulWidget {
  final List<HelpDeskCard> cards;
  const HelpDeskDesktopBody({super.key, required this.cards});

  @override
  State<HelpDeskDesktopBody> createState() => _HelpDeskDesktopBodyState();
}

class _HelpDeskDesktopBodyState extends State<HelpDeskDesktopBody> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    var bodyPadding = const EdgeInsets.fromLTRB(77, 40, 20, 0);

    return ConstrainedBox(
      constraints: BoxConstraints(
          maxWidth: screenWidth, minWidth: 200, maxHeight: screenHeight),
      child: Padding(
          padding: bodyPadding,
          child: widget.cards.isNotEmpty
              ? SizedBox(
                  width: double.infinity,
                  child: ListView.builder(
                      itemCount: widget.cards.length,
                      itemBuilder: (BuildContext context, int index) {
                        return HelpDeskCardWidget.widget(context,
                            card: widget.cards[index]);
                      }),
                )
              : const Center(
                  child: Text("No Task jaa"),
                )),
    );
  }
}
