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
}
