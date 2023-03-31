import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senior_project/core/template/widget/search_bar.dart';
import 'package:senior_project/core/template/template_desktop/view/widget/desktop/tagbar_helpdesk.dart';
import 'package:senior_project/assets/color_constant.dart';
import 'package:senior_project/core/template/template_desktop/view_model/template_desktop_view_model.dart';
import 'package:senior_project/core/view_model/app_view_model.dart';
import 'package:senior_project/help_desk/help_desk_main/view_model/help_desk_view_model.dart';

//call function from tabtag_help.dart
class TemplateTagBarHelpDesk extends StatefulWidget {
  const TemplateTagBarHelpDesk({super.key});
  @override
  State<TemplateTagBarHelpDesk> createState() => _TemplateTagBarHelpDeskState();
}

class _TemplateTagBarHelpDeskState extends State<TemplateTagBarHelpDesk> {
  @override
  Widget build(BuildContext context) {
    List<bool> menuSelected = [
      context.watch<TemplateDesktopViewModel>().getHelpDeskAdminState(0),
      context.watch<TemplateDesktopViewModel>().getHelpDeskAdminState(1),
      context.watch<TemplateDesktopViewModel>().getHelpDeskAdminState(2),
      context.watch<TemplateDesktopViewModel>().getHelpDeskAdminState(3),
    ];
    String id = context.watch<AppViewModel>().app.getUser.getId;

    return Container(
      decoration: const BoxDecoration(color: ColorConstant.whiteBlack85),
      height: double.infinity,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  top: 24, right: 24, left: 24, bottom: 40),
              child: Container(
                decoration: BoxDecoration(
                    color: ColorConstant.white,
                    borderRadius: BorderRadius.circular(16)),
                height: 50,
                width: 280,
                child: const SearchBar(isHelpDeskPage: true,)
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 8),
              child: TagBarHelpDesk(name: "All status", state: menuSelected[0], index: 0, id: id,),
            ),
            Padding(
              padding: const EdgeInsets.all(24),
              child: Container(
                width: 280,
                height: 1,
                color: Colors.white,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 8),
              child: TagBarHelpDesk(name: "Not Start", state: menuSelected[1], index: 1, id: id,),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 8),
              child: TagBarHelpDesk(name: "In Progress", state: menuSelected[2], index: 2, id: id,),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 8),
              child: TagBarHelpDesk(name: "Closed", state: menuSelected[3], index: 3, id: id,),
            )
          ],
        ),
      ),
    );
  }
}
