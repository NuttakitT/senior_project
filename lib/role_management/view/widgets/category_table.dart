import 'package:flutter/material.dart';
import 'package:senior_project/assets/color_constant.dart';
import 'package:senior_project/assets/font_style.dart';
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
        CategoryDetailTable(widget: widget),
      ],
    );
  }
}

class CategoryDetailTable extends StatefulWidget {
  const CategoryDetailTable({
    Key? key,
    required this.widget,
  }) : super(key: key);

  final CategoryTable widget;

  @override
  State<CategoryDetailTable> createState() => _CategoryDetailTableState();
}

class _CategoryDetailTableState extends State<CategoryDetailTable> {
  int number = 1;

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
            1: FixedColumnWidth(320),
            2: FlexColumnWidth()
          },
          children: [
            buildRow([Consts.number, Consts.categoryName, Consts.description],
                true, false),
            for (int i = 0; i < widget.widget.categories.length; i++) ...[
              buildRow([
                (number++).toString(),
                widget.widget.categories[i].categoryName,
                widget.widget.categories[i].description,
              ], false, i == widget.widget.categories.length - 1),
            ]
          ],
        ),
      ),
    );
  }
}

TableRow buildRow(List<String> cells, bool isHeader, bool isLastIndex) {
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
        return Padding(
          padding: const EdgeInsets.only(left: 16, top: 28, bottom: 28),
          child: Text(
            cell,
            style: isHeader ? AppFontStyle.wb80B20 : AppFontStyle.wb80R20,
            overflow: TextOverflow.ellipsis,
          ),
        );
      }).toList());
}

class Consts {
  static String listCategoryLabel = "List Category";
  static String addCategory = "Add Category";

  static String number = "No.";
  static String categoryName = "Category Name";
  static String description = "Description";
}
