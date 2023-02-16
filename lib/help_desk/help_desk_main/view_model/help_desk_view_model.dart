import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:senior_project/core/datasource/firebase_services.dart';
import 'package:senior_project/core/model/content.dart';
import 'package:senior_project/core/model/help_desk/task.dart';
import 'package:senior_project/help_desk/help_desk_main/model/help_desk_main_model.dart';

class HelpDeskViewModel extends ChangeNotifier {
  final HelpDeskMainModel _helpDeskModel = HelpDeskMainModel();
  final FirebaseServices _service = FirebaseServices("task");
  final List<bool> _mobileMenuState = [true, false, false, false];
  final List<Map<String, dynamic>> _task = [];
  final List<String> _category = ["Test", "Cat_A", "Cat_B", "Cat_X"]; // TODO add category String

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

  Map<String, dynamic> formatTaskDetail(Map<String, dynamic> data) {
    data.addEntries({
      "username": "Runn",
      "email": "runn@gmail.com",
    }.entries);
    return data;
  }

  Future<void> createTask(String title, String detail, int priority, String category) async {
    Task task = Task(
      "test23",
      // FirebaseAuth.instance.currentUser!.uid,
      title,
      Content(detail),
      priority,
      category
    );
    _helpDeskModel.addTask(task);
    await _service.setDocument(task.getDateCreate.millisecondsSinceEpoch.toString(), {
      "id": task.getId,
      "ownerId": task.getOwnerId,
      "dateCreate": task.getDateCreate,
      "category": task.getCategory,
      "priority": task.getPriority,
      "status": task.getStatus,
      "title": task.getTitle,
      "detail": detail
    });
  }

  Stream<QuerySnapshot> listenToTask(String id) {
    if (id.isEmpty) {
      // Admin query
      return _service.listenToDocument();
    } else {
      // User query
      return _service.listenToDocumentByKeyValuePair("ownerId", id);
    }
  }

  void _addData(DocumentSnapshot snapshot) {
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
    _task.add(formatTaskDetail(_helpDeskModel.getTaskDetail(_helpDeskModel.getTask.length-1)));
  }

  void _modifyData(DocumentSnapshot snapshot, int index) {
    Task targetTask = _helpDeskModel.getTask.firstWhere((element) {
      return snapshot.get("id") == element.getId;
    });
    targetTask.changeStatus(snapshot.get("status"));
    targetTask.changeStatus(snapshot.get("priority"));
    _task[index]["status"] = snapshot.get("status");
    _task[index]["priority"] = snapshot.get("priority");
  }
  
  void _removeData(int index) {
    _helpDeskModel.getTask.removeAt(index);
    _task.removeAt(index);
  }

  void reconstructQueryData(QuerySnapshot snapshot) {
    for (int i = 0; i < snapshot.docChanges.length; i++) {
      DocumentSnapshot doc = snapshot.docChanges[i].doc;
      if (snapshot.docChanges[i].type == DocumentChangeType.added) {
        if (_task.length != snapshot.docChanges.length) {
          _addData(doc);
        } 
      }
      if (snapshot.docChanges[i].type == DocumentChangeType.modified) {
        int index = snapshot.docChanges[i].newIndex;
        _modifyData(doc, index);
      }
      if (snapshot.docChanges[i].type == DocumentChangeType.removed) {
        int index = snapshot.docChanges[i].oldIndex;
        _removeData(index);
      }
    }
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
        return "Hight";
      case 3:
        return "Urgent";
      default:
        return "Error";
    }
  }
}
