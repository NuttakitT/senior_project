import 'package:flutter/material.dart';
import 'package:senior_project/statistic/view/widget/ticket_category.dart';

// class StatisticModel {
//   int totalTicket;
//   List<LineChartModel>? ticketVolume;
//   List<PieChartModel>? ticketStatus;
//   List<PieChartModel>? ticketPriority;
//   List<BarChartModel>? ticketCategory;
//   List<SingleResultChart>? responseTime;
//   List<BarChartModel>? ticketStar;

//   StatisticModel(
//       {required this.totalTicket,
//       required this.ticketVolume,
//       required this.ticketStatus,
//       required this.ticketPriority,
//       required this.ticketCategory,
//       required this.responseTime,
//       required this.ticketStar});
// }

class StatisticModel {
  List<LineChartModel> ticketVolume = [];
  List<PieChartModel> ticketStatus = [];
  List<PieChartModel> ticketPriority = [];

  List<SingleResultChart> defaultStatistics = [];

  List<StackBarChartModel> ticketByCategories = [];

  StatisticModel(
      {required this.ticketVolume,
      required this.ticketStatus,
      required this.ticketPriority,
      required this.defaultStatistics,
      required this.ticketByCategories});
}

class TicketCommentModel {
  int stars;
  String ticketId;
  String title;
  String comment;
  String date;

  TicketCommentModel(
      {required this.stars,
      required this.ticketId,
      required this.title,
      required this.comment,
      required this.date});
}

class Chart {}

class LineChartModel extends Chart {
  String x;
  double y;

  LineChartModel({required this.x, required this.y});
}

class PieChartModel extends Chart {
  String title;
  double data;

  PieChartModel({required this.title, required this.data});
}

class BarChartModel extends Chart {
  String xAxis;
  double amount;

  BarChartModel({required this.xAxis, required this.amount});
}

class StackBarChartModel extends Chart {
  String xAxis;
  double y1;
  double y2;
  double y3;
  double y4;

  StackBarChartModel(
      {required this.xAxis,
      required this.y1,
      required this.y2,
      required this.y3,
      required this.y4});
}

class SingleResultChart extends Chart {
  double data;
  String detail;

  SingleResultChart({required this.data, required this.detail});
}
