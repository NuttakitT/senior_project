import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senior_project/community_board/model/community_board_model.dart';
import 'package:senior_project/core/datasource/firebase_services.dart';
import 'package:senior_project/core/view_model/app_view_model.dart';
import 'package:uuid/uuid.dart';

class Topic {
  final String name;

  Topic({required this.name});
}

class CommunityBoardViewModel extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();
  final _service = FirebaseServices("post");
  final _topic = FirebaseServices("unapprovetopic");

  List<Map<String, dynamic>> _posts = [];

  Future<void> createPost(
      CreatePostRequest request, BuildContext context) async {
    final docId = getUuid();
    final userId = context.watch<AppViewModel>().app.getUser.getId;
    // TODO: files are not yet prepared
    Map<String, dynamic> postDetail = {
      "id": docId,
      "ownerId": userId,
      "title": request.title,
      "detail": request.detail,
      // "files": request.files,
      "topics": request.topics,
      "isApproved": false
    };
    await _service.setDocument(docId, postDetail);
  }

  // fetch all posts returns true when there is a snapshot else return false.
  Future<bool> fetchAllPosts() async {
    final snapshot = await _service.getAllDocument();

    if (snapshot?.size == 0) {
      return false;
    }

    for (QueryDocumentSnapshot doc in snapshot!.docs) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      _posts.add(data);
    }

    return true;
  }

  List<Map<String, dynamic>> getPost() {
    return _posts;
  }

  bool validateNameField(String input) {
    if (input.isEmpty) {
      return false;
    }
    if (input.contains(RegExp('^[a-zA-Z]+'))) {
      return true;
    }
    return false;
  }

  Future<Map<String, dynamic>?> getPostDetail(String docId) async {
    final snapshot = await _service.getDocumentById(docId);

    if (snapshot != null) {
      final data = snapshot.data() as Map<String, dynamic>;
      return data;
    }
    return null;
  }

  Future<void> approvePost(String docId) async {}

  Future<void> createComment(CreateCommentRequest request) async {}
  Future<void> editComment(EditCommentRequest request) async {}
  Future<void> deleteComment(String docId) async {}

  Future<bool> createTopics(CreateTagRequest request) async {
    return await _topic.addDocument({"id": request.id, "name": request.name});
  }

  String getUuid() {
    return const Uuid().v1();
  }
}
