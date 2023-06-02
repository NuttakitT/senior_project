import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senior_project/assets/color_constant.dart';
import 'package:senior_project/assets/font_style.dart';
import 'package:senior_project/facility/view_model/facility_view_model.dart';

class RoomDateFilterView extends StatefulWidget {
  const RoomDateFilterView({super.key});

  @override
  State<RoomDateFilterView> createState() => _RoomDateFilterViewState();
}

class _RoomDateFilterViewState extends State<RoomDateFilterView> {
  DateTime? _startDate;
  DateTime? _endDate;

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
        context.read<FacilityViewModel>().setStartDate(_startDate);
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
        context.read<FacilityViewModel>().setEndDate(_endDate);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    _startDate = context.read<FacilityViewModel>().startDate;
    _endDate = context.read<FacilityViewModel>().endDate;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 64, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const DefaultTextStyle(
              style: AppFontStyle.wb90Md32, child: Text("Dashboard")),
          const Spacer(),
          GestureDetector(
            onTap: () {
              _selectStartDate(context);
            },
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
            onTap: () {
              _selectEndDate(context);
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: ColorConstant.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: ColorConstant.whiteBlack60),
              ),
              child: Text(
                _endDate != null
                    ? _endDate.toString().split(' ')[0]
                    : 'End Date',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
