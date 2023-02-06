import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senior_project/core/template_desktop/view/widget/desktop/tagbar_helpdesk.dart';
import 'package:senior_project/assets/color_constant.dart';
import 'package:senior_project/core/template_desktop/view_model/template_desktop_view_model.dart';

//call function from tabtag_help.dart
class TemplateTagBarHelpDesk extends StatefulWidget {
  const TemplateTagBarHelpDesk({super.key});
  @override
  State<TemplateTagBarHelpDesk> createState() => _TemplateTagBarHelpDeskState();
}

class _TemplateTagBarHelpDeskState extends State<TemplateTagBarHelpDesk> {
  @override
  Widget build(BuildContext context) {
    bool all = context.watch<TemplateDesktopViewModel>().getHelpDeskAdminState(0);
    bool notStart = context.watch<TemplateDesktopViewModel>().getHelpDeskAdminState(1);
    bool pending = context.watch<TemplateDesktopViewModel>().getHelpDeskAdminState(2);
    bool closed = context.watch<TemplateDesktopViewModel>().getHelpDeskAdminState(3);

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
                height: 40,
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
                    const Expanded(
                      child: TextField(
                        decoration: InputDecoration.collapsed(
                            hintText: "search...",
                            hintStyle: TextStyle(
                                color: ColorConstant.whiteBlack30,
                                fontSize: 16)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 8),
              child: TagBarHelpDesk(name: "All status", state: all, index: 0),
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 8),
              child: TagBarHelpDesk(name: "Not Start", state: notStart, index: 1),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 8),
              child: TagBarHelpDesk(name: "In Progress", state: pending, index: 2),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 8),
              child: TagBarHelpDesk(name: "Closed", state: closed, index: 3),
            )
          ],
        ),
      ),
    );
  }
}
