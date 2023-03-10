import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class TemplateDesktopViewModel extends ChangeNotifier {
  List<bool> _navBarState = [true, false, false, false, false, false];
  List<bool> _helpDeskTagBar = [true, false, false, false, false, false, false, false]; 
  // TODO query amount from db
  List<bool> _homeTagBar = [true, false]; 
  List<bool> _faqTagBar = [true, false];

  bool getNavBarState(int index) => _navBarState[index];
  bool getHomeState(int index) => _homeTagBar[index];
  bool getFaqState(int index) => _faqTagBar[index];
  bool getHelpDeskAdminState(int index) => _helpDeskTagBar[index];

  List<bool> _selectState(int type) {
    switch (type) {
      case 1:
        return _navBarState;
      case 2:
        return _homeTagBar;
      case 3: 
        return _faqTagBar;
      case 4: 
        return _helpDeskTagBar;
      default:  
        return [];
    }
  }
  
  void _copyValue(List<bool> list, int type) {
    switch (type) {
      case 1:
        _navBarState = list;
        break;
      case 2:
        _homeTagBar = list;
        break;
      case 3: 
        _faqTagBar = list;
        break;
      case 4: 
        _helpDeskTagBar = list;
        break;
      default:  
        break;
    }
  }

  int selectedTagBar(int type) {
    switch (type) {
      case 1:
        return _navBarState.indexOf(true);
      case 2:
        return _homeTagBar.indexOf(true);
      case 3: 
        return _faqTagBar.indexOf(true);
      case 4: 
        return _helpDeskTagBar.indexOf(true);
      default:
        return -1;
    } 
  }

  void changeState(int index, int type) {
    List<bool> menuTemplate = _selectState(type);
    int trueStateIndex = menuTemplate.indexOf(true);
    if (trueStateIndex != index && trueStateIndex != -1) {
      menuTemplate[trueStateIndex] = false;
      menuTemplate[index] = true;
      _copyValue(menuTemplate, type);
      notifyListeners();
    }
  }
}