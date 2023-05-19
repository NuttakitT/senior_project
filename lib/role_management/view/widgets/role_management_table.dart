import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senior_project/assets/color_constant.dart';
import 'package:senior_project/assets/font_style.dart';
import 'package:senior_project/core/template/template_desktop/view/widget/desktop/confirmation_popup.dart';
import 'package:senior_project/core/view_model/app_view_model.dart';
import 'package:senior_project/role_management/model/role_management_model.dart';
import 'package:senior_project/role_management/view/role_management_view.dart';
import 'package:senior_project/role_management/view/widgets/add_admin_popup.dart';
import 'package:senior_project/role_management/view/widgets/multi_select_topics.dart';
import 'package:senior_project/role_management/view/widgets/role_management_header.dart';
import 'package:senior_project/role_management/view_model/role_management_view_model.dart';

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
            buttonLabel: Consts.addUser,
            popup: const AddAdminPopup()),
        RoleManagementDetailTable(widget: widget)
      ],
    );
  }
}

class RoleManagementDetailTable extends StatelessWidget {
  const RoleManagementDetailTable({
    Key? key,
    required this.widget,
  }) : super(key: key);

  final RoleManagementTable widget;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 64),
      child: Container(
        decoration: BoxDecoration(
            color: ColorConstant.white,
            borderRadius: BorderRadius.circular(16)),
        child: Table(
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          columnWidths: const {
            0: FixedColumnWidth(100),
            1: FixedColumnWidth(120),
            2: FixedColumnWidth(120),
            3: FixedColumnWidth(220),
            // 4: FixedColumnWidth(120),
            4: FlexColumnWidth(),
            5: FixedColumnWidth(50)
          },
          children: [
            buildRow(
              "",
              [
              Consts.userId,
              Consts.firstName,
              Consts.lastName,
              Consts.email,
              // Consts.role,
              Consts.responsibility,
              ""
            ], true, false, context),
            for (int i = 0; i < widget.admins.length; i++) ...[
              buildRow(
                widget.admins[i].userId,
                [
                widget.admins[i].userId,
                widget.admins[i].firstName,
                widget.admins[i].lastName,
                widget.admins[i].email,
                // widget.admins[i].role,
                widget.admins[i].responsibility,
                ""
              ], false, i == widget.admins.length - 1, context),
            ]
          ],
        ),
      ),
    );
  }
}

TableRow buildRow(String uid, List<dynamic> cells, bool isHeader, bool isLastIndex,
    BuildContext context) {
  List<TopicCategory> topic =
      context.watch<RoleManagementViewModel>().getCategories;
  String selfUid = context.watch<AppViewModel>().app.getUser.getId;
  return TableRow(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
              color: isLastIndex
                  ? Colors.transparent
                  : ColorConstant.whiteBlack20),
        ),
      ),
      children: cells.map((cell) {
        if (cell is String) {
          if (cell == "" && !isHeader) {
            return Builder(
              builder: (context) {
                if (selfUid == uid) {
                  return Container();
                }
                return Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: IconButton(
                    onPressed: () {
                      showDialog(
                        context: context, 
                        builder: (context) {
                          return ConfirmationPopup(
                            title: "Are you sure you want to delete this user from the Admin role?",
                            detail: "This action cannot be undone.", 
                            widget: null, 
                            onCancel: () {Navigator.pop(context);}, 
                            onConfirm: () async {
                              await context.read<RoleManagementViewModel>().removeAdmin(uid);
                              // ignore: use_build_context_synchronously
                              Navigator.pushAndRemoveUntil(
                                context, 
                                MaterialPageRoute(builder: (context) => const RoleManagementView(isAdmin: true)), 
                                (route) => false
                              );
                            }
                          );
                        }
                      );
                    }, 
                    icon: const Icon(Icons.delete_rounded, color: ColorConstant.whiteBlack60,)
                  ),
                );
              }
            );
          }
          return Padding(
            padding: const EdgeInsets.only(left: 16, top: 28, bottom: 28),
            child: Text(
              cell,
              style: isHeader ? AppFontStyle.wb80B20 : AppFontStyle.wb80R20,
              overflow: TextOverflow.ellipsis,
            ),
          );
        } else if (cell is List<TopicCategory>) {
          return Padding(
              padding: const EdgeInsets.only(
                  left: 16, top: 18, bottom: 18, right: 16),
              child: MultiSelectTopics(topics: topic, uid: uid, adminResponsibility: cell,)
              );
        } else {
          return Container();
        }
      }).toList());
}

class Consts {
  static String roleManagementHeader = "Role Management";
  static String addUser = "Add User";

  static String userId = "User ID";
  static String firstName = "First name";
  static String lastName = "Last name";
  static String email = "Email";
  static String role = "Role";
  static String responsibility = "Responsibility";
}
