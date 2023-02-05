import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senior_project/assets/color_constant.dart';
import 'package:senior_project/help_desk/help_desk_main/model/help_desk_main_model.dart';
import 'package:senior_project/help_desk/help_desk_main/view_model/help_desk_main_view_model.dart';

import '../../../../core/view_model/app_view_model.dart';
import '../widget/help_desk_main_desktop_widget.dart';

class HelpDeskMainView extends StatefulWidget {
  const HelpDeskMainView({super.key});

  @override
  State<HelpDeskMainView> createState() => _HelpDeskMainViewState();
}

class _HelpDeskMainViewState extends State<HelpDeskMainView> {
  List<HelpDeskCard> cards = [
    HelpDeskCard(
        title: "ewwe",
        category: "eee",
        detail: "gerberbergberw",
        priority: "High")
  ];

  Widget helpDeskMainDesktopView(List<HelpDeskCard> cards) {
    return HelpDeskMainDesktopWidget(
      cards: cards,
    );
  }

  Widget helpDeskMainMobileView(List<HelpDeskCard> cards) {
    // return HelpDeskMainMobileWidget();
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    // bool isMobileSite = context.watch<AppViewModel>().getMobileSiteState;
    bool isMobileSite = false;

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
