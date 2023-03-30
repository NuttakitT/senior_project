import 'package:flutter/material.dart';
import 'package:senior_project/role_management/model/role_management_model.dart';
import 'package:senior_project/role_management/view/widgets/add_admin_popup.dart';
import 'package:senior_project/role_management/view/widgets/role_management_header.dart';

class RoleManagementTable extends StatefulWidget {
  final List<Admin> admins;
  const RoleManagementTable({super.key, required this.admins});

  @override
  State<RoleManagementTable> createState() => _RoleManagementTableState();
}

class _RoleManagementTableState extends State<RoleManagementTable> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RoleManagementHeader(
            title: Consts.roleManagementHeader,
            isSearchEnabled: true,
            buttonLabel: Consts.addUser,
            popup: const AddAdminPopup()),
      ],
    );
  }
}

class Consts {
  static String roleManagementHeader = "Role Management";
  static String addUser = "Add User";
}
