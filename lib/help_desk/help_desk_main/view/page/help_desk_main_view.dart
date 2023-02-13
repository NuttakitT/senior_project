import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senior_project/assets/color_constant.dart';
import 'package:senior_project/help_desk/help_desk_main/model/help_desk_main_model.dart';
import 'package:senior_project/help_desk/help_desk_main/view_model/help_desk_main_view_model.dart';

import '../../../../core/view_model/app_view_model.dart';
import '../widget/help_desk_main_desktop_widget.dart';
import '../widget/help_desk_main_mobile_widget.dart';

class HelpDeskMainView extends StatefulWidget {
  const HelpDeskMainView({super.key});

  @override
  State<HelpDeskMainView> createState() => _HelpDeskMainViewState();
}

class _HelpDeskMainViewState extends State<HelpDeskMainView> {
  List<HelpDeskCard> cards = [
    HelpDeskCard(
        title: "Flutter TextButton Widget",
        cardNumber: 100,
        category: "Flutter krub",
        detail:
            "TextButton is a built-in widget in Flutter which derives its design from Google Material Design Library. It is a simple Button without any border that listens for onPressed and onLongPress gestures. It has a style property that accepts ButtonStyle as value, using this style property developers can customize the TextButton however they want.",
        priority: "High",
        status: Status.notStart,
        userName: "Runn SSSS"),
    HelpDeskCard(
        title: "Flut Widget",
        cardNumber: 101,
        category: "Flutter krub",
        detail:
            "TextButton is a built-in widget in Flutter which derives its design from Google Material Design Library. It is a simple Button without any border that listens for onPressed and onLongPress gestures. It has a style property that accepts ButtonStyle as value, using this style property developers can customize the TextButton however they want.",
        priority: "High",
        status: Status.done,
        userName: "Mamamamama")
  ];

  Widget helpDeskMainDesktopView(List<HelpDeskCard> cards) {
    return HelpDeskMainDesktopWidget(
      cards: cards,
    );
  }

  Widget helpDeskMainMobileView(List<HelpDeskCard> cards) {
    return HelpDeskMainMobileWidget(
      cards: cards,
    );
  }

  @override
  Widget build(BuildContext context) {
    // bool isMobileSite = context.watch<AppViewModel>().getMobileSiteState;
    bool isMobileSite = true;

    return Builder(
      builder: (BuildContext context) {
        if (isMobileSite) {
          return helpDeskMainMobileView(cards);
        }
        return helpDeskMainDesktopView(cards);
      },
    );
  }
}
