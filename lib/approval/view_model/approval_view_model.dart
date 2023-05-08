import 'package:flutter/foundation.dart';
import 'package:senior_project/approval/model/approval_model.dart';
import 'package:senior_project/core/datasource/algolia_services.dart';
import 'package:uuid/uuid.dart';
import 'package:senior_project/core/datasource/firebase_services.dart';

class ApprovalViewModel extends ChangeNotifier {
  final _service = FirebaseServices("post");
  final _name = FirebaseServices("user");
  final _apptopic = FirebaseServices("category");
  final ApprovalModel _model = ApprovalModel();
  final AlgoliaServices _algolia = AlgoliaServices("post");
  bool _isSafeClick = true;
  bool _isSafeLoad = true;

  get getIsSafeLoad => _isSafeLoad;
  set setIsSafeLoad(bool state) => _isSafeLoad = state;

  get getIsSafeClick => _isSafeClick;
  set setIsSafeClick(bool state) => _isSafeClick = state;

  void clearModel() {
    _model.clearModel();
  }

  Future<void> getPostAll(String topic) async {
    try {
      _isSafeLoad = false;
      clearModel();
      final snapshot = await _service.getDocumnetByKeyValuePair(
        topic.isEmpty ? ["approvedTime"] : ["approvedTime", "topics"], 
        topic.isEmpty ? [""] : ["", [topic]],
        orderingField: "dateCreate"
      );
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
            "isApproved": snapshot.docs[i].get("isApproved"),
            "approvedTime": "",
            "imageUrl": snapshot.docs[i].get("imageUrl"),
          };
        }
      } else {
        clearModel();
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
    DateTime now = DateTime.now();
    await _service.editDocument(
        docId, {"isApproved": isApproved, "approvedTime": now});
    final objectId = await _service.getDocumentById(docId);
    await _algolia.updateObject(
      objectId!.get("objectID"), 
      {"isApproved": isApproved, "approvedTime": now}
    );
  }

  Future<void> approveTopic(bool isApproved, String docId) async {
    try {
      await _apptopic.editDocument(docId, {"isApproved": isApproved});
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  String getUuid() {
    return const Uuid().v1();
  }

  void reconstreuctTextSearch(List<dynamic> hits, String topic) {
    clearModel();
    for (var item in hits) {
      bool isTagetObject = false;
      bool isApproved = item["isApproved"] as bool;
      dynamic approvedTime = item["approvedTime"];
      List<dynamic> topics = item["topics"] as List<dynamic>;
      if (topic.isNotEmpty) {
        if (topics.toString().contains(topic) && approvedTime.toString().isEmpty) {
          isTagetObject = true;
        } 
      } else if (approvedTime.toString().isEmpty) {
        isTagetObject = true;
      }
      if (isTagetObject) {
        _model.setPostDetail = {
          "id": item["id"],
          "ownerId": item["ownerId"],
          "ownerName": item["ownerName"],
          "detail": item["detail"],
          "title": item["title"],
          "topics": item["topics"],
          "dateCreate": DateTime.parse(item["dateCreate"]),
          "isApproved": isApproved,
          "approvedTime": "",
          "imageUrl": item["imageUrl"]
        };
      }
    }
  }
}
