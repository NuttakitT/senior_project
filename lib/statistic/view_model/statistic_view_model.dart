import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:senior_project/core/datasource/firebase_services.dart';
import 'package:senior_project/statistic/model/statistic_model.dart';
import 'package:senior_project/statistic/view_model/statistic_helper.dart';

class StatisticViewModel extends ChangeNotifier {
  final helper = StatisticHelper();
  final DateTime now = DateTime.now();
  final DateTime last30days = DateTime.now().subtract(const Duration(days: 30));
  final FirebaseServices _service = FirebaseServices("ticket");

  Future<List<LineChartModel>> fetchTicketVolume() async {
    final snapshot = await _service.getDocumentByDateInterval(last30days, now);
    Map<DateTime, int> ticketVolumeData = {};

    snapshot?.docs.forEach((doc) {
      DateTime date = doc['dateCreate'].toDate();
      DateTime day = DateTime(date.year, date.month, date.day);
      ticketVolumeData.update(day, (value) => value + 1, ifAbsent: () => 1);
    });
    List<DateTime> allDates = [];
    DateTime currentDate = last30days;
    while (currentDate.isBefore(now) || currentDate.isAtSameMomentAs(now)) {
      DateTime currentDateOnly =
          DateTime(currentDate.year, currentDate.month, currentDate.day);
      allDates.add(currentDateOnly);
      currentDate = currentDate.add(Duration(days: 1));
    }
    Map<DateTime, int> mergedData = {};
    allDates.forEach((date) {
      int ticketCount = ticketVolumeData[date] ?? 0;
      mergedData[date] = ticketCount;
    });

    return mergedData.entries
        .map((entry) => LineChartModel(
            x: DateFormat('d/M').format(entry.key), y: entry.value.toDouble()))
        .toList();
  }

  Future<List<PieChartModel>> fetchTicketStatus() async {
    final snapshot = await _service.getAllDocument();

    Map<int, int> ticketStatusData = {
      0: 0, // not started
      1: 0, // pending
      2: 0, // complete
    };

    snapshot?.docs.forEach((doc) {
      int status = doc['status'];
      if (ticketStatusData.containsKey(status)) {
        ticketStatusData[status] = ticketStatusData[status]! + 1;
      }
    });

    List<PieChartModel> pieChartData = [];
    ticketStatusData.forEach((status, count) {
      String statusTitle = helper.getStatusTitle(status);
      pieChartData
          .add(PieChartModel(title: statusTitle, data: count.toDouble()));
    });

    return pieChartData;
  }

  Future<List<PieChartModel>> fetchTicketPriority() async {
    final snapshot = await _service.getAllDocument();

    Map<int, int> ticketPriorityData = {
      0: 0, // l
      1: 0, // m
      2: 0, // h
      3: 0 // urg
    };

    snapshot?.docs.forEach((doc) {
      int priority = doc['priority'];
      if (ticketPriorityData.containsKey(priority)) {
        ticketPriorityData[priority] = ticketPriorityData[priority]! + 1;
      }
    });

    List<PieChartModel> pieChartData = [];
    ticketPriorityData.forEach((priority, count) {
      String statusTitle = helper.getPriorityTitle(priority);
      pieChartData
          .add(PieChartModel(title: statusTitle, data: count.toDouble()));
    });

    return pieChartData;
  }

  Future<StatisticModel> fetchPage() async {
    final model = StatisticModel(
        ticketVolume: await fetchTicketVolume(),
        ticketStatus: await fetchTicketStatus(),
        ticketPriority: await fetchTicketPriority());
    return model;
  }
}
