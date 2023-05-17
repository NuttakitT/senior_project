// ignore_for_file: depend_on_referenced_packages

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:senior_project/core/datasource/firebase_services.dart';
import 'package:senior_project/core/view_model/app_view_model.dart';
import 'package:senior_project/help_desk/help_desk_main/view_model/help_desk_view_model.dart';
import 'package:senior_project/help_desk/help_desk_reply/model/help_desk_reply_model.dart';

class ReplyChannelViewModel extends ChangeNotifier {
  HelpDeskReplyModel _model = HelpDeskReplyModel();
  final FirebaseServices _service = FirebaseServices("ticket");
  Map<String, dynamic> _taskData = {};

  set setTaskData(Map<String, dynamic> data) => _taskData = data;
  Map<String, dynamic> get getTaskData => _taskData;
  List<Map<String, dynamic>> getReply(String id) {
    List<Map<String, dynamic>> data = [];
    for (int i = 0; i < _model.getReply.length; i++) {
      data.add({
        "text": _model.getReply[i]["text"],
        "isSender": _model.getReply[i]["ownerId"] == id,
        "time":  DateFormat("dd MMMM - hh:mm a").format(_model.getReply[i]["time"]),
        "imageUrl": _model.getReply[i]["imageUrl"]
      });
    }
    return data;
  }

  void clearModel() {
    _model = HelpDeskReplyModel();
  }

  Future<bool> createMessage(BuildContext context, String docId, Map<String, dynamic> detail) async {
    try {
      bool isAdmin = context.read<AppViewModel>().app.getUser.getRole == 0;
      if (isAdmin) {
        await context.read<HelpDeskViewModel>().editTask(
          getTaskData["docId"], 
          true, 
          1
        );
      }
      return await _service.setSubDocument(docId, "replyChannel", DateTime.now().millisecondsSinceEpoch.toString() ,detail);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return false;
    }
  }

  void reconstructData(QuerySnapshot snapshot) {
    for (int i = 0; i < snapshot.docChanges.length; i++) {
      DocumentSnapshot doc = snapshot.docChanges[i].doc;
      if (snapshot.docChanges[i].type == DocumentChangeType.added) {
        _model.addReply(doc.get("ownerId"), doc.get("message"), (doc.get("time") as Timestamp).toDate(), doc.get("seen"), doc.get("imageUrl"));
      } 
      if (snapshot.docChanges[i].type == DocumentChangeType.modified) {
        int index = snapshot.docChanges[i].newIndex;
        _model.changeSeenStatus(index, doc.get("seen"));
      }
    }
  }

  Future<String?> getImageUrl(Uint8List? file, String fileName, String docId) async {
    try {
      String? imageUrl;
      if (file != null) {
        FirebaseStorage storage = FirebaseStorage.instance;
        Reference ref = storage.ref().child("ticket/$docId/Image-$fileName");

        UploadTask task = ref.putData(file);
        await task.whenComplete(() async {
          var url = await ref.getDownloadURL();
          imageUrl = url.toString();
        }).catchError((e) {
          if (kDebugMode) {
            print(e);
          }
        });
        return imageUrl;
      }
      return null;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return null;
    }
    
  }
}