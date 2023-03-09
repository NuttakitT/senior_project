import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:senior_project/core/datasource/firebase_services.dart';
import 'package:senior_project/help_desk/help_desk_reply/model/help_desk_reply_model.dart';

class ReplyChannelViewModel extends ChangeNotifier {
  HelpDeskReplyModel _model = HelpDeskReplyModel();
  final FirebaseServices _service = FirebaseServices("task");
  Map<String, dynamic> _taskData = {};

  set setTaskData(Map<String, dynamic> data) => _taskData = data;
  Map<String, dynamic> get getTaskData => _taskData;
  List<Map<String, dynamic>> getReply(String id) {
    List<Map<String, dynamic>> data = [];
    for (int i = 0; i < _model.getReply.length; i++) {
      data.add({
        "text": _model.getReply[i]["text"],
        "isSender": _model.getReply[i]["ownerId"] == id,
      });
    }
    return data;
  }

  void clearModel() {
    _model = HelpDeskReplyModel();
  }

  Future<bool> createMessage(String docId, Map<String, dynamic> detail) async {
    _model.addReply(detail["ownerId"], detail["message"], detail["time"], detail["seen"]);
    final snapshot = await _service.getAllSubDocument(docId, "replyChannel");
    return await _service.setSubDocument(docId, "replyChannel", snapshot!.docs.length.toString(),detail);
  }

  void reconstructData(QuerySnapshot snapshot) {
    for (int i = 0; i < snapshot.docChanges.length; i++) {
      DocumentSnapshot doc = snapshot.docChanges[i].doc;
      if (snapshot.docChanges[i].type == DocumentChangeType.added) {
        _model.addReply(doc.get("ownerId"), doc.get("message"), (doc.get("time") as Timestamp).toDate(), doc.get("seen"));
      } 
      if (snapshot.docChanges[i].type == DocumentChangeType.modified) {
        int index = snapshot.docChanges[i].newIndex;
        _model.changeSeenStatus(index, doc.get("seen"));
      }
    }
  }
}