import 'package:flutter/material.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:senior_project/assets/color_constant.dart';
import 'package:senior_project/teacher_contact/model/teacher_contact_model.dart';

class MultiSelectSubject extends StatefulWidget {
  final String uid;
  final List<Subject> subjects;
  final Function(List<dynamic>) onConfirm;
  final List<Subject> initValue;
  const MultiSelectSubject(
      {super.key,
      required this.subjects,
      required this.uid,
      required this.onConfirm,
      required this.initValue});

  @override
  State<MultiSelectSubject> createState() => _MultiSelectSubjectState();
}

class _MultiSelectSubjectState extends State<MultiSelectSubject> {
  late List<Subject> selectedValues;

  @override
  void initState() {
    super.initState();
    selectedValues = widget.initValue;
  }

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
        final selectedList = await showDialog<List<Subject>>(
          context: context,
          builder: (context) => MultiSelectDialog<Subject>(
            items: widget.subjects
                .map((subject) => MultiSelectItem<Subject>(
                    subject, "${subject.id} - ${subject.name}"))
                .toList(),
            initialValue: selectedValues,
            searchable: true,
          ),
        );
        if (selectedList != null) {
          setState(() {
            selectedValues = selectedList;
          });
          widget.onConfirm(selectedValues);
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            if (selectedValues.isEmpty)
              const Text('Select Subjects')
            else
              ...selectedValues
                  .map(
                    (selectedValue) => Text(
                      '${selectedValue.id}, ',
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
