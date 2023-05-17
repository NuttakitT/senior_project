import 'package:flutter/material.dart';
import 'package:senior_project/facility/model/facility_model.dart';

class DropDownForm extends StatefulWidget {
  final List<ItemModel> items;
  const DropDownForm({super.key, required this.items});

  @override
  State<DropDownForm> createState() => _DropDownFormState();
}

class _DropDownFormState extends State<DropDownForm> {
  ItemModel? selectedOption;
  @override
  Widget build(BuildContext context) {
    if (widget.items.isEmpty) {
      return Container();
    }

    return DropdownButton<ItemModel>(
      value: selectedOption,
      onChanged: (ItemModel? newValue) {
        setState(() {
          selectedOption = newValue!;
        });
      },
      items: widget.items.map((ItemModel option) {
        return DropdownMenuItem<ItemModel>(
          value: option,
          child: Text(option.objectName),
        );
      }).toList(),
      icon: const Icon(Icons.arrow_drop_down),
    );
  }
}
