import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senior_project/assets/color_constant.dart';
import 'package:senior_project/core/template/template_desktop/view/page/template_desktop.dart';
import 'package:senior_project/core/view_model/app_view_model.dart';
import 'package:senior_project/statistic/model/statistic_model.dart';
import 'package:senior_project/statistic/view/widget/statistic_grid_view.dart';
import 'package:senior_project/statistic/view_model/statistic_view_model.dart';

class StatisticView extends StatefulWidget {
  final bool isAdmin;
  const StatisticView({super.key, required this.isAdmin});

  @override
  State<StatisticView> createState() => _StatisticViewState();
}

class _StatisticViewState extends State<StatisticView> {
  // StatisticModel data = StatisticModel(
  //     totalTicket: totalTicket,
  //     ticketVolume: ticketVolume,
  //     ticketStatus: ticketStatus,
  //     ticketPriority: ticketPriority,
  //     ticketCategory: ticketCategory,
  //     responseTime: responseTime,
  //     ticketStar: ticketStar
  //     );
  List<List<Chart>> data = [
    // ticket volume
    [
      LineChartModel(x: 1, y: 2),
      LineChartModel(x: 2, y: 2),
      LineChartModel(x: 3, y: 7),
      LineChartModel(x: 4, y: 20),
      LineChartModel(x: 5, y: 18),
      LineChartModel(x: 6, y: 4),
      LineChartModel(x: 7, y: 6),
      LineChartModel(x: 8, y: 12),
      LineChartModel(x: 9, y: 8),
      LineChartModel(x: 10, y: 21),
      LineChartModel(x: 11, y: 0),
      LineChartModel(x: 12, y: 0),
      LineChartModel(x: 13, y: 5),
      LineChartModel(x: 14, y: 13),
      LineChartModel(x: 15, y: 1),
      LineChartModel(x: 16, y: 22),
      LineChartModel(x: 17, y: 20),
      LineChartModel(x: 18, y: 18),
      LineChartModel(x: 19, y: 4),
      LineChartModel(x: 20, y: 6),
      LineChartModel(x: 21, y: 12),
      LineChartModel(x: 22, y: 8),
      LineChartModel(x: 23, y: 21),
      LineChartModel(x: 24, y: 0),
      LineChartModel(x: 25, y: 0),
      LineChartModel(x: 26, y: 5),
      LineChartModel(x: 27, y: 13),
      LineChartModel(x: 28, y: 1),
      LineChartModel(x: 29, y: 22),
    ],
    [
      PieChartModel(title: "Not started", data: 12),
      PieChartModel(title: "Pending", data: 20),
      PieChartModel(title: "Done", data: 35),
      PieChartModel(title: "Failed", data: 2),
    ],
    [
      LineChartModel(x: 1, y: 2.1),
      LineChartModel(x: 2, y: 2.5),
      LineChartModel(x: 3, y: 7.3),
      LineChartModel(x: 4, y: 20.1),
    ],
    [
      PieChartModel(title: "low", data: 14),
      PieChartModel(title: "mid", data: 2),
      PieChartModel(title: "high", data: 20),
      PieChartModel(title: "urgent", data: 1),
    ],
    // [
    //   BarChartModel(xAxis: "xAxis", amount: 12),
    //   BarChartModel(xAxis: "xAxis2", amount: 22),
    //   BarChartModel(xAxis: "xAxis3", amount: 2),
    //   BarChartModel(xAxis: "xAxis4", amount: 7),
    //   BarChartModel(xAxis: "xAxis5", amount: 2),
    //   BarChartModel(xAxis: "xAxis33", amount: 12),
    //   BarChartModel(xAxis: "xAxis233", amount: 22),
    //   BarChartModel(xAxis: "xAxis33", amount: 2),
    //   BarChartModel(xAxis: "xAxis433", amount: 7),
    //   BarChartModel(xAxis: "xAxis533", amount: 2),
    // ],
    [
      StackBarChartModel(xAxis: "xAxis", y1: 3, y2: 4, y3: 2, y4: 1),
      StackBarChartModel(xAxis: "xAxis2", y1: 9, y2: 1, y3: 3, y4: 1),
      StackBarChartModel(xAxis: "xAxis3", y1: 0, y2: 5, y3: 12, y4: 1),
      StackBarChartModel(xAxis: "xAxis4", y1: 3, y2: 0, y3: 9, y4: 12),
      StackBarChartModel(xAxis: "xAxis5", y1: 0, y2: 0, y3: 20, y4: 1),
    ],

    [SingleResultChart(data: 1.37, detail: "hours")],
    [
      BarChartModel(xAxis: "5", amount: 12),
      BarChartModel(xAxis: "4", amount: 22),
      BarChartModel(xAxis: "3", amount: 2),
      BarChartModel(xAxis: "2", amount: 7),
      BarChartModel(xAxis: "1", amount: 2),
    ],
  ];

  List<TicketCommentModel> comments = [
    TicketCommentModel(
        stars: 4,
        ticketId: "012",
        title: "title",
        comment: "comment",
        date: "12-12-2012"),
    TicketCommentModel(
        stars: 3,
        ticketId: "014",
        title: "title",
        comment: "comment",
        date: "13-12-1212"),
    TicketCommentModel(
        stars: 3,
        ticketId: "015",
        title: "title",
        comment: "comment",
        date: "13-12-1212"),
    TicketCommentModel(
        stars: 5,
        ticketId: "017",
        title: "title",
        comment: "comment",
        date: "13-12-1212"),
    TicketCommentModel(
        stars: 2,
        ticketId: "018",
        title: "title",
        comment: "comment",
        date: "13-12-1212"),
    TicketCommentModel(
        stars: 4,
        ticketId: "012",
        title: "title",
        comment: "comment",
        date: "12-12-2012"),
    TicketCommentModel(
        stars: 3,
        ticketId: "014",
        title: "title",
        comment: "comment",
        date: "13-12-1212"),
    TicketCommentModel(
        stars: 3,
        ticketId: "015",
        title: "title",
        comment: "comment",
        date: "13-12-1212"),
    TicketCommentModel(
        stars: 5,
        ticketId: "017",
        title: "title",
        comment: "comment",
        date: "13-12-1212"),
    TicketCommentModel(
        stars: 2,
        ticketId: "018",
        title: "title",
        comment: "comment",
        date: "13-12-1212"),
  ];

  List<double> parameters = [];
  @override
  Widget build(BuildContext context) {
    bool isMobileSite = context
        .watch<AppViewModel>()
        .getMobileSiteState(MediaQuery.of(context).size.width);
    if (widget.isAdmin && !isMobileSite) {
      return FutureBuilder(
          future: context.read<StatisticViewModel>().fetchPage(),
          builder: ((context, snapshot) {
            if (snapshot.hasError) {
              return Text('Has error ${snapshot.error}');
            }
            if (snapshot.connectionState == ConnectionState.done) {
              // final admins = snapshot.data?.admins ?? [];
              // final categories = snapshot.data?.categories ?? [];
              return TemplateDesktop(
                  helpdesk: false,
                  helpdeskadmin: false,
                  home: false,
                  useTemplatescroll: true,
                  content: SingleChildScrollView(
                    child: Column(
                      children: [
                        StatisticGridView(
                          data: data,
                          commentData: comments,
                        )
                      ],
                    ),
                  ));
            }
            return const Center(
              child: SizedBox(
                width: 100,
                height: 100,
                child: CircularProgressIndicator(),
              ),
            );
          }));
    } else {
      return Container();
    }
  }
}
