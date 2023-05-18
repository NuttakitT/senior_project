import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senior_project/core/template/template_desktop/view/page/template_desktop.dart';
import 'package:senior_project/core/template/template_desktop/view_model/template_desktop_view_model.dart';
import 'package:senior_project/role_management/view/widgets/category_table.dart';
import 'package:senior_project/role_management/view/widgets/role_management_table.dart';
import 'package:senior_project/role_management/view_model/role_management_view_model.dart';

class RoleManagementView extends StatefulWidget {
  final bool isAdmin;
  const RoleManagementView({super.key, required this.isAdmin});

  @override
  State<RoleManagementView> createState() => _RoleManagementViewState();
}

class _RoleManagementViewState extends State<RoleManagementView> {
  @override
  void initState() {
    context.read<RoleManagementViewModel>().initModel();
    super.initState();
  }

  bool isMobileSite = kIsWeb &&
      (defaultTargetPlatform == TargetPlatform.iOS ||
          defaultTargetPlatform == TargetPlatform.android);

  @override
  Widget build(BuildContext context) {
    // context.read<TemplateDesktopViewModel>().changeState(context, 3, 1);
    if (widget.isAdmin && !isMobileSite) {
      return FutureBuilder(
          future: context.read<RoleManagementViewModel>().fetchPage(),
          builder: ((context, snapshot) {
            if (snapshot.hasError) {
              return Text('Has error ${snapshot.error}');
            }
            if (snapshot.connectionState == ConnectionState.done) {
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
            }
            return const Center(
              child: SizedBox(
                width: 100,
                height: 100,
                child: CircularProgressIndicator(),
              ),
            );
          }));
    }
    return Container();
  }
}
