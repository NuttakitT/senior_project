import 'package:flutter/foundation.dart';

class TemplateDesktopViewModel extends ChangeNotifier {
  List<bool> templateState = [true, false, false, false, false, false];

  bool get getHomeState => templateState[0];
  bool get getHelpDeskState => templateState[1];
  bool get getRoomState => templateState[2];
  bool get getTeacherContactState => templateState[3];
  bool get getFaqState => templateState[4];
  bool get getProfileState => templateState[5];

  void changeState(int menu) {
    int trueStateIndex = templateState.indexOf(true);
    if (trueStateIndex != menu && trueStateIndex != -1) {
      templateState[trueStateIndex] = false;
      templateState[menu] = true;
      notifyListeners();
    }
  }
}