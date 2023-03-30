import 'package:flutter/material.dart';
import 'package:senior_project/role_management/model/role_management_model.dart';
import 'package:senior_project/role_management/view/widgets/add_category_popup.dart';
import 'package:senior_project/role_management/view/widgets/role_management_header.dart';

class CategoryTable extends StatefulWidget {
  final List<TopicCategory> categories;
  const CategoryTable({super.key, required this.categories});

  @override
  State<CategoryTable> createState() => _CategoryTableState();
}

class _CategoryTableState extends State<CategoryTable> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RoleManagementHeader(
            title: Consts.listCategoryLabel,
            isSearchEnabled: false,
            buttonLabel: Consts.addCategory,
            popup: const AddCategoryPopup()),
      ],
    );
  }
}

class Consts {
  static String listCategoryLabel = "List Category";
  static String addCategory = "Add Category";
}
