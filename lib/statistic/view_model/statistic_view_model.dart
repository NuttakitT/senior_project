import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:senior_project/core/datasource/firebase_services.dart';
import 'package:senior_project/statistic/model/statistic_model.dart';

class StatisticViewModel extends ChangeNotifier {
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

  Future<StatisticModel> fetchPage() async {
    final model = StatisticModel(ticketVolume: await fetchTicketVolume());
    return model;
  }
}
