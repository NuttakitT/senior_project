import 'package:flutter/material.dart';
import 'package:senior_project/assets/color_constant.dart';
import 'package:senior_project/assets/font_style.dart';

class DateFilter extends StatefulWidget {
  const DateFilter({super.key});

  @override
  State<DateFilter> createState() => _DateFilterState();
}

class _DateFilterState extends State<DateFilter> {
  DateTime? _startDate;
  DateTime? _endDate;
  String _selectedOption = 'Today';

  final List<String> _options = [
    'Today',
    'This Week',
    'This Month',
  ];

  Future<void> _selectStartDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null && pickedDate != _startDate) {
      setState(() {
        _startDate = pickedDate;
      });
    }
  }

  Future<void> _selectEndDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null && pickedDate != _endDate) {
      setState(() {
        _endDate = pickedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        const DefaultTextStyle(
            style: AppFontStyle.wb90Md32, child: Text("Dashboard")),
        const Spacer(),
        GestureDetector(
          onTap: () => _selectStartDate(context),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: ColorConstant.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: ColorConstant.whiteBlack60),
            ),
            child: Text(
              _startDate != null
                  ? _startDate.toString().split(' ')[0]
                  : 'Start Date',
            ),
          ),
        ),
        const SizedBox(width: 16),
        GestureDetector(
          onTap: () => _selectEndDate(context),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: ColorConstant.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: ColorConstant.whiteBlack60),
            ),
            child: Text(
              _endDate != null ? _endDate.toString().split(' ')[0] : 'End Date',
            ),
          ),
        ),
        const SizedBox(width: 16),
        DropdownButton<String>(
          value: _selectedOption,
          onChanged: (String? newValue) {
            setState(() {
              _selectedOption = newValue!;
            });
          },
          items: _options.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      ],
    );
  }
}
