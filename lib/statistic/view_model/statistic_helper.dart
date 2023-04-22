import 'package:senior_project/statistic/model/statistic_model.dart';

class StatisticHelper {
  String getStatusTitle(int status) {
    switch (status) {
      case 0:
        return 'Not Started';
      case 1:
        return 'Pending';
      case 2:
        return 'Complete';
      default:
        return 'Unknown';
    }
  }

  String getPriorityTitle(int p) {
    switch (p) {
      case 0:
        return 'low';
      case 1:
        return 'medium';
      case 2:
        return 'high';
      case 3:
        return 'urgent';
      default:
        return 'Unknown';
    }
  }

  SingleResultChart formatDuration(Duration duration) {
    if (duration.inMinutes < 60) {
      // show duration in minutes if less than an hour
      return SingleResultChart(
          data: duration.inMinutes.toDouble(), detail: 'minutes');
    } else {
      // show duration in hours with two decimal points
      double hours = duration.inMinutes / 60.0;
      double hourswith2decimals = double.parse(hours.toStringAsFixed(2));
      return SingleResultChart(data: hourswith2decimals, detail: 'hours');
    }
  }
}
