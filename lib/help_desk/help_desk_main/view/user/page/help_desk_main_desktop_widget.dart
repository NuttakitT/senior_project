import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senior_project/core/template_desktop/view/page/template_desktop.dart';
import 'package:senior_project/core/template_mobile/view/template_menu_mobile.dart';
import 'package:senior_project/core/view_model/app_view_model.dart';
import 'package:senior_project/help_desk/help_desk_main/core/widget/mobile/mobile_widget.dart';
import 'package:senior_project/help_desk/help_desk_main/view/user/widget/help_desk_desktop_header_widget.dart';
import '../widget/help_desk_desktop_body_widget.dart';

class HelpDeskMainDesktopWidget extends StatelessWidget {
  const HelpDeskMainDesktopWidget({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<AppViewModel>().selectView(MediaQuery.of(context).size.width);
    bool isMobileSite = context.watch<AppViewModel>().getMobileSiteState;
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

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
      content: Container(
        constraints: BoxConstraints(
          maxWidth: screenWidth, 
          minWidth: 200, 
          maxHeight: screenHeight - 155
        ),
        alignment: AlignmentDirectional.topCenter,
        child: ListView(
          children: [
            HelpDeskDesktopHeader.widget(context),
            const HelpDeskDesktopBody()
          ],
        ),
      )
    );
  }
}
