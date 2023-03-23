// ignore_for_file: depend_on_referenced_packages, prefer_final_fields
import 'package:algolia_helper_flutter/algolia_helper_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  final FirebaseServices _serviceUser = FirebaseServices("user");
  final AlgoliaServices _algolia = AlgoliaServices("ticket");
  final List<bool> _mobileMenuState = [true, false, false, false];
  List<Map<String, dynamic>> _task = [];
  final List<String> _category = ["General", "Activity", "Registration", "Hardware"]; // TODO add category
  bool _isShowMessagePage = false;
  int? _allTicket;
  int? _startTicket;
  int? _endTicket;
  int? _selectedTicket; 
  // List<DocumentSnapshot?> _previousFirst = [];
  List<int> test = [];
  DocumentSnapshot? _previousFirst;
  DocumentSnapshot? _lastDoc;
  DocumentSnapshot? _firstDoc;
  // int pageNumber = 1;
  bool _isLoadMore = false;
  bool _isLoadLess = false;

  DocumentSnapshot? get getLastDoc => _lastDoc;
  void setLastDoc(DocumentSnapshot doc) {
    _lastDoc = doc;
  }
  DocumentSnapshot? get getFirstDoc => _firstDoc;
  // DocumentSnapshot? get getPreviousFirst {
  //   if (_previousFirst.isNotEmpty) {
  //     return _previousFirst.removeLast();
  //   } 
  //   return null;
  // } 
  void setFirstDoc(DocumentSnapshot doc) {
    // _previousFirst.add(_firstDoc);
    // print("a" + _previousFirst.length.toString());
    _previousFirst = _firstDoc;
    _firstDoc = doc;
    print("previoud $_previousFirst");
    print("new $_firstDoc");

    // * Solution for chunk load
    // * collect previous first doc of chunk (has bug can't add DocumentSnapshot to list)
    // * in case new ticket add to db, it will show when return to first page (also the number of the ticket in view)
  }
  // int get getPageNumber => pageNumber;
  // void setPageNumber(int num) {
  //   pageNumber = num;
  //   notifyListeners();
  // }
  bool get getIsLoadMore => _isLoadMore;
  bool get getIsLoadLess => _isLoadLess;
  void setIsLoadMore(bool state) {
    _isLoadMore = state;
    notifyListeners();
  }
  void setIsLoadLess(bool state) {
    _isLoadLess = state;
    notifyListeners();
  }

  int? get getAllTicket => _allTicket;
  int? get getStartTicket => _startTicket;
  int? get getEndTicket => _endTicket;
  int? get getSelectedTicket => _selectedTicket;
  set setSelectedTicket(int index) => _selectedTicket = index;

  Future<void> initTicket(bool isAdmin, String id, int limit) async {
    String filed = isAdmin ? "adminId" : "ownerId";
    final snapshot = await _serviceTicket.getDocumnetByKeyValuePair([filed], [id]);
    _allTicket = snapshot!.docs.length;
    _startTicket = 1;
    _endTicket = limit;
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

  get getCategory => _category;
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
    Task task = Task(
      FirebaseAuth.instance.currentUser!.uid,
      title,
      Content(detail),
      priority,
      category
    );
    _helpDeskModel.addTask(task);
    String docId = task.getDateCreate.millisecondsSinceEpoch.toString();
    List<String>? list = await _getUserdetail(FirebaseAuth.instance.currentUser!.uid);
    String? objectId = await _algolia.addObject(docId, {
      "ownerName": list![0],
      "email": list[1],
      "dateCreate": DateFormat('dd/MMM/yyyy hh:mm a').format(task.getDateCreate),
      "category": task.getCategory,
      "priority": convertToString(false, task.getPriority),
      "status": convertToString(true, task.getStatus),
      "title": task.getTitle,
      "detail": detail,
      "adminId": "blUSeUMgajPQ1TRC8AEMsvembvm2" // TODO testing
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
      "adminId": "blUSeUMgajPQ1TRC8AEMsvembvm2" // TODO testing
    };
    taskDetail.addAll({"objectID": objectId!});
    await _serviceTicket.setDocument(docId, taskDetail);
  }

  void cleanModel() {
    _helpDeskModel = HelpDeskMainModel();
    _task = [];
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
      isStatus ? "status" : "priority": convertToString(isStatus, value) // TODO change to int value
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
      id: snapshot.get("id"),
      dateCreate: snapshot.get("dateCreate").toDate(),
      status: snapshot.get("status")
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
    _task[index]["status"] = snapshot.get("status");
    _task[index]["priority"] = snapshot.get("priority");
  }
  
  void _removeQueryData(int index) {
    _helpDeskModel.getTask.removeAt(index);
    _task.removeAt(index);
  }

  Future<void> reconstructQueryData(QuerySnapshot snapshot) async {
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
        String docId = snapshot.docChanges[i].doc.get("objectID");
        await _algolia.deleteObject(docId);
        _removeQueryData(index);
      }
    }
  }

  Future<void> reconstructSearchResult(List<String> docIds) async {
    for (int i = 0; i < docIds.length; i++) {
      DocumentSnapshot? doc = await _serviceTicket.getDocumentById(docIds[i]);
      if (doc != null) {
        _addQueryData(doc);
      }
    }
  }

  // ---------------------------------- Text Search ----------------------------
  String _searchText = "";
  HitsSearcher _hitSearch = HitsSearcher(
    applicationID: "LEPUBBA9NX", 
    apiKey: "558b4a129c0734cd6cc62f5d78e585d2", 
    indexName: "ticket");

  void initHitSearcher() {
    _hitSearch = HitsSearcher(
    applicationID: "LEPUBBA9NX", 
    apiKey: "558b4a129c0734cd6cc62f5d78e585d2", 
    indexName: "ticket");
    notifyListeners();
  }

  get getSearchText => _searchText;
  HitsSearcher get getHitsSearcher => _hitSearch;
  void setSearchText(String text) {
    if (text.isNotEmpty) {
      _searchText = text;
    } else {
      _searchText = "";
    }
    notifyListeners();
  } 

  void clearSearchText() {
    _searchText = "";
    notifyListeners();
  }
}