import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:senior_project/community_board/view_model/community_board_view_model.dart';
import 'package:senior_project/core/datasource/firebase_services.dart';
import 'package:senior_project/help_desk/help_desk_main/view_model/help_desk_view_model.dart';

class TemplateDesktopViewModel extends ChangeNotifier {
  List<bool> _navBarState = [true, false, false, false];
  List<bool> _helpDeskTagBar = [true, false, false, false, false, false, false, false]; 
  List<bool> _homeTagBar = [true]; 
  List<Map<String, dynamic>> _home = [{
    "name": "All tag post",
    "description": ""
  }];
  List<bool> _faqTagBar = [true, false];

  get getHomeTagBarName => _home;
  Map<String, dynamic> getHomeTagBarNameSelected(int index) => _home[index];
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

  void changeState(BuildContext context, int index, int type) {
    List<bool> menuTemplate = _selectState(type);
    int trueStateIndex = menuTemplate.indexOf(true);
    if (index < menuTemplate.length && trueStateIndex != index && trueStateIndex != -1) {
      menuTemplate[trueStateIndex] = false;
      menuTemplate[index] = true;
      _copyValue(menuTemplate, type);
      notifyListeners();
      if (type == 4) {
        context.read<HelpDeskViewModel>().clearContentController();
      }
      if (type == 2) {
        context.read<CommunityBoardViewModel>().clearPost();
      }
    }
  }

  Future<void> getCategory() async {
    _home = [
      {
        "name": "All tag post",
        "description": ""
      }
    ];
    _homeTagBar = [true];
    final category = await FirebaseServices("category").getDocumnetByKeyValuePair(
      ["isCommunity", "isApproved"], 
      [true, true]
    );
    for (int i = 0; i < category!.docs.length; i++) {
      final post = await FirebaseServices("post").getDocumnetByKeyValuePair(
        ["topics", "isApproved"], 
        [[category.docs[i].id], true]
      );
      if (post!.docs.isNotEmpty) {
        _home.add({
          "name": category.docs[i].id,
          "description": category.docs[i].get("description")
        });
        _homeTagBar.add(false);
      }
    }
  }
}