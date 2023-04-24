import 'package:flutter/material.dart';
import 'package:senior_project/assets/color_constant.dart';
import 'package:senior_project/assets/font_style.dart';
import 'package:senior_project/statistic/model/statistic_model.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class TicketPriority extends StatefulWidget {
  final List<PieChartModel> chartData;
  const TicketPriority({super.key, required this.chartData});

  @override
  State<TicketPriority> createState() => _TicketPriorityState();
}

class _TicketPriorityState extends State<TicketPriority> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: 1,
        child: Center(
            child: Container(
                decoration: BoxDecoration(
                    color: ColorConstant.white,
                    borderRadius: BorderRadius.circular(8.0)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SfCircularChart(
                      palette: const [
                        ColorConstant.blue40,
                        ColorConstant.green40,
                        ColorConstant.yellow40,
                        ColorConstant.red40
                      ],
                      title: ChartTitle(
                          text: "Ticket Priority",
                          alignment: ChartAlignment.near,
                          textStyle: AppFontStyle.blackMd18),
                      series: <CircularSeries>[
                        // Renders doughnut chart
                        DoughnutSeries<PieChartModel, String>(
                            dataSource: widget.chartData,
                            // pointColorMapper: (PieChartModel data, _) =>
                            //     data.color,
                            xValueMapper: (PieChartModel data, _) => data.title,
                            yValueMapper: (PieChartModel data, _) => data.data,
                            dataLabelMapper: (PieChartModel data, _) =>
                                data.title,
                            dataLabelSettings: const DataLabelSettings(
                                isVisible: true,
                                labelPosition: ChartDataLabelPosition.outside)),
                      ]),
                ))));
  }
}
