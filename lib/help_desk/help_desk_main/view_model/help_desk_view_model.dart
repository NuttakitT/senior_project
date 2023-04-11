// ignore_for_file: depend_on_referenced_packages, prefer_final_fields
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:senior_project/core/datasource/algolia_services.dart';
import 'package:senior_project/core/datasource/firebase_services.dart';
import 'package:senior_project/core/model/content.dart';
import 'package:senior_project/core/model/help_desk/task.dart';
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

  set setIsMobile(bool state) => _isMobile = state;
  get getIsMobile => _isMobile;

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
    final snapshot = await _serviceCategory.getAllDocument();
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
        responsibilityAdmin.add(value.docs[i].get("id"));
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
      "dateCreate": DateFormat('dd/MMM/yyyy hh:mm a').format(task.getDateCreate),
      "category": task.getCategory,
      "priority": task.getPriority,
      "status": task.getStatus,
      "title": task.getTitle,
      "detail": detail,
      "adminId": responsibilityAdmin,
      "isSeen": []
    });
    Map<String, dynamic> taskDetail = {
      "id": task.getId,
      "ownerId": task.getOwnerId,
      "dateCreate": task.getDateCreate,
      "category": task.getCategory,
      "priority": task.getPriority,
      "status": task.getStatus,
      "title": task.getTitle,
      "detail": detail,
      "adminId": responsibilityAdmin,
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
    List<dynamic> seen = snapshot!.get("isSeen") as List<dynamic>;
    if (isAssignToOther) {
      seen.remove(adminId);
    }
    await _serviceTicket.editDocument(docId, {
      "adminId": [adminId],
      "isSeen": seen
    });
    await _algolia.updateObject(snapshot.get("objectID"), {
      "adminId": [adminId],
      "isSeen": seen
    });
  }

  Future<void> changeSeenStatus(String docId, String adminId) async {
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

  Future<void> _changeTaskState(
    String docId, 
    String taskId, 
    String objectId, 
    int value,
    bool isStatus) async {
    _task.firstWhere((element) {
    return element.containsValue(taskId);
    })[isStatus ? "status" : "priority"] = value;
    await _serviceTicket.editDocument(docId, {isStatus ? "status" : "priority": value});
    await _algolia.updateObject(objectId, {
      isStatus ? "status" : "priority": value
    });
  }

  Future<void> editTask(String id, bool isStatus, int value) async {
    DocumentSnapshot? query = await _serviceTicket.getDocumentById(id);
    if (query!.exists) {
      String docId = query.id;
      String taskId = query.get("id");
      String objectId = query.get("objectID");
      if (isStatus) {
        _helpDeskModel.getTask.firstWhere((element) {
          return element.getId == taskId;
        }).changeStatus(value);
      } else {
        _helpDeskModel.getTask.firstWhere((element) {
          return element.getId == taskId;
        }).changePriority(value);
      }
      _changeTaskState(docId, taskId, objectId, value, isStatus);
      notifyListeners();
    }
  }

  // ------------- Listen to database and update data in application ---------------
  Future<void> _addQueryData(DocumentSnapshot snapshot) async {
    Task task = Task(
      snapshot.get("ownerId"),
      snapshot.get("title"),
      Content(snapshot.get("detail")),
      snapshot.get("priority"),
      snapshot.get("category"),
      snapshot.get("isSeen"),
      snapshot.get("adminId"),
      id: snapshot.get("id"),
      dateCreate: snapshot.get("dateCreate").toDate(),
      status: snapshot.get("status"),
    );
    _helpDeskModel.addTask(task);
    _task.add(_helpDeskModel.getTaskDetail(_helpDeskModel.getTask.length-1));
    _task[_helpDeskModel.getTask.length-1].addEntries({"docId": snapshot.id}.entries);
  }

  void _modifyQueryData(DocumentSnapshot snapshot, int index) {
    Task targetTask = _helpDeskModel.getTask.firstWhere((element) {
      return snapshot.get("id") == element.getId;
    });
    targetTask.changeStatus(snapshot.get("status"));
    targetTask.changeStatus(snapshot.get("priority"));
    targetTask.changeIsSeen(snapshot.get("isSeen"));
    _task[index]["status"] = snapshot.get("status");
    _task[index]["priority"] = snapshot.get("priority");
    _task[index]["isSeen"] = snapshot.get("isSeen");
  }
  
  void _removeQueryData(int index) {
    _helpDeskModel.getTask.removeAt(index);
    _task.removeAt(index);
  }

  Future<void> reconstructQueryData(dynamic snapshot) async {
    for (int i = 0; i < snapshot.docChanges.length; i++) {
      DocumentSnapshot doc = snapshot.docChanges[i].doc;
      if (snapshot.docChanges[i].type == DocumentChangeType.added) {
        await _addQueryData(doc);
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

  Future<void> reconstructSearchResult(List<String> docIds) async {
    for (int i = 0; i < docIds.length; i++) {
      DocumentSnapshot? doc = await _serviceTicket.getDocumentById(docIds[i]);
      if (doc!.exists) {
        _addQueryData(doc);
      }
    }
  }
}