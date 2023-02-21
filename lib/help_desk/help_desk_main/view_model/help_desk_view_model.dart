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
  final FirebaseServices _service = FirebaseServices("task");
  final AlgoliaServices _algolia = AlgoliaServices("task");
  final List<bool> _mobileMenuState = [true, false, false, false];
  List<Map<String, dynamic>> _task = [];
  final List<String> _category = ["General", "Activity", "Registration", "Hardware"]; // TODO add category String
  HitsSearcher _hitSearch = HitsSearcher(
    applicationID: "LEPUBBA9NX", 
    apiKey: "558b4a129c0734cd6cc62f5d78e585d2", 
    indexName: "task");
  String _searchText = "";

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

  void initHitSearcher() {
    _hitSearch = HitsSearcher(
    applicationID: "LEPUBBA9NX", 
    apiKey: "558b4a129c0734cd6cc62f5d78e585d2", 
    indexName: "task");
    notifyListeners();
  }

  get getSearchText => _searchText;
  get getCategory => _category;
  get getTask => _task.reversed.toList();
  HitsSearcher get getHitsSearcher => _hitSearch;
  void setSearchText(String text, String filter) {
    if (text.isNotEmpty) {
      _searchText = "$filter $text";
    } else {
      _searchText = "";
    }
    notifyListeners();
  } 

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

  Map<String, dynamic> formatTaskDetail(Map<String, dynamic> data) {
    // TODO query username email form db
    data.addEntries({
      "username": "test",
      "email": "runn@gmail.com",
    }.entries);
    return data;
  }

  Future<void> createTask(String title, String detail, int priority, String category) async {
    Task task = Task(
      // TODO listen to current user
      "user",
      // FirebaseAuth.instance.currentUser!.uid,
      title,
      Content(detail),
      priority,
      category
    );
    _helpDeskModel.addTask(task);
    String docId = task.getDateCreate.millisecondsSinceEpoch.toString();
    String? objectId = await _algolia.addObject(docId, {
      // TODO listen to current user
      "username": "Runn",
      "email": "runn@gmail.com",
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
    await _service.setDocument(docId, taskDetail);
  }

  void cleanModel() {
    _helpDeskModel = HelpDeskMainModel();
    _task = [];
  }

  Future<void> editTask(String id, bool isStatus, int value) async {
    QuerySnapshot? query = await _service.getDocumnetByKeyValuePair(["id"], [id]);
    if (query!.docs.isNotEmpty) {
      String docId = query.docs.first.id;
      String objectId = query.docs.first.get("objectID");
      await _service.editDocument(docId, isStatus
        ? {"status": value}
        : {"priority": value}
      );
      await _algolia.updateObject(objectId, isStatus
        ? {"status": convertToString(isStatus, value)}
        : {"priority": convertToString(isStatus, value)}
      );
    }
  }

  // Listen to database and update data in application
  void _addQueryData(DocumentSnapshot snapshot) {
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
    _task.add(
      formatTaskDetail(
        _helpDeskModel.getTaskDetail(_helpDeskModel.getTask.length-1)
      )
    );
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
      if (snapshot.docChanges[i].type == DocumentChangeType.added 
        && snapshot.docChanges[i].doc.id != "dummy") {
        _addQueryData(doc);
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
}
