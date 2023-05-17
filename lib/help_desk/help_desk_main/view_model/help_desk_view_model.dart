// ignore_for_file: depend_on_referenced_packages, prefer_final_fields, prefer_null_aware_operators
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senior_project/core/datasource/algolia_services.dart';
import 'package:senior_project/core/datasource/firebase_services.dart';
import 'package:senior_project/core/model/content.dart';
import 'package:senior_project/core/model/help_desk/task.dart';
import 'package:senior_project/core/view_model/app_view_model.dart';
import 'package:senior_project/help_desk/help_desk_main/model/help_desk_main_model.dart';

class HelpDeskViewModel extends ChangeNotifier {
  HelpDeskMainModel _helpDeskModel = HelpDeskMainModel();
  final FirebaseServices _serviceTicket = FirebaseServices("ticket");
  final FirebaseServices _serviceCategory = FirebaseServices("category");
  final FirebaseServices _serviceUser = FirebaseServices("user");
  final AlgoliaServices _algolia = AlgoliaServices("ticket");
  final List<bool> _mobileMenuState = [true, false, false, false];
  List<Map<String, dynamic>> _task = [];
  List<String> _category = [];
  bool _isShowMessagePage = false;
  bool _isFromNoti = false;
  int? _allTicket;
  int? _startTicket;
  int? _endTicket;
  int? _selectedTicket; 
  int _pageNumber = 1;
  bool _isReverse = false;
  List<String> _previousFirst = [];
  DocumentSnapshot? _firestDoc;
  DocumentSnapshot? _lastDoc;
  bool _isSafeClick = true;
  bool _isSafeLoad = true;
  bool _isMobile = false;
  List<String> _replyDocId = [];

  get getIsFromNoti => _isFromNoti;
  set setIsFormNoti(bool state) {
    _isFromNoti = state;
    notifyListeners();
  } 

  void addReplyDocId(String id) {
    _replyDocId.add(id);
  }
  get getReplyDocId => _replyDocId;
  void clearReplyDocId() => _replyDocId = [];

  set setIsSafeClick(bool state) => _isSafeClick = state;
  get getIsSafeClick => _isSafeClick;

  set setIsSafeLoad(bool state) => _isSafeLoad = state;
  get getIsSafeLoad => _isSafeLoad;

  DocumentSnapshot? get getFirstDoc => _firestDoc;
  void setFirstDoc(DocumentSnapshot doc) {
    _firestDoc = doc;
  }
  DocumentSnapshot? get getLastDoc => _lastDoc;
  void setLastDoc(DocumentSnapshot doc) {
    _lastDoc = doc;
  }
  List<String> get getPreviousFirstList => _previousFirst;
  Future<DocumentSnapshot?> get getPreviousFirst async {
    if (_previousFirst.isNotEmpty) {
      String docId = _previousFirst.removeAt(_pageNumber-1);
      if (_pageNumber >= _previousFirst.length) {
        _previousFirst.removeRange(_pageNumber-1, _previousFirst.length);
      }
      return await _serviceTicket.getDocumentById(docId);
    } 
    return null;
  } 

  get getPageNumber => _pageNumber;
  get getIsReverse => _isReverse;
  set setPageNumber(int index) {
    if (index >= 1) {
      _pageNumber = index;
    }
  }
  set addPreviousFirst(String docId) {
    if (_pageNumber == 1) {
      _previousFirst = [];
    }
    if (!_previousFirst.contains(docId)) {
      _previousFirst.add(_firestDoc!.id);
    }
  }

  void clearContentController() {
    _lastDoc = null;
    _previousFirst = [];
    _pageNumber = 1;
    _isReverse = false;
    _isSafeClick = true;
    _isSafeLoad = true;
    if (!_isMobile) {
      notifyListeners();
    }
  }

