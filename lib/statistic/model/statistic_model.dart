class StatisticModel {
  List<LineChartModel>? ticketVolume;
  List<PieChartModel>? ticketStatus;
  List<PieChartModel>? ticketPriority;

  StatisticModel({
    required this.ticketVolume,
    required this.ticketStatus,
    required this.ticketPriority,
  });
}

class Chart {}

class LineChartModel extends Chart {
  int x;
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
