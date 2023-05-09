import 'package:flutter/material.dart';
import 'package:senior_project/statistic/model/statistic_model.dart';
import 'package:senior_project/statistic/view/widget/date_filter.dart';
import 'package:senior_project/statistic/view/widget/response_time.dart';
import 'package:senior_project/statistic/view/widget/ticket_category_stacked.dart';
import 'package:senior_project/statistic/view/widget/ticket_priority.dart';
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
    List<PieChartModel> ticketPriority = widget.data[2].cast<PieChartModel>();
    List<StackBarChartModel> ticketCategoryStacked =
        widget.data[3].cast<StackBarChartModel>();
    List<SingleResultChart> defaultStatistic =
        widget.data[4].cast<SingleResultChart>();
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
            TotalTicket(
                title: "Total tickets today",
                totalTickets: defaultStatistic[0].data.toInt()),
            const SizedBox(width: 16),
            TotalTicket(
                title: "Total tickets this week",
                totalTickets: defaultStatistic[1].data.toInt()),
            const SizedBox(width: 16),
            TotalTicket(
                title: "Total tickets this Month",
                totalTickets: defaultStatistic[2].data.toInt()),
            const SizedBox(width: 16),
            ResponseTime(data: defaultStatistic[3])
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
          // Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          //   TicketStar(chartData: ticketRating, average: 4.21),
          //   const SizedBox(width: 16),
          //   TicketComment(ticketComment: comments)
          // ]),
        ],
      ),
    );
  }
}
