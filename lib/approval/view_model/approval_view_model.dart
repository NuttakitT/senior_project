import 'package:flutter/material.dart';
import 'package:senior_project/approval/model/approval_model.dart';
import 'package:uuid/uuid.dart';
import 'package:provider/provider.dart';
import 'package:senior_project/core/datasource/firebase_services.dart';
import 'package:senior_project/core/view_model/app_view_model.dart';

class ApprovalViewModel extends ChangeNotifier {
  final _service = FirebaseServices("post");

  // Future<void> approvalPost(
  //     ApprovalRequset requset, BuildContext context) async {
  //   Map<String, dynamic> postApprove = {
  //     "isApproved": false,
  //     };
  //   await _service.editDocument(postApprove);
  // }

  Future<Map<String, dynamic>?> getPostDetail(String docId) async {
    final snapshot = await _service.getDocumentById(docId);

    if (snapshot != null) {
      final data = snapshot.data() as Map<String, dynamic>;
      return data;
    }
    return null;
  }

  String getUuid() {
    return const Uuid().v1();
  }
}
