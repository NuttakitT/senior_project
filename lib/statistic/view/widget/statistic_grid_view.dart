import 'package:flutter/material.dart';
import 'package:senior_project/statistic/model/statistic_model.dart';
import 'package:senior_project/statistic/view/widget/date_filter.dart';
import 'package:senior_project/statistic/view/widget/response_time.dart';
import 'package:senior_project/statistic/view/widget/ticket_category.dart';
import 'package:senior_project/statistic/view/widget/ticket_category_stacked.dart';
import 'package:senior_project/statistic/view/widget/ticket_comment.dart';
import 'package:senior_project/statistic/view/widget/ticket_handling_time.dart';
import 'package:senior_project/statistic/view/widget/ticket_priority.dart';
import 'package:senior_project/statistic/view/widget/ticket_star.dart';
import 'package:senior_project/statistic/view/widget/ticket_status.dart';
import 'package:senior_project/statistic/view/widget/ticket_volume.dart';
import 'package:senior_project/statistic/view/widget/total_ticket.dart';

class StatisticGridView extends StatefulWidget {
  final List<List<Chart>> data;
  final List<TicketCommentModel> commentData;
  const StatisticGridView(
      {super.key, required this.data, required this.commentData});

  @override
  State<StatisticGridView> createState() => _StatisticGridViewState();
}

class _StatisticGridViewState extends State<StatisticGridView> {
  @override
  Widget build(BuildContext context) {
    // casting here
    List<LineChartModel> ticketVolume = widget.data[0].cast<LineChartModel>();
    List<PieChartModel> ticketStatus = widget.data[1].cast<PieChartModel>();
    List<PieChartModel> ticketPriority = widget.data[3].cast<PieChartModel>();
    List<StackBarChartModel> ticketCategoryStacked =
        widget.data[4].cast<StackBarChartModel>();
    List<SingleResultChart> responseTime =
        widget.data[5].cast<SingleResultChart>();
    List<BarChartModel> ticketRating = widget.data[6].cast<BarChartModel>();
    List<TicketCommentModel> comments = widget.commentData;
    // end casting
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 64.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        // all the charts will be below here and each chart should be in each file in the widget folder.
        children: [
          const DateFilter(),
          const SizedBox(height: 24),
          Row(children: [
            const TotalTicket(title: "Total tickets today", totalTickets: 15),
            const SizedBox(width: 16),
            const TotalTicket(
                title: "Total tickets this week", totalTickets: 42),
            const SizedBox(width: 16),
            const TotalTicket(
                title: "Total tickets this Month", totalTickets: 230),
            const SizedBox(width: 16),
            ResponseTime(data: responseTime[0])
          ]),
          const SizedBox(height: 16),
          Row(children: [
            TicketVolume(chartData: ticketVolume),
            const SizedBox(width: 16),
            Expanded(
                flex: 2,
                child: Row(
                  children: [
                    TicketStatus(chartData: ticketStatus),
                    const SizedBox(width: 16),
                    // TicketHandlingTime(chartData: ticketHandlingTime),
                    // const SizedBox(width: 16),
                    TicketPriority(chartData: ticketPriority)
                  ],
                )),
          ]),
          const SizedBox(height: 16),
          Row(children: [
            // TicketCategory(chartData: ticketCategory),
            TicketCategoryStacked(chartData: ticketCategoryStacked)
            // const SizedBox(width: 16),
          ]),
          const SizedBox(height: 16),
          Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            TicketStar(chartData: ticketRating, average: 4.21),
            const SizedBox(width: 16),
            TicketComment(ticketComment: comments)
          ]),
        ],
      ),
    );
  }
}
