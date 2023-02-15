import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
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
  get getTask => _task;

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

  void formatTaskDetail(int index) {
    Map<String, dynamic> data = _helpDeskModel.getTaskDetail(index);
    data.addEntries({
        "username": "Runn",
        "email": "runn@gmail.com",
      }.entries);
    _task.add(
      data
    );
  }

  Future<void> initHelpDesk(String id) async {
    final query = await _service.getDocumnetByKeyValuePair("ownerId", id);
    int j = 0;
    for (int i = query.docs.length-1; i >= 0; i--) {
      _helpDeskModel.addTask(
        Task(
          query.docs[i].get("ownerId"),
          query.docs[i].get("title"), 
          Content(query.docs[i].get("detail")),
          query.docs[i].get("priority"), 
          query.docs[i].get("category"),
          id: query.docs[i].get("id"),
          dateCreate: query.docs[i].get("dateCreate").toDate()
        )
      );
      formatTaskDetail(j++);
    }
    
  }

  Future<void> createTask(String title, String detail, int priority, String category) async {
    Task task = Task(
      "test",
      // FirebaseAuth.instance.currentUser!.uid,
      title,
      Content(detail),
      priority,
      category
    );
    _helpDeskModel.addTask(task);
    await _service.setDocument(task.getTaskId, {
      "id": task.getTaskId,
      "ownerId": task.getOwnerId,
      "dateCreate": task.getDateCreate,
      "category": task.getCategory,
      "priority": task.getPriority,
      "status": task.getStatus,
      "title": task.getTitle,
      "detail": detail
    });
    formatTaskDetail(_helpDeskModel.getTask.length-1);
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
