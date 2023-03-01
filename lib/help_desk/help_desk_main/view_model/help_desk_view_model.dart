// ignore_for_file: depend_on_referenced_packages

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
  final FirebaseServices _serviceTask = FirebaseServices("task");
  final FirebaseServices _serviceUser = FirebaseServices("user");
  final AlgoliaServices _algolia = AlgoliaServices("task");
  final List<bool> _mobileMenuState = [true, false, false, false];
  List<Map<String, dynamic>> _task = [];
  final List<String> _category = ["General", "Activity", "Registration", "Hardware"]; // TODO add category

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
  get getTask => _task.reversed.toList();

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

  Future<List<String>?> _getUserdetail(String uid) async {
    final doc = await _serviceUser.getDocumentById(uid);
    if (doc != null) {
      return [doc.get("username"), doc.get("email")];
    } else {
      return null;
    }
  }

  Future<void> formatTaskDetail() async {
    for (int i = 0; i < _task.length; i++) {
      List<String>? list = await _getUserdetail(_task[i]["ownerId"]);
      _task[i].addEntries({
        "username": list![0],
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
      "username": list![0],
      "email": list[1],
      "dateCreate": DateFormat('dd/MMM/yyyy hh:mm a').format(task.getDateCreate),
      "category": task.getCategory,
      "priority": convertToString(false, task.getPriority),
      "status": convertToString(true, task.getStatus),
      "title": task.getTitle,
      "detail": detail
    });
    Map<String, dynamic> taskDetail = {
      "id": task.getId,
      "ownerId": task.getOwnerId,
      "dateCreate": task.getDateCreate,
      "category": task.getCategory,
      "priority": task.getPriority,
      "status": task.getStatus,
      "title": task.getTitle,
      "detail": detail
    };
    taskDetail.addAll({"objectID": objectId!});
    await _serviceTask.setDocument(docId, taskDetail);
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
    await _serviceTask.editDocument(docId, {isStatus ? "status" : "priority": value});
    await _algolia.updateObject(objectId, {isStatus ? "status" : "priority": convertToString(isStatus, value)});
  }

  Future<void> editTask(String id, bool isStatus, int value) async {
    QuerySnapshot? query = await _serviceTask.getDocumnetByKeyValuePair(["id"], [id]);
    if (query!.docs.isNotEmpty) {
      String docId = query.docs.first.id;
      String taskId = query.docs.first.get("id");
      String objectId = query.docs.first.get("objectID");
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
      DocumentSnapshot? doc = await _serviceTask.getDocumentById(docIds[i]);
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
    indexName: "task");

  void initHitSearcher() {
    _hitSearch = HitsSearcher(
    applicationID: "LEPUBBA9NX", 
    apiKey: "558b4a129c0734cd6cc62f5d78e585d2", 
    indexName: "task");
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