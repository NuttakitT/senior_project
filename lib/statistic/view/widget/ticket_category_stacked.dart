import 'package:flutter/material.dart';
import 'package:senior_project/assets/color_constant.dart';
import 'package:senior_project/assets/font_style.dart';
import 'package:senior_project/statistic/model/statistic_model.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class TicketCategoryStacked extends StatefulWidget {
  final List<StackBarChartModel> chartData;
  const TicketCategoryStacked({super.key, required this.chartData});

  @override
  State<TicketCategoryStacked> createState() => _TicketCategoryStackedState();
}

class _TicketCategoryStackedState extends State<TicketCategoryStacked> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: widget.chartData.length >= 5 ? 2 : 1,
        child: Center(
            child: Container(
                decoration: BoxDecoration(
                    color: ColorConstant.white,
                    borderRadius: BorderRadius.circular(8.0)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SfCartesianChart(
                    palette: const [
                      ColorConstant.whiteBlack40,
                      ColorConstant.yellow40,
                      ColorConstant.green40,
                    ],
                    title: ChartTitle(
                        text: "Ticket by Category",
                        alignment: ChartAlignment.near,
                        textStyle: AppFontStyle.blackMd18),
                    isTransposed: true,
                    primaryXAxis: CategoryAxis(),
                    series: <ChartSeries>[
                      StackedColumnSeries<StackBarChartModel, String>(
                          dataLabelSettings: const DataLabelSettings(
                              isVisible: true, showCumulativeValues: false),
                          dataSource: widget.chartData,
                          xValueMapper: (StackBarChartModel data, _) =>
                              data.xAxis,
                          yValueMapper: (StackBarChartModel data, _) => data.y1,
                          name: "Not started"),
                      StackedColumnSeries<StackBarChartModel, String>(
                          dataLabelSettings: const DataLabelSettings(
                              isVisible: true, showCumulativeValues: false),
                          dataSource: widget.chartData,
                          xValueMapper: (StackBarChartModel data, _) =>
                              data.xAxis,
                          yValueMapper: (StackBarChartModel data, _) => data.y2,
                          name: "In progress"),
                      StackedColumnSeries<StackBarChartModel, String>(
                          dataLabelSettings: const DataLabelSettings(
                              isVisible: true, showCumulativeValues: false),
                          dataSource: widget.chartData,
                          xValueMapper: (StackBarChartModel data, _) =>
                              data.xAxis,
                          yValueMapper: (StackBarChartModel data, _) => data.y3,
                          name: "Done"),
                    ],
                    legend: Legend(
                      isVisible: true,
                      position: LegendPosition.right,
                      overflowMode: LegendItemOverflowMode.wrap,
                    ),
                  ),
                ))));
  }
}
