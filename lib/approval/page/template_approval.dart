import 'package:flutter/material.dart';
import 'package:senior_project/approval/widget/approval_detail.dart';
import 'package:senior_project/approval/widget/approval_list.dart';
import 'package:senior_project/core/template/template_desktop/view/page/template_desktop.dart';

class TemplateApproval extends StatefulWidget {
  const TemplateApproval({super.key});

  @override
  State<TemplateApproval> createState() => _TemplateApprovalState();
}

class _TemplateApprovalState extends State<TemplateApproval> {
  @override
  Widget build(BuildContext context) {
    return const TemplateDesktop(
        helpdesk: false,
        helpdeskadmin: false,
        home: true,
        useTemplatescroll: true,
        content: ApprovalDetail());
  }
}
