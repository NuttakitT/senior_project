import 'package:flutter/cupertino.dart';

class TemplateMobileViewModel extends ChangeNotifier {
  List<bool> menu = [true, false, false, false];

  bool getMenuState(int index) => menu[index];

  void changeMenuState(int index) {
    int trueStateIndex = menu.indexOf(true);
    if (trueStateIndex != index && trueStateIndex != -1) {
      menu[trueStateIndex] = false;
      menu[index] = true;
    }
  }
}