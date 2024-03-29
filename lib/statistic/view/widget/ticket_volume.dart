import 'package:flutter/material.dart';
import 'package:senior_project/assets/color_constant.dart';
import 'package:senior_project/assets/font_style.dart';
import 'package:senior_project/statistic/model/statistic_model.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class TicketVolume extends StatefulWidget {
  final List<LineChartModel> chartData;
  const TicketVolume({super.key, required this.chartData});

  @override
  State<TicketVolume> createState() => _TicketVolumeState();
}

class _TicketVolumeState extends State<TicketVolume> {
  late TooltipBehavior _tooltipBehavior;

  @override
  void initState() {
    _tooltipBehavior = TooltipBehavior(
        enable: true, header: 'volume', format: 'point.y tickets');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: 2,
        child: Center(
            child: Container(
                decoration: BoxDecoration(
                    color: ColorConstant.white,
                    borderRadius: BorderRadius.circular(8.0)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SfCartesianChart(
                      title: ChartTitle(
                          text: "Ticket Volume",
                          alignment: ChartAlignment.near,
                          textStyle: AppFontStyle.blackMd18),
                      primaryXAxis: CategoryAxis(labelRotation: 90),
                      tooltipBehavior: _tooltipBehavior,
                      series: <ChartSeries>[
                        // Renders line chart
                        LineSeries<LineChartModel, String>(
                          dataSource: widget.chartData,
                          xValueMapper: (LineChartModel data, _) => data.x,
                          yValueMapper: (LineChartModel data, _) => data.y,
                          markerSettings: const MarkerSettings(isVisible: true),
                        )
                      ]),
                ))));
  }
}
