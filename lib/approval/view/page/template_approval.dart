import 'package:flutter/material.dart';
import 'package:senior_project/approval/view/widget/approval_list.dart';
import 'package:senior_project/core/template/template_desktop/view/page/template_desktop.dart';

import '../widget/approval_detail.dart';

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
        content: ApprovalList());
  }
}
