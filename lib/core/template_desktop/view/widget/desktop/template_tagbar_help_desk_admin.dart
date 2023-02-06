import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senior_project/core/template_desktop/view/widget/desktop/tagbar_helpdesk.dart';
import 'package:senior_project/assets/color_constant.dart';
import 'package:senior_project/core/template_desktop/view_model/template_desktop_view_model.dart';

//call function from tabtag_help.dart
class TemplateTagBarHelpDeskAdmin extends StatefulWidget {
  const TemplateTagBarHelpDeskAdmin({super.key});
  @override
  State<TemplateTagBarHelpDeskAdmin> createState() =>
      _TemplateTagBarHelpDeskAdminState();
}

class _TemplateTagBarHelpDeskAdminState
    extends State<TemplateTagBarHelpDeskAdmin> {
  @override
  Widget build(BuildContext context) {
    bool all = context.watch<TemplateDesktopViewModel>().getHelpDeskAdminState(0);
    bool notStart = context.watch<TemplateDesktopViewModel>().getHelpDeskAdminState(1);
    bool pending = context.watch<TemplateDesktopViewModel>().getHelpDeskAdminState(2);
    bool closed = context.watch<TemplateDesktopViewModel>().getHelpDeskAdminState(3);
    bool urgent = context.watch<TemplateDesktopViewModel>().getHelpDeskAdminState(4);
    bool high = context.watch<TemplateDesktopViewModel>().getHelpDeskAdminState(5);
    bool med = context.watch<TemplateDesktopViewModel>().getHelpDeskAdminState(6);
    bool low = context.watch<TemplateDesktopViewModel>().getHelpDeskAdminState(7);

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
              child: TagBarHelpDesk(name: "All Ticket", state: all, index: 0),
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
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 8),
              child: TagBarHelpDesk(name: "Urgent", state: urgent, index: 4),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 8),
              child: TagBarHelpDesk(name: "High", state: high, index: 5),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 8),
              child: TagBarHelpDesk(name: "Medium", state: med, index: 6),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 8),
              child: TagBarHelpDesk(name: "Low", state: low, index: 7),
            ),
          ],
        ),
      ),
    );
  }
}
