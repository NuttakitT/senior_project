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
  final int _limit = 10;

  get getPost => _posts;

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

  Future<void> getPostByTopic(String topic, {DocumentSnapshot? startDoc}) async {
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
            postDateCreate: snapshot.docs[i].get("dateCreate").toDate(),
          );

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

  // fetch all posts returns true when there is a snapshot else return false.
  // Future<bool> fetchAllPosts() async {
  //   final snapshot = await _service.getAllDocument();
  //   await getPostByTopic("General");

  //   if (snapshot?.size == 0) {
  //     return false;
  //   }

  //   for (QueryDocumentSnapshot doc in snapshot!.docs) {
  //     Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
  //     _posts.add(data);
  //   }

  //   return true;
  // }

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
