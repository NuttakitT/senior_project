import 'package:flutter/foundation.dart';

class TemplateDesktopViewModel extends ChangeNotifier {
  List<bool> _navBarState = [true, false, false, false, false, false];
  List<bool> _helpDeskTagBarAdmin = [true, false, false, false, false, false, false, false]; 
  // TODO query amount from db
  List<bool> _homeTagBar = [true, false]; 
  List<bool> _faqTagBar = [true, false];

  bool getNavBarState(int index) => _navBarState[index];
  bool getHomeState(int index) => _homeTagBar[index];
  bool getFaqState(int index) => _faqTagBar[index];
  bool getHelpDeskAdminState(int index) => _helpDeskTagBarAdmin[index];

  List<bool> _selectState(int type) {
    switch (type) {
      case 1:
        return _navBarState;
      case 2:
        return _homeTagBar;
      case 3: 
        return _faqTagBar;
      case 4: 
        return _helpDeskTagBarAdmin;
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
        _helpDeskTagBarAdmin = list;
        break;
      default:  
        break;
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