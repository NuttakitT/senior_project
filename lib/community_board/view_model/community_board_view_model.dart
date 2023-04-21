// ignore_for_file: prefer_is_empty, prefer_final_fields

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
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
  final _serviceUser = FirebaseServices("user");
  final _topic = FirebaseServices("topic");
  List<Map<String, dynamic>> _posts = [];
  Map<String, dynamic> _detail = {};
  final int _limit = 10;
  bool _isShowPostDetail = false;

  get getIsShowPostDetail => _isShowPostDetail;
  get getPostDetail => _detail;
  void setIsShowPostDetail(bool isMobile, bool state, Map<String, dynamic> detail) {
    _isShowPostDetail = state;
    _detail = detail;
    if (!isMobile) {
      notifyListeners();
    }
  } 

  get getPost => _posts;
  void clearPost() {
    _posts = [];
  }

  Future<void> createPost(
      CreatePostRequest request, BuildContext context) async {
    String id = getUuid();
    String userId = context.read<AppViewModel>().app.getUser.getId;
    // TODO: files are not yet prepared
    Map<String, dynamic> postDetail = {
      "id": id,
      "ownerId": userId,
      "title": request.title,
      "detail": request.detail,
      "dateCreate": DateTime.now(),
      // "files": request.files,
      "topics": request.topics,
      "isApproved": false
    };
    await _service.setDocument(id, postDetail);
  }

  Future<void> getPostByTopic(String topic, {DocumentSnapshot? startDoc, bool isLoadMore = false}) async {
    try {
      final snapshot = await _service.getDocumnetByKeyValuePair(
        ["topics"], 
        [[topic]],
        orderingField: "dateCreate",
        limit: _limit,
        startDoc: startDoc
      );
      if (snapshot!.size != 0) {
        CommunityBoardModel model = CommunityBoardModel();
        for (int i = 0; i < snapshot.docs.length; i++) {
          final userSnapshot = await _serviceUser.getDocumentById(snapshot.docs[i].get("ownerId"));
          model.addPost(
            snapshot.docs[i].get("ownerId"),
            userSnapshot!.get("name"),
            snapshot.docs[i].get("title").toString(),
            snapshot.docs[i].get("detail").toString(),
            snapshot.docs[i].get("topics"),
            postId: snapshot.docs[i].id,
            docId: snapshot.docs[i].id,
            postDateCreate: snapshot.docs[i].get("dateCreate").toDate(),
          );

        }
        if (!isLoadMore) {
          clearPost();
        }
        _posts.add({
          "topic": topic,
          "lastDoc": snapshot.docs.last,
          "post": model
        });
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
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

  Future<void> approvePost(String docId) async {}

  Future<void> createComment(CreateCommentRequest request) async {
    try {
      String id = getUuid();
      await _service.setSubDocument(
        request.docId, 
        "comment", 
        id, 
        {
          "id": id,
          "ownerId": request.ownerId,
          "detail": request.text,
          "dateCreate": DateTime.now()
        } 
      );
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future<void> editComment(EditCommentRequest request) async {}

  Future<void> deleteComment(String parentId, String subId) async {
    await _service.deleteSubDocument(parentId, "comment", subId);
  }

  Future<bool> createTopics(CreateTagRequest request) async {
    return await _topic.setDocument(
      request.id, 
      {
        "id": request.id, 
        "name": request.name,
        "detail": null, 
        "isApproved": false
      }
    );
  }

  String getUuid() {
    return const Uuid().v1();
  }
}
