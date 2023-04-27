import 'package:flutter/foundation.dart';
import 'package:senior_project/approval/model/approval_model.dart';
import 'package:uuid/uuid.dart';
import 'package:senior_project/core/datasource/firebase_services.dart';

class ApprovalViewModel extends ChangeNotifier {
  final _service = FirebaseServices("post");
  final _name = FirebaseServices("user");
  final _apptopic = FirebaseServices("category");
  final ApprovalModel _model = ApprovalModel();

  Future<void> getPostAll() async {
    try {
      _model.clearModel();
      final snapshot = await _service.getDocumnetByKeyValuePair(
          ["approvedTime"], [""],
          orderingField: "dateCreate");
      if (snapshot!.docs.isNotEmpty) {
        for (int i = 0; i < snapshot.docs.length; i++) {
          final snapshotname =
              await _name.getDocumentById(snapshot.docs[i].get("ownerId"));
          _model.setPostDetail = {
            "id": snapshot.docs[i].get("id"),
            "ownerId": snapshot.docs[i].get("ownerId"),
            "ownerName": snapshotname!.get("name"),
            "detail": snapshot.docs[i].get("detail"),
            "title": snapshot.docs[i].get("title"),
            "topics": snapshot.docs[i].get("topics"),
            "dateCreate": snapshot.docs[i].get("dateCreate").toDate(),
            "approvedTime": "",
          };
        }
      } else {
        _model.clearModel();
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  get getPost {
    return _model.getPostDeatail;
  }

  Future<void> approvePost(bool isApproved, String docId) async {
    await _service.editDocument(
        docId, {"isApproved": isApproved, "approvedTime": DateTime.now()});
  }

  Future<void> approveTopic(bool isApproved, String docId) async {
    try {
      await _apptopic.editDocument(docId, {"isApproved": isApproved});
    } catch (e) {
      print(e);
    }
  }

  String getUuid() {
    return const Uuid().v1();
  }
}
