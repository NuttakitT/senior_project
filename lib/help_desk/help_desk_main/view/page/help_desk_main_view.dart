import 'package:flutter/material.dart';
import 'package:senior_project/help_desk/help_desk_main/model/help_desk_main_model.dart';
import 'package:senior_project/help_desk/help_desk_main/view/admin/page/help_desk_admin_page.dart';
import 'package:senior_project/help_desk/help_desk_main/view/user/page/help_desk_main_desktop_widget.dart';

class HelpDeskMainView extends StatelessWidget {
  final bool isAdmin;
  HelpDeskMainView({super.key, required this.isAdmin});

  final List<HelpDeskCard> cards = [
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

  @override
  Widget build(BuildContext context) {
    if (isAdmin) {
      return const HelpDeskAdminPage();
    } else {
      return HelpDeskMainDesktopWidget(cards: cards);
    }
  }
}
