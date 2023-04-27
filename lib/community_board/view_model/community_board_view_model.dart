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
  final _serviceCategory = FirebaseServices("category");
  final _serviceUser = FirebaseServices("user");
  List<Map<String, dynamic>> _posts = [];
  Map<String, dynamic> _detail = {};
  final int _limit = 10;
  bool _isShowPostDetail = false;
  bool _isDetailNotEmpty = true;
  bool _isTitleNotEmpty = true;
  bool _isSafeLoad = true;
  bool _isSafeClick = true;
  List<Topic> _alltopic = [];

  get getIsSafeClick => _isSafeClick;
  set setIsSafeClick(bool state) => _isSafeClick = state;

  get getIsSafeLoad => _isSafeLoad;
  set setIsSafeLoad(bool state) => _isSafeLoad = state;

  get getIsDetailNotEmpty => _isDetailNotEmpty;
  set setIsDetailNotEmpty(bool state) {
    _isDetailNotEmpty = state;
    notifyListeners();
  }

  get getIsTitleNotEmpty => _isTitleNotEmpty;
  set setIsTitleNotEmpty(bool state) {
    _isTitleNotEmpty = state;
    notifyListeners();
  }

  get getAllTopic => _alltopic;
  void addAllTopic(String text) {
    _alltopic.add(Topic(name: text));
  }

  get getIsShowPostDetail => _isShowPostDetail;
  get getPostDetail => _detail;
  void setIsShowPostDetail(
      bool isMobile, bool state, Map<String, dynamic> detail) {
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
      "isApproved": false,
      "approvedTime": ""
    };
    await _service.setDocument(id, postDetail);
  }

  Future<void> getNextPost(String topic, DocumentSnapshot? startDoc) async {
    if (startDoc != null) {
      final snapshot = await _service.getDocumnetByKeyValuePair([
        "topics",
        "isApproved"
      ], [
        [topic],
        true
      ],
          orderingField: "dateCreate",
          descending: true,
          limit: _limit,
          startDoc: startDoc);
      if (snapshot!.docs.isNotEmpty) {
        List<dynamic> postList =
            _posts.where((element) => element["topic"] == topic).toList();
        for (int i = 0; i < snapshot.docs.length; i++) {
          final userSnapshot =
              await _serviceUser.getDocumentById(snapshot.docs[i].get("ownerId"));
          final commentSnapshot =
              await _service.getAllSubDocument(snapshot.docs[i].id, "comment");
          postList[0]["post"].addPost(
            snapshot.docs[i].get("ownerId"),
            userSnapshot!.get("name"),
            snapshot.docs[i].get("title").toString(),
            snapshot.docs[i].get("detail").toString(),
            commentSnapshot!.size,
            snapshot.docs[i].get("topics"),
            postId: snapshot.docs[i].id,
            docId: snapshot.docs[i].id,
            postDateCreate: snapshot.docs[i].get("dateCreate").toDate(),
          );
        }
        postList[0]["lastDoc"] = snapshot.docs.last;
        notifyListeners();
      }
    }
  }

  void clearController() {
    _isSafeClick = true;
    _isSafeLoad = true;
  }

  Future<void> getPostByTopic(String topic, {bool isLoadAll = false}) async {
    try {
      _isSafeLoad = false;
      clearPost();
      dynamic snapshot;
      if (isLoadAll) {
        snapshot = await _service.getDocumnetByKeyValuePair(
            ["isApproved"], [true],
            orderingField: "dateCreate", descending: true, limit: 50);
      } else {
        snapshot = await _service.getDocumnetByKeyValuePair(
          ["topics", "isApproved"],
          [
            [topic],
            true
          ],
          orderingField: "dateCreate",
          descending: true,
          limit: _limit,
        );
      }
      if (snapshot!.size != 0) {
        CommunityBoardModel model = CommunityBoardModel();
        for (int i = 0; i < snapshot.docs.length; i++) {
          final userSnapshot = await _serviceUser
              .getDocumentById(snapshot.docs[i].get("ownerId"));
          final commentSnapshot =
              await _service.getAllSubDocument(snapshot.docs[i].id, "comment");
          if (isLoadAll) {
            List<dynamic> topic = snapshot.docs[i].get("topics");
            for (int j = 0; j < topic.length; j++) {
              List<dynamic> postList = _posts
                  .where((element) => element["topic"] == topic[j])
                  .toList();
              if (postList.isEmpty) {
                CommunityBoardModel post = CommunityBoardModel();
                final categorySnapshot =
                    await _serviceCategory.getDocumentById(topic[j]);
                post.addPost(
                  snapshot.docs[i].get("ownerId"),
                  userSnapshot!.get("name"),
                  snapshot.docs[i].get("title").toString(),
                  snapshot.docs[i].get("detail").toString(),
                  commentSnapshot!.size,
                  snapshot.docs[i].get("topics"),
                  postId: snapshot.docs[i].id,
                  docId: snapshot.docs[i].id,
                  postDateCreate: snapshot.docs[i].get("dateCreate").toDate(),
                );
                _posts.add({
                  "topic": topic[j],
                  "description": categorySnapshot!.get("description"),
                  "lastDoc": snapshot.docs[i],
                  "post": post
                });
              } else if (postList.length < 10) {
                postList[0]["post"].addPost(
                  snapshot.docs[i].get("ownerId"),
                  userSnapshot!.get("name"),
                  snapshot.docs[i].get("title").toString(),
                  snapshot.docs[i].get("detail").toString(),
                  commentSnapshot!.size,
                  snapshot.docs[i].get("topics"),
                  postId: snapshot.docs[i].id,
                  docId: snapshot.docs[i].id,
                  postDateCreate: snapshot.docs[i].get("dateCreate").toDate(),
                );
                postList[0]["lastDoc"] = snapshot.docs[i];
              }
            }
          } else {
            model.addPost(
              snapshot.docs[i].get("ownerId"),
              userSnapshot!.get("name"),
              snapshot.docs[i].get("title").toString(),
              snapshot.docs[i].get("detail").toString(),
              commentSnapshot!.size,
              snapshot.docs[i].get("topics"),
              postId: snapshot.docs[i].id,
              docId: snapshot.docs[i].id,
              postDateCreate: snapshot.docs[i].get("dateCreate").toDate(),
            );
          }
        }
        if (!isLoadAll && topic.isNotEmpty) {
          final categorySnapshot =
              await _serviceCategory.getDocumentById(topic);
          _posts.add({
            "topic": topic,
            "description": categorySnapshot!.get("description"),
            "lastDoc": snapshot.docs.last,
            "post": model
          });
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print("err $e");
      }
    }
  }

  bool validateNameField(String input) {
    if (input.isEmpty) {
      return false;
    }
    if (input.contains(RegExp(r'^[\s\S]+$'))) {
      return true;
    }
    return false;
  }

  Future<void> createComment(CreateCommentRequest request) async {
    try {
      String id = getUuid();
      await _service.setSubDocument(request.docId, "comment", id, {
        "id": id,
        "ownerId": request.ownerId,
        "detail": request.text,
        "dateCreate": DateTime.now(),
        "dateEdit": null
      });
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future<void> editComment(EditCommentRequest request) async {
    try {
      await _service.editSubDocument(request.parentId, "comment", request.docId,
          {"detail": request.text, "dateEdit": DateTime.now()});
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future<void> deleteComment(String parentId, String subId) async {
    await _service.deleteSubDocument(parentId, "comment", subId);
  }

  Future<bool> createTopics(CreateTagRequest request) async {
    return await _serviceCategory.setDocument(request.name, {
      "name": request.name,
      "description": "",
      "isApproved": false,
      "isHelpDesk": false,
      "isCommunity": true,
    });
  }

  String getUuid() {
    return const Uuid().v1();
  }
}
