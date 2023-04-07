import 'package:flutter/material.dart';
import 'package:senior_project/assets/color_constant.dart';
import 'package:senior_project/assets/font_style.dart';
import 'package:senior_project/help_desk/help_desk_reply/view/widget/chat_input.dart';
import 'package:senior_project/statistic/model/statistic_model.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class TicketVolume extends StatefulWidget {
  final List<LineChartModel> chartData;
  const TicketVolume({super.key, required this.chartData});

  @override
  State<TicketVolume> createState() => _TicketVolumeState();
}

class _TicketVolumeState extends State<TicketVolume> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: 1,
        child: Center(
            child: Container(
                decoration: BoxDecoration(
                    color: ColorConstant.white,
                    borderRadius: BorderRadius.circular(8.0)),
                child: SfCartesianChart(
                    title: ChartTitle(
                        text: "Ticket Volume",
                        alignment: ChartAlignment.near,
                        textStyle: AppFontStyle.blackMd18),
                    series: <ChartSeries>[
                      // Renders line chart
                      LineSeries<LineChartModel, int>(
                          dataSource: widget.chartData,
                          xValueMapper: (LineChartModel data, _) => data.x,
                          yValueMapper: (LineChartModel data, _) => data.y)
                    ]))));
  }
}
