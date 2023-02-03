import 'package:flutter/cupertino.dart';

class HelpDeskMainViewModel extends ChangeNotifier {
  String getName() {
    String name = "George";
    return name;
  }

  String convertToString(bool isStatus, int taskState) {
    if (isStatus) {
      switch (taskState) {
        case 0:
          return "Not start";
        case 1:
          return "Pending";
        case 2:
          return "Complete";
        default:
          return "Error";
      }
    }
    switch (taskState) {
      case 0:
        return "Low";
      case 1:
        return "Medium";
      case 2:
        return "Hight";
      case 3:
        return "Urgent";
      default:
        return "Error";
    }
  }
}
