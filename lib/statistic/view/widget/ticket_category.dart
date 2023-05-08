import 'package:flutter/material.dart';
import 'package:senior_project/assets/color_constant.dart';
import 'package:senior_project/assets/font_style.dart';
import 'package:senior_project/statistic/model/statistic_model.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class TicketCategory extends StatefulWidget {
  final List<BarChartModel> chartData;
  const TicketCategory({super.key, required this.chartData});

  @override
  State<TicketCategory> createState() => _TicketCategoryState();
}

class _TicketCategoryState extends State<TicketCategory> {
  @override
  void initState() {
    super.initState();
    widget.chartData.sort((a, b) => a.amount.compareTo(b.amount));
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
                      title: ChartTitle(
                          text: "Ticket by Category",
                          alignment: ChartAlignment.near,
                          textStyle: AppFontStyle.blackMd18),
                      primaryXAxis: CategoryAxis(),
                      isTransposed: true,
                      series: <ChartSeries<BarChartModel, String>>[
                        // Renders column chart
                        ColumnSeries<BarChartModel, String>(
                          dataSource: widget.chartData,
                          xValueMapper: (BarChartModel data, _) => data.xAxis,
                          yValueMapper: (BarChartModel data, _) => data.amount,
                        )
                      ]),
                ))));
  }
}
