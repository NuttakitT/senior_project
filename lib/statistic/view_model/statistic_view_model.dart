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

  // fetchDefaultStatistic is for query result of
  // [0] total tickets today (tickets)
  // [1] total tickets this week (tickets)
  // [2] total tickets this month (tickets)
  // [3] average response time (time unit)
  Future<List<SingleResultChart>> fetchDefaultStatistics() async {
    List<SingleResultChart> list = [];
    DateTime today = DateTime(now.year, now.month, now.day, 0, 0, 0);
    DateTime startOfWeek = now.subtract(Duration(days: now.weekday - 1));
    DateTime startOfMonth = DateTime(now.year, now.month, 1);

    final todayTicket = await _service.getDocumentByDateInterval(today, now);
    int todayTicketCount = todayTicket?.docs.length ?? 0;
    list.add(
        SingleResultChart(data: todayTicketCount.toDouble(), detail: 'ticket'));

    final weekTicket =
        await _service.getDocumentByDateInterval(startOfWeek, now);
    int weekTicketCount = weekTicket?.docs.length ?? 0;
    list.add(
        SingleResultChart(data: weekTicketCount.toDouble(), detail: 'ticket'));

    final monthTicket =
        await _service.getDocumentByDateInterval(startOfMonth, now);
    int monthTicketCount = monthTicket?.docs.length ?? 0;
    list.add(
        SingleResultChart(data: monthTicketCount.toDouble(), detail: 'ticket'));

    final averageTicketTime = await fetchAverageTicketTime();
    final formattedaverageTicketTime = helper.formatDuration(averageTicketTime);
    list.add(SingleResultChart(
        data: formattedaverageTicketTime.data,
        detail: formattedaverageTicketTime.detail));

    return list;
  }

  Future<Duration> fetchAverageTicketTime() async {
    final snapshot = await _service.getAllDocument();

    int totalMilliseconds = 0;
    int numTickets = 0;

    snapshot?.docs.forEach((doc) {
      Timestamp startTimestamp = doc['dateCreate'];
      Timestamp endTimestamp = doc['dateComplete'];

      if (startTimestamp != null && endTimestamp != null) {
        DateTime startTime = startTimestamp.toDate();
        DateTime endTime = endTimestamp.toDate();

        Duration difference = endTime.difference(startTime);
        totalMilliseconds += difference.inMilliseconds;
        numTickets++;
      }
    });

    Duration averageTime = const Duration(milliseconds: 0);
    if (numTickets > 0) {
      averageTime = Duration(milliseconds: totalMilliseconds ~/ numTickets);
    }

    return averageTime;
  }

  Future<Map<String, List<int>>> fetchTicketCategory() async {
    final snapshot = await _service.getAllDocument();
    Map<String, Map<String, int>> dataMap = {};

    snapshot?.docs.forEach((doc) {
      String? category = doc['category'];
      int? status = doc['status'];

      if (category == null || status == null) {
        return;
      }

      if (dataMap[category] == null) {
        dataMap[category] = {
          'Not Started': 0,
          'Pending': 0,
          'Complete': 0,
        };
      }

      if (status == 0) {
        dataMap[category]!['Not Started'] ??= 0;
        dataMap[category]!['Not Started'] =
            dataMap[category]!['Not Started']! + 1;
      } else if (status == 1) {
        dataMap[category]!['Pending'] ??= 0;
        dataMap[category]!['Pending'] = dataMap[category]!['Pending']! + 1;
      } else if (status == 2) {
        dataMap[category]!['Complete'] ??= 0;
        dataMap[category]!['Complete'] = dataMap[category]!['Complete']! + 1;
      }
    });
    Map<String, List<int>> dataList = {};
    // List<List<int>> dataList = [];
    dataMap.forEach((category, statusMap) {
      List<int> categoryData = [];
      statusMap.forEach((status, count) {
        categoryData.add(count);
      });
      dataList[category] = categoryData;
      // dataList.add(categoryData);
    });
    return dataList;
  }

  Future<List<StackBarChartModel>> fetchTicketCategoryData() async {
    Map<String, List<int>> dataList = await fetchTicketCategory();

    List<StackBarChartModel> chartData = [];
    dataList.forEach((category, categoryData) {
      StackBarChartModel model = StackBarChartModel(
        xAxis: category,
        y1: categoryData[0].toDouble(),
        y2: categoryData[1].toDouble(),
        y3: categoryData[2].toDouble(),
        y4: 0.0, // set y4 to 0.0 since it's not used in the data list
      );
      chartData.add(model);
    });

    return chartData;
  }

  Future<StatisticModel> fetchPage() async {
    final model = StatisticModel(
        ticketVolume: await fetchTicketVolume(),
        ticketStatus: await fetchTicketStatus(),
        ticketPriority: await fetchTicketPriority(),
        defaultStatistics: await fetchDefaultStatistics(),
        ticketByCategories: await fetchTicketCategoryData());
    return model;
  }
}
