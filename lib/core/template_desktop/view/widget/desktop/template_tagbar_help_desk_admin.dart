import 'package:flutter/material.dart';
import 'package:senior_project/core/template_desktop/view/widget/desktop/tagbar_helpdesk.dart';
import 'package:senior_project/assets/color_constant.dart';

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
            const Padding(
              padding: EdgeInsets.only(top: 8, bottom: 8),
              child: TagBarHelpDesk(name: "All Ticket"),
            ),
            const Divider(),
            const Padding(
              padding: EdgeInsets.only(top: 8, bottom: 8),
              child: TagBarHelpDesk(name: "Not Start"),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 8, bottom: 8),
              child: TagBarHelpDesk(name: "In Progress"),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 8, bottom: 8),
              child: TagBarHelpDesk(name: "Closed"),
            ),
            const Divider(),
            const Padding(
              padding: EdgeInsets.only(top: 8, bottom: 8),
              child: TagBarHelpDesk(name: "Urgent"),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 8, bottom: 8),
              child: TagBarHelpDesk(name: "High"),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 8, bottom: 8),
              child: TagBarHelpDesk(name: "Medium"),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 8, bottom: 8),
              child: TagBarHelpDesk(name: "Low"),
            ),
          ],
        ),
      ),
    );
  }
}
