import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senior_project/core/template_desktop/view/widget/desktop/tagbar_helpdesk.dart';
import 'package:senior_project/assets/color_constant.dart';
import 'package:senior_project/core/template_desktop/view_model/template_desktop_view_model.dart';
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
      padding: const EdgeInsets.only(left: 72),
      decoration: const BoxDecoration(color: ColorConstant.blue0),
      width: 400,
      height: double.infinity,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  top: 16, right: 24, left: 24, bottom: 40),
              child: Container(
                decoration: BoxDecoration(
                    color: ColorConstant.white,
                    borderRadius: BorderRadius.circular(16)),
                height: 50,
                width: 280,
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(right: 4, left: 16),
                      child: const Icon(
                        Icons.search_rounded,
                        color: ColorConstant.whiteBlack30,
                      ),
                    ),
                    Expanded(
                      child: TextField(
                        maxLength: 512,
                        decoration: const InputDecoration(
                          hintText: "search...",
                          hintStyle: TextStyle(
                              color: ColorConstant.whiteBlack30,
                              fontSize: 16
                          ),
                          counterText: "",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.zero,
                            borderSide: BorderSide.none,
                            gapPadding: 0
                          )
                        ),
                        onChanged: (value) async {
                          context.read<HelpDeskViewModel>().setSearchText(value);
                        }, 
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 8),
              child: TagBarHelpDesk(name: "All status", state: menuSelected[0], index: 0, id: id,),
            ),
            const Divider(),
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
