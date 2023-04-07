import 'package:flutter/material.dart';
import 'package:senior_project/assets/color_constant.dart';
import 'package:senior_project/assets/font_style.dart';
import 'package:senior_project/statistic/model/statistic_model.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class TicketStatus extends StatefulWidget {
  final List<PieChartModel> chartData;
  const TicketStatus({super.key, required this.chartData});

  @override
  State<TicketStatus> createState() => _TicketStatusState();
}

class _TicketStatusState extends State<TicketStatus> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: 1,
        child: Center(
            child: Container(
                decoration: BoxDecoration(
                    color: ColorConstant.white,
                    borderRadius: BorderRadius.circular(8.0)),
                child: SfCircularChart(
                    title: ChartTitle(
                        text: "Ticket status",
                        alignment: ChartAlignment.near,
                        textStyle: AppFontStyle.blackMd18),
                    series: <CircularSeries>[
                      // Renders doughnut chart
                      DoughnutSeries<PieChartModel, String>(
                          dataSource: widget.chartData,
                          // pointColorMapper:(PieChartModel data,  _) => data.color,
                          xValueMapper: (PieChartModel data, _) => data.title,
                          yValueMapper: (PieChartModel data, _) => data.data,
                          dataLabelMapper: (PieChartModel data, _) =>
                              data.title,
                          dataLabelSettings: const DataLabelSettings(
                              isVisible: true,
                              labelPosition: ChartDataLabelPosition.outside)),
                    ]))));
  }
}
