import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:senior_project/core/datasource/firebase_services.dart';
import 'package:senior_project/core/model/content.dart';
import 'package:senior_project/core/model/help_desk/task.dart';
import 'package:senior_project/help_desk/help_desk_main/model/help_desk_main_model.dart';

class HelpDeskViewModel extends ChangeNotifier {
  HelpDeskMainModel helpDeskModel = HelpDeskMainModel();
  FirebaseServices service = FirebaseServices("task");
  List<bool> mobileMenuState = [true, false, false, false];
  List<Map<String, dynamic>> task = [];
  List<String> category = ["Test", "Cat_A", "Cat_B", "Cat_X"]; // TODO add category String

  get getCategory => category;
  get getTask => task;

  bool? getMobileMenuState(int index) {
    if (index >= 0 && index < 4) {
      return mobileMenuState[index];
    }
    return null;
  }

  void changeMobileMenuState(int index) {
    if (index >= 0 && index < 4) {
      int currentIndex = mobileMenuState.indexOf(true);
      if (currentIndex != index) {
        mobileMenuState[currentIndex] = false;
        mobileMenuState[index] = true;
        notifyListeners();
      }
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
    helpDeskModel.addTask(task);
    await service.setDocument(task.getTaskId, {
      "id": task.getTaskId,
      "ownerId": task.getOwnerId,
      "dateCreate": task.getDateCreate,
      "category": task.getCategory,
      "priority": task.getPriority,
      "status": task.getStatus,
      "title": task.getTitle,
      "detail": detail
    });
  }

  Future<void> queryTask(String id) async {
    final query = await service.getDocumnetByKeyValuePair("ownerId", id);
    for (int i = 0; i < query.docs.length; i++) {
      helpDeskModel.addTask(
        Task(
          query.docs[i].get("ownerId"),
          query.docs[i].get("title"), 
          Content(query.docs[i].get("detail")),
          query.docs[i].get("priority"), 
          query.docs[i].get("category"),
          query.docs[i].get("id")
        )
      );
    }
  }

  void formatTaskDetail() {
    for (int i = 0; i < helpDeskModel.getTask.length; i++) {
      Map<String, dynamic> data = helpDeskModel.getTaskDetail(i);
      data.addEntries({
          "username": "Runn",
          "email": "runn@gmail.com",
        }.entries);
      task.add(
        data
      );
    }
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
        return "Hight";
      case 3:
        return "Urgent";
      default:
        return "Error";
    }
  }
}
