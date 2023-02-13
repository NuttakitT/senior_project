import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senior_project/assets/color_constant.dart';
import 'package:senior_project/help_desk/help_desk_main/model/help_desk_main_model.dart';
import 'package:senior_project/help_desk/help_desk_main/view/widget/help_desk_desktop_header_widget.dart';
import 'help_desk_desktop_body_widget.dart';

class HelpDeskMainDesktopWidget extends StatelessWidget {
  final List<HelpDeskCard> cards;
  const HelpDeskMainDesktopWidget({super.key, required this.cards});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HelpDeskDesktopHeader.widget(context),
          HelpDeskDesktopBody(cards: cards)
        ],
      ),
    );
  }
}
