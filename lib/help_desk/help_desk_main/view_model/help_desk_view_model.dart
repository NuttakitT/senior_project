import 'package:flutter/foundation.dart';
import 'package:senior_project/help_desk/help_desk_main/model/help_desk_main_model.dart';

class HelpDeskViewModel extends ChangeNotifier {
  HelpDeskModel helpDeskModel = HelpDeskModel();

  List<bool> mobileMenuState = [true, false, false, false];

  bool? getMobileMenuState(int index) {
    if (index >= 0 && index < 4) {
      return mobileMenuState[index];
    }
    return null;
  }

  void changeMobileMenuState(int index) {
    if (index >= 0 && index < 4) {
      int currentIndex = mobileMenuState.indexOf(true);
      if (currentIndex != index) {
        mobileMenuState[currentIndex] = false;
        mobileMenuState[index] = true;
        notifyListeners();
      }
    }
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
