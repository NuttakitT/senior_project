import 'package:flutter/widgets.dart';
import 'package:senior_project/assets/color_constant.dart';
import 'package:senior_project/assets/font_style.dart';
import 'package:senior_project/statistic/model/statistic_model.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class TicketStar extends StatefulWidget {
  final List<BarChartModel> chartData;
  final double average;
  const TicketStar({super.key, required this.chartData, required this.average});

  @override
  State<TicketStar> createState() => _TicketStarState();
}

class _TicketStarState extends State<TicketStar> {
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
                  child: SfCartesianChart(
                      palette: const [ColorConstant.yellow40],
                      title: ChartTitle(
                          text: "Review (average ${widget.average} stars)",
                          alignment: ChartAlignment.near,
                          textStyle: AppFontStyle.blackMd18),
                      primaryXAxis: CategoryAxis(),
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
