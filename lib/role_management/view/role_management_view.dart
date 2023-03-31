import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senior_project/core/template/template_desktop/view/page/template_desktop.dart';
import 'package:senior_project/role_management/view/widgets/category_table.dart';
import 'package:senior_project/role_management/view/widgets/role_management_table.dart';
import 'package:senior_project/role_management/view_model/role_management_view_model.dart';

import '../../core/view_model/app_view_model.dart';
import '../model/role_management_model.dart';

class RoleManagementView extends StatefulWidget {
  final isAdmin;
  const RoleManagementView({super.key, required this.isAdmin});

  @override
  State<RoleManagementView> createState() => _RoleManagementViewState();
}

class _RoleManagementViewState extends State<RoleManagementView> {
  @override
  Widget build(BuildContext context) {
    bool isMobileSite = context
        .watch<AppViewModel>()
        .getMobileSiteState(MediaQuery.of(context).size.width);
    if (widget.isAdmin && !isMobileSite) {
      return FutureBuilder(
          future: context.read<RoleManagementViewModel>().fetchPage(),
          builder: ((context, snapshot) {
            if (snapshot.hasError) {
              return Text('Has error ${snapshot.error}');
            }
            final admins = snapshot.data?.admins ?? [];
            final categories = snapshot.data?.categories ?? [];

            return TemplateDesktop(
                helpdesk: false,
                helpdeskadmin: false,
                home: false,
                useTemplatescroll: true,
                content: SingleChildScrollView(
                  child: Column(
                    children: [
                      RoleManagementTable(admins: admins),
                      CategoryTable(categories: categories)
                    ],
                  ),
                ));
          }));
    }
    return Container();
  }
}