  int? get getAllTicket => _allTicket;
  int? get getStartTicket => _startTicket;
  int? get getEndTicket => _endTicket;
  int? get getSelectedTicket => _selectedTicket;
  set setIsReverse(bool state) {
    _isReverse = state;
  }
  void setIndicator(bool state, int limit) {
    if (state) {
      _startTicket = _startTicket! + limit;
      _endTicket = (_startTicket! + limit) > _allTicket! 
        ? _allTicket
        : _startTicket! + limit - 1;
    } else {
      _startTicket = _startTicket! - limit;
      _endTicket = (_startTicket! + limit) > _allTicket! 
        ? _allTicket
        : _startTicket! + limit - 1;
    }
    if (!_isShowMessagePage) {
      notifyListeners();
    }
  }

  set setSelectedTicket(int index) {
    _selectedTicket = index;
    notifyListeners();
  } 

  void initTicket(int all, int limit)  {
    if (_pageNumber == 1) {
      _startTicket = 1;
      _allTicket = all;
      _isReverse = false;
      _isSafeClick = true;
      if (_allTicket! < limit) {
        _endTicket = _allTicket; 
      } else {
        _endTicket = _startTicket! + limit - 1;
      }
    }
  }

  Future<void> initTicketCategory() async {
    final snapshot = await _serviceCategory.getDocumnetByKeyValuePair(
      ["isHelpDesk"],
      [true]
    );
    _category = [];
    for (int i = 0; i < snapshot!.docs.length; i++) {
      _category.add(snapshot.docs[i].get("name"));
    }
  }

