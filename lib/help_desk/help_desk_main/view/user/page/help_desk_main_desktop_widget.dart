import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senior_project/core/template_desktop/view/page/template_desktop.dart';
import 'package:senior_project/core/template_mobile/view/template_menu_mobile.dart';
import 'package:senior_project/core/view_model/app_view_model.dart';
import 'package:senior_project/help_desk/help_desk_main/core/widget/mobile/mobile_widget.dart';
import 'package:senior_project/help_desk/help_desk_main/model/help_desk_main_model.dart';
import 'package:senior_project/help_desk/help_desk_main/view/user/widget/help_desk_desktop_header_widget.dart';
import '../widget/help_desk_desktop_body_widget.dart';

class HelpDeskMainDesktopWidget extends StatelessWidget {
  final List<HelpDeskCard> cards;
  const HelpDeskMainDesktopWidget({super.key, required this.cards});

  @override
  Widget build(BuildContext context) {
    context.read<AppViewModel>().selectView(MediaQuery.of(context).size.width);
    bool isMobileSite = context.watch<AppViewModel>().getMobileSiteState;

    if (isMobileSite) {
      return const TemplateMenuMobile(content: MobileWidget(isAdmin: false,));
    }
    return TemplateDesktop(
      faqmenu: false, 
      faqmenuadmin: false, 
      helpdesk: true, 
      helpdeskadmin: false, 
      home: false, 
      useTemplatescroll: true, 
      content: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HelpDeskDesktopHeader.widget(context),
          HelpDeskDesktopBody(cards: cards)
        ],
      )
    );
  }
}
