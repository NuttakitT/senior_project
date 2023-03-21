import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:senior_project/community_board/model/community_board_model.dart';
import 'package:senior_project/core/datasource/firebase_services.dart';
import 'package:senior_project/core/view_model/app_view_model.dart';
import 'package:uuid/uuid.dart';
import 'dart:io';

class CommunityBoardViewModel extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();
  final _service = FirebaseServices("post");

  List<Map<String, dynamic>> _posts = [];

  Future<void> createPost(CreatePostRequest request) async {
    final docId = getUuid();
    final userId = ""; // need to get UserId from AppViewModel
    // TODO: files are not yet prepared
    Map<String, dynamic> postDetail = {
      "id": docId,
      "ownerId": userId,
      "title": request.title,
      "detail": request.detail,
      "files": request.files,
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

    List<Map<String, dynamic>> posts = [];

    for (QueryDocumentSnapshot doc in snapshot!.docs) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      posts.add(data);
    }

    _posts = posts;
    return true;
  }

  List<Map<String, dynamic>> getPostFor(int amount) {
    Iterable<Map<String, dynamic>> iterable = _posts.take(amount);
    return iterable.toList();
  }

  List<Map<String, dynamic>> getAllPostFromCategory(List<String> categories) {
    List<Map<String, dynamic>> filteredPosts = _posts
        .where((post) =>
            post['categories'].any((category) => categories.contains(category)))
        .toList();
    return filteredPosts;
  }

  Future<void> getPostDetail(String docId) async {}
  Future<void> approvePost(String docId) async {}

  Future<void> createComment(CreateCommentRequest request) async {}
  Future<void> editComment(EditCommentRequest request) async {}
  Future<void> deleteComment(String docId) async {}

  Future<void> createTags(CreateTagRequest request) async {}

  String getUuid() {
    return const Uuid().v1();
  }
}
