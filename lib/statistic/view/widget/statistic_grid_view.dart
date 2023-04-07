import 'package:flutter/material.dart';
import 'package:senior_project/statistic/model/statistic_model.dart';
import 'package:senior_project/statistic/view/widget/date_filter.dart';

class StatisticGridView extends StatefulWidget {
  final List<Chart> data;
  const StatisticGridView({super.key, required this.data});

  @override
  State<StatisticGridView> createState() => _StatisticGridViewState();
}

class _StatisticGridViewState extends State<StatisticGridView> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 64.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        // all the charts will be below here and each chart should be in each file in the widget folder.
        children: [
          const DateFilter(),
          Row(children: []),
          Row(children: []),
          Row(children: []),
        ],
      ),
    );
  }
}
