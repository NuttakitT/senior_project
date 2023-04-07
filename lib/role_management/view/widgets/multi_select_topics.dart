import 'package:flutter/material.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:provider/provider.dart';
import 'package:senior_project/assets/color_constant.dart';
import 'package:senior_project/role_management/model/role_management_model.dart';
import 'package:senior_project/role_management/view_model/role_management_view_model.dart';

class MultiSelectTopics extends StatefulWidget {
  final List<TopicCategory> topics;
  const MultiSelectTopics({super.key, required this.topics});

  @override
  State<MultiSelectTopics> createState() => _MultiSelectTopicsState();
}

class _MultiSelectTopicsState extends State<MultiSelectTopics> {
  List<TopicCategory> selectedValues = [];

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(ColorConstant.whiteBlack5),
        foregroundColor: MaterialStateProperty.all(ColorConstant.whiteBlack60),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
      onPressed: () async {
        final selectedList = await showDialog<List<TopicCategory>>(
          context: context,
          builder: (context) => MultiSelectDialog<TopicCategory>(
            items: widget.topics
                .map((topic) =>
                    MultiSelectItem<TopicCategory>(topic, topic.categoryName))
                .toList(),
            initialValue: selectedValues,
            searchable: true,
          ),
        );

        if (selectedList != null) {
          setState(() {
            selectedValues = selectedList;
          });

          context
              .read<RoleManagementViewModel>()
              .changeResponsibility(selectedList);
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            if (selectedValues.isEmpty)
              const Text('Select...')
            else
              ...selectedValues
                  .map(
                    (selectedValue) => Text(
                      '${selectedValue.categoryName}, ',
                      style: const TextStyle(color: ColorConstant.whiteBlack60),
                    ),
                  )
                  .toList(),
            const Spacer(),
            const Icon(Icons.expand_more),
          ],
        ),
      ),
    );
  }
}
