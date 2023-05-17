import 'package:flutter/material.dart';
import 'package:senior_project/facility/model/facility_model.dart';

class DropDownForm extends StatefulWidget {
  final List<ItemModel> items;
  final ValueChanged<ItemModel?> onChanged;

  const DropDownForm({Key? key, required this.items, required this.onChanged})
      : super(key: key);

  @override
  State<DropDownForm> createState() => _DropDownFormState();
}

class _DropDownFormState extends State<DropDownForm> {
  ItemModel? selectedOption;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<ItemModel>(
      // value: selectedOption ?? ,
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (ItemModel? value) {
        setState(() {
          selectedOption = value!;
        });
      },
      items: widget.items.map<DropdownMenuItem<ItemModel>>((ItemModel value) {
        return DropdownMenuItem<ItemModel>(
          value: value,
          child: Text(value.objectName),
        );
      }).toList(),
    );
  }
}
