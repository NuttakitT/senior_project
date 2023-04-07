import 'package:flutter/material.dart';
import 'package:senior_project/statistic/model/statistic_model.dart';
import 'package:senior_project/statistic/view/widget/date_filter.dart';
import 'package:senior_project/statistic/view/widget/ticket_status.dart';
import 'package:senior_project/statistic/view/widget/ticket_volume.dart';

class StatisticGridView extends StatefulWidget {
  final List<List<Chart>> data;
  const StatisticGridView({super.key, required this.data});

  @override
  State<StatisticGridView> createState() => _StatisticGridViewState();
}

class _StatisticGridViewState extends State<StatisticGridView> {
  @override
  Widget build(BuildContext context) {
    // casting here
    List<LineChartModel> ticketVolume = widget.data[0].cast<LineChartModel>();
    List<PieChartModel> ticketStatus = widget.data[1].cast<PieChartModel>();
    // end casting
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 64.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        // all the charts will be below here and each chart should be in each file in the widget folder.
        children: [
          const DateFilter(),
          Row(children: [
            TicketVolume(chartData: ticketVolume),
            const SizedBox(width: 16),
            TicketStatus(chartData: ticketStatus)
          ]),
          const SizedBox(height: 16),
          Row(children: []),
          Row(children: []),
        ],
      ),
    );
  }
}
