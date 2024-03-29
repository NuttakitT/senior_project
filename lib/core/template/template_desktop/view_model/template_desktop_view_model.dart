// ignore_for_file: prefer_final_fields

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:senior_project/community_board/view_model/community_board_view_model.dart';
import 'package:senior_project/core/datasource/firebase_services.dart';
import 'package:senior_project/help_desk/help_desk_main/view_model/help_desk_view_model.dart';

class TemplateDesktopViewModel extends ChangeNotifier {
  List<bool> _navBarState = [true, false, false, false, false, false, false, false, false, false];
  List<bool> _helpDeskTagBar = [true, false, false, false, false, false, false, false]; 
  List<bool> _homeTagBar = [true]; 
  List<Map<String, dynamic>> _home = [{
    "name": "All FAQ",
    "description": ""
  }];
  List<bool> _faqTagBar = [true, false];
  bool _isSafeLoad = true;
  bool _isSafeClick = true;
  bool _isApprovedPage = false;
  List<Map<String, dynamic>> _pendingTicket = [];
  List<dynamic> _unseenTicket = [];
  List<int> _unseenMsg = [];

  get getPendingTicket => _pendingTicket;
  void addPendingTicket(dynamic docId) {
    _pendingTicket.add(docId);
  } 
  get getUnseenTicket => _unseenTicket;
  void addUnseemTicket(dynamic docId) {
    _unseenTicket.add(docId);
  } 
  get getUnseenMsg => _unseenMsg;
  void addUnseenMsg(int amount) {
    _unseenMsg.add(amount);
  } 
  void clearNotification() {
    _pendingTicket = [];
    _unseenMsg = [];
    _unseenTicket = [];
  }

  get getIsSafeClick => _isSafeClick;
  set setIsSafeClick(bool state) => _isSafeClick = state;
  get getIsApprovedPage => _isApprovedPage;
  set setIsApprovedPage(bool state) => _isApprovedPage = state;
  get getIsSafeLoad => _isSafeLoad;
  set setIsSafeLoad(bool state) => _isSafeLoad = state;
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
      if (type == 4) {
        context.read<HelpDeskViewModel>().clearContentController();
        if (!context.read<HelpDeskViewModel>().getIsFromNoti) {
          notifyListeners();
        }
      }
      else if (type == 2) {
        context.read<CommunityBoardViewModel>().clearPost();
        notifyListeners();
      } else {
        notifyListeners();
      }
    }
  }

  void clearHomeTagbar() {
    _home = [
      {
        "name": "All FAQ",
        "description": ""
      }
    ];
    _homeTagBar = [true];
  }

  Future<void> getCategory() async {
    _isSafeLoad = false;
    clearHomeTagbar();
    // final category = await FirebaseServices("category").getDocumnetByKeyValuePair(
    //   _isApprovedPage ? ["isCommunity"] : ["isCommunity", "isApproved"], 
    //   _isApprovedPage ? [true] : [true, true]
    // );
    final category = await FirebaseServices("category").getAllDocument();
    for (int i = 0; i < category!.docs.length; i++) {
      // if (_isApprovedPage) {
      //   List<Map<String, dynamic>> hasTag = [];
      //   if (_home.isNotEmpty) {
      //     hasTag = _home.where((element) => element["name"] == category.docs[i].id).toList();
      //   }
      //   if (hasTag.isEmpty) {
      //     _home.add({
      //       "name": category.docs[i].id,
      //       "description": category.docs[i].get("description")
      //     });
      //     _homeTagBar.add(false);
      //   }
      // } else {
        final faq = await FirebaseServices("faq").getDocumnetByKeyValuePair(
        ["category"], 
        [category.docs[i].id]
        );
        if (faq!.docs.isNotEmpty) {
          List<Map<String, dynamic>> hasTag = [];
          if (_home.isNotEmpty) {
            hasTag = _home.where((element) => element["name"] == category.docs[i].id).toList();
          }
          if (hasTag.isEmpty) {
            _home.add({
              "name": category.docs[i].id,
              "description": category.docs[i].get("description")
            });
            _homeTagBar.add(false);
          }
        }
      // }
    }
  }

  Future<String?> uploadImage(Uint8List? file, String fileName, String docId) async {
    try {
      String? imageUrl;
      if (file != null) {
        FirebaseStorage storage = FirebaseStorage.instance;
        Reference deleteRef = storage.ref().child("profile/$docId");
        final list = await deleteRef.listAll();
        for (int i = 0; i < list.items.length; i++) {
          list.items[i].delete();
        }
        Reference ref = storage.ref().child("profile/$docId/$fileName");

        UploadTask task = ref.putData(file);
        await task.whenComplete(() async {
          var url = await ref.getDownloadURL();
          imageUrl = url.toString();
        }).catchError((e) {
          if (kDebugMode) {
            print(e);
          }
        });
        FirebaseServices("user").editDocument(docId, {"profileImageUrl": imageUrl});
      }
      return imageUrl;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return null;
    } 
  }

  Future<void> reconstructNoti(QuerySnapshot? snaspshot, String uid) async {
    for (int i = 0; i < snaspshot!.docs.length; i++) {
      List<dynamic> seen = snaspshot.docs[i].get("isSeen");
      final userSnapshot = await FirebaseServices("user").getDocumentById(snaspshot.docs[i].get("ownerId"));
      if (snaspshot.docs[i].get("status") < 2 && !seen.contains(uid)) {
        addPendingTicket({
          "docId": snaspshot.docs[i].id,
          "title": snaspshot.docs[i].get("title"),
          "detail": snaspshot.docs[i].get("detail"),
          "time": snaspshot.docs[i].get("dateCreate").toDate(),
          "id": snaspshot.docs[i].get("id"),
          "priority": snaspshot.docs[i].get("priority"),
          "status": snaspshot.docs[i].get("status"),
          "category": snaspshot.docs[i].get("category"),
          "ownerId": snaspshot.docs[i].get("ownerId"),
          "name": userSnapshot!.get("name"),
          "adminId": snaspshot.docs[i].get("adminId"),
        });
      }
    }
  }
}