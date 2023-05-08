// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:provider/provider.dart';
import 'package:senior_project/assets/color_constant.dart';
import 'package:senior_project/role_management/model/role_management_model.dart';
import 'package:senior_project/role_management/view_model/role_management_view_model.dart';

class MultiSelectTopics extends StatefulWidget {
  final String uid;
  final List<TopicCategory> topics;
  final List<TopicCategory> adminResponsibility;
  const MultiSelectTopics({super.key, required this.topics, required this.uid, required this.adminResponsibility});

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
              .changeResponsibility(widget.uid, selectedList);
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: SizedBox(
          width: 600,
          child: Builder(
            builder: (context) {
              if (selectedValues.isEmpty && widget.adminResponsibility.isEmpty) {
                return const Text('Select...');
              } else {
                List<TopicCategory> topic = [];
                if (widget.adminResponsibility.isNotEmpty) {
                  topic = widget.adminResponsibility;
                }
                if (selectedValues.isNotEmpty) {
                  topic = selectedValues;
                }
                String text = "";
                for (int i = 0; i < topic.length; i++) {
                  text = "$text${topic[i].categoryName}, ";
                }
                return RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: text,
                        style: const TextStyle(color: ColorConstant.whiteBlack60),
                      )
                    ]
                  ),
                );
              }
            },
          )
        ),
      ),
    );
  }
}