  get getIsShowMessagePage => _isShowMessagePage;
  void setShowMessagePageState(bool state) {
    _isShowMessagePage = state;
    notifyListeners();
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
        return "High";
      case 3:
        return "Urgent";
      default:
        return "Error";
    }
  }

  List<String> get getCategory => _category;
  List<Map<String, dynamic>>  get getTask => _task;

  bool? getMobileMenuState(int index) {
    if (index >= 0 && index < 4) {
      return _mobileMenuState[index];
    }
    return null;
  }

  void changeMobileMenuState(int index) {
    if (index >= 0 && index < 4) {
      int currentIndex = _mobileMenuState.indexOf(true);
      if (currentIndex != index) {
        _mobileMenuState[currentIndex] = false;
        _mobileMenuState[index] = true;
        notifyListeners();
      }
    }
  }

  int getSelectedMobileMenu() {
    return _mobileMenuState.indexOf(true);
  }

  Future<String> getTaskDocId(String taskId) async {
    final snapshot = await _serviceTicket.getDocumnetByKeyValuePair(["id"], [taskId]);
    return snapshot!.docs.first.id;
  }

  Future<List<String>?> _getUserdetail(String uid) async {
    final doc = await _serviceUser.getDocumentById(uid);
    if (doc!.exists) {
      return [doc.get("name"), doc.get("email")];
    } else {
      return null;
    }
  }

  Future<void> formatTaskDetail() async {
    for (int i = 0; i < _task.length; i++) {
      List<String>? list = await _getUserdetail(_task[i]["ownerId"]);
      _task[i].addEntries({
        "name": list![0],
        "email": list[1],
      }.entries);
    }
  }

  Future<void> createTask(String title, String detail, int priority, String category) async {
    List<String> responsibilityAdmin = [];
    await FirebaseServices("user").getDocumentByKeyList("responsibility", [category]).then((value) {
      for (int i = 0; i < value!.docs.length; i++) {
        if (value.docs[i].get("role") == 0) {
          responsibilityAdmin.add(value.docs[i].get("id"));
        }
      }
    });
    Task task = Task(
      FirebaseAuth.instance.currentUser!.uid,
      title,
      Content(detail),
      priority,
      category,
      [],
      responsibilityAdmin
    );
    _helpDeskModel.addTask(task);
    String docId = task.getDateCreate.millisecondsSinceEpoch.toString();
    List<String>? list = await _getUserdetail(FirebaseAuth.instance.currentUser!.uid);
    String? objectId = await _algolia.addObject(docId, {
      "name": list![0],
      "email": list[1],
      "ownerId": FirebaseAuth.instance.currentUser!.uid,
      "dateCreate": task.getDateCreate,
      "dateComplete": null,
      "category": task.getCategory,
      "priority": task.getPriority,
      "status": task.getStatus,
      "title": task.getTitle,
      "detail": detail,
      "relateAdmin": responsibilityAdmin,
      "adminId": null,
      "isSeen": [],
      "id": task.getId
    });
    Map<String, dynamic> taskDetail = {
      "id": task.getId,
      "ownerId": task.getOwnerId,
      "dateCreate": task.getDateCreate,
      "dateComplete": null,
      "category": task.getCategory,
      "priority": task.getPriority,
      "status": task.getStatus,
      "title": task.getTitle,
      "detail": detail,
      "relateAdmin": responsibilityAdmin,
      "adminId": null,
      "isSeen": []
    };
    taskDetail.addAll({"objectID": objectId!});
    await _serviceTicket.setDocument(docId, taskDetail);
  }

  void clearModel() {
    _helpDeskModel = HelpDeskMainModel();
    _task = [];
  }

  Future<void> setTicketResponsibility(String docId, String adminId, bool isAssignToOther) async {
    final snapshot = await _serviceTicket.getDocumentById(docId);
    await _serviceTicket.editDocument(docId, {
      "adminId": adminId,
      "isSeen": isAssignToOther ? [] : [adminId]
    });
    await _algolia.updateObject(snapshot!.get("objectID"), {
      "adminId": adminId,
      "isSeen": isAssignToOther ? [] : [adminId]
    });
  }

  Future<void> changeSeenStatus(String docId, String adminId, bool isAdmin) async {
    if (isAdmin) {
      final snapshot = await _serviceTicket.getDocumentById(docId);
      List<dynamic> seen = snapshot!.get("isSeen") as List<dynamic>;
      if (!seen.contains(adminId)) {
        seen.add(adminId);
      }
      await _algolia.updateObject(snapshot.get("objectID"), {
        "isSeen": seen
      });
      await _serviceTicket.editDocument(docId, {
        "isSeen": seen
      });
    }
    for (int i = 0; i < _replyDocId.length; i++) {
      await _serviceTicket.editSubDocument(docId, "replyChannel", _replyDocId[i], {
        "seen": true
      });
    }
  }

  Future<void> _changeTaskState(
  String docId, 
  String taskId, 
  String objectId, 
  int value,
  bool isStatus,
  {
    DateTime? dateComplete
  }) async {
    if (!_isFromNoti) {
      _task.firstWhere((element) {
        return element.containsValue(taskId);
      })[isStatus ? "status" : "priority"] = value;
      if (isStatus && value >= 2) {
        _task.firstWhere((element) {
          return element.containsValue(taskId);
        })["timeComplete"] = dateComplete;
      } else {
        _task.firstWhere((element) {
          return element.containsValue(taskId);
        })["timeComplete"] = null;
      }
    }
    await _algolia.updateObject(
      objectId, 
      isStatus && value >= 2 
      ? {isStatus ? "status" : "priority": value, "dateComplete": dateComplete}
      : {isStatus ? "status" : "priority": value, "dateComplete": null}
    );
    await _serviceTicket.editDocument(
      docId, 
      isStatus && value >= 2 
      ? {isStatus ? "status" : "priority": value, "dateComplete": dateComplete}
      : {isStatus ? "status" : "priority": value, "dateComplete": null}
    );
  }

  Future<void> editTask(String id, bool isStatus, int value) async {
    try {
      DocumentSnapshot? query = await _serviceTicket.getDocumentById(id);
      if (query!.exists) {
        String docId = query.id;
        String taskId = query.get("id");
        String objectId = query.get("objectID") as String;
        DateTime dateComplete = DateTime.now();
        if (!_isFromNoti) {
          if (isStatus) {
            _helpDeskModel.getTask.firstWhere((element) {
              return element.getId == taskId;
            }).changeStatus(value, dateComplete: dateComplete);
          } else {
            _helpDeskModel.getTask.firstWhere((element) {
              return element.getId == taskId;
            }).changePriority(value);
          }
        }
        await _changeTaskState(docId, taskId, objectId, value, isStatus, dateComplete: dateComplete);
        // notifyListeners();
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    
  }

  // ------------- Listen to database and update data in application ---------------
  Future<void> _addQueryData(BuildContext context, DocumentSnapshot snapshot) async {
    bool isAdmin = context.read<AppViewModel>().app.getUser.getRole == 0;
    bool pass = false;
    if (isAdmin) {
      String adminId = context.read<AppViewModel>().app.getUser.getId;
      if (snapshot.get("adminId") == null || snapshot.get("adminId") == adminId) {
        pass = true;
      }
    } else {
      pass = true;
    }
    if (pass) {
      Task task = Task(
        snapshot.get("ownerId"),
        snapshot.get("title"),
        Content(snapshot.get("detail")),
        snapshot.get("priority"),
        snapshot.get("category"),
        snapshot.get("isSeen"),
        snapshot.get("relateAdmin"),
        id: snapshot.get("id"),
        dateCreate: snapshot.get("dateCreate").toDate(),
        status: snapshot.get("status"),
        dateComplete: snapshot.get("dateComplete") != null ? snapshot.get("dateComplete").toDate() : null
      );
      _helpDeskModel.addTask(task);
      _task.add(_helpDeskModel.getTaskDetail(_helpDeskModel.getTask.length-1));
      _task[_helpDeskModel.getTask.length-1].addEntries({"docId": snapshot.id}.entries);
    }
  }

  void _modifyQueryData(DocumentSnapshot snapshot, int index) {
    Task targetTask = _helpDeskModel.getTask.firstWhere((element) {
      return snapshot.get("id") == element.getId;
    });
    targetTask.changeStatus(snapshot.get("status"));
    targetTask.changeStatus(snapshot.get("priority"));
    targetTask.changeStatus(snapshot.get("dateComplete"));
    targetTask.changeIsSeen(snapshot.get("isSeen"));
    _task[index]["status"] = snapshot.get("status");
    _task[index]["priority"] = snapshot.get("priority");
    _task[index]["timeComplete"] = snapshot.get("dateComplete");
    _task[index]["isSeen"] = snapshot.get("isSeen");
  }
  
  void _removeQueryData(int index) {
    _helpDeskModel.getTask.removeAt(index);
    _task.removeAt(index);
  }

  Future<void> reconstructQueryData(BuildContext context, dynamic snapshot) async {
    for (int i = 0; i < snapshot.docChanges.length; i++) {
      DocumentSnapshot doc = snapshot.docChanges[i].doc;
      if (snapshot.docChanges[i].type == DocumentChangeType.added) {
        await _addQueryData(context, doc);
      }
      if (snapshot.docChanges[i].type == DocumentChangeType.modified) {
        int index = snapshot.docChanges[i].newIndex;
        _modifyQueryData(doc, index);
      }
      if (snapshot.docChanges[i].type == DocumentChangeType.removed) {
        int index = snapshot.docChanges[i].oldIndex;
        _removeQueryData(index);
      }
    }
  }

  void reconstructSearchResult(List<dynamic> hits, bool isAdmin, String uid) {
    for (var item in hits) {
      bool isTargetObject = false;
      String ownerId = item["ownerId"] as String;
      List<dynamic> relateAdmin = item["relateAdmin"] as List<dynamic>;
      dynamic adminId = item["adminId"];
      if (isAdmin && (relateAdmin.contains(uid) && (adminId == uid || adminId == null))) {
        isTargetObject = true;
      } else if (!isAdmin && ownerId == uid) {
        isTargetObject = true;
      }
      if (isTargetObject) {
        DateTime date = DateTime.parse(item["dateCreate"]);
        _task.add({
          "objectID": item["objectID"],
          "email": item["email"],
          "name": item["name"],
          "detail": item["detail"],
          "title": item["title"],
          "ownerId": item["ownerId"],
          "time": date,
          "completeTime": item["dateComplete"] != null ? DateTime.parse(item["dateComplete"]) : null,
          "category": item["category"],
          "priority": item["priority"],
          "status": item["status"],
          "adminId": item["adminId"],
          "isSeen": item["isSeen"],
          "docId": item["docId"],
          "id": item["id"],
        });
      }
    }
  }
}