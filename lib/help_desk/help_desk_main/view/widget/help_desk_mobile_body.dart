import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senior_project/assets/color_constant.dart';
import 'package:senior_project/help_desk/help_desk_main/model/help_desk_main_model.dart';
import 'package:senior_project/help_desk/help_desk_main/view/widget/help_desk_card_mobile.dart';

class HelpDeskMobileBody extends StatefulWidget {
  final List<HelpDeskCard> cards;
  const HelpDeskMobileBody({super.key, required this.cards});

  @override
  State<HelpDeskMobileBody> createState() => _HelpDeskMobileBodyState();
}

class _HelpDeskMobileBodyState extends State<HelpDeskMobileBody> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return ConstrainedBox(
      constraints: BoxConstraints(
          maxWidth: screenWidth, minWidth: 200, maxHeight: screenHeight),
      child: Padding(
          padding: const EdgeInsets.only(left: 16, top: 20, right: 16),
          child: widget.cards.isNotEmpty
              ? SizedBox(
                  width: double.infinity,
                  child: ListView.builder(
                      itemCount: widget.cards.length,
                      itemBuilder: (BuildContext context, int index) {
                        return HelpDeskCardMobile.widget(context,
                            card: widget.cards[index]);
                      }),
                )
              : const Center(
                  child: Text("No Task jaa"),
                )),
    );
  }
}
