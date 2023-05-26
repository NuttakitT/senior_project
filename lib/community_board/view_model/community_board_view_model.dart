// ignore_for_file: prefer_is_empty, prefer_final_fields, depend_on_referenced_packages, library_prefixes

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senior_project/community_board/model/community_board_model.dart';
import 'package:senior_project/core/datasource/algolia_services.dart';
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
  final AlgoliaServices _algolia = AlgoliaServices("post");
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
    final userSnapshot = await _serviceUser.getDocumentById(userId);
    Map<String, dynamic> postDetail = {
      "id": id,
      "ownerId": userId,
      "title": request.title,
      "detail": request.detail,
      "dateCreate": DateTime.now(),
      "imageUrl": request.imageUrl,
      "topics": request.topics,
      "isApproved": false,
      "approvedTime": ""
    };
    postDetail.addAll({
      "ownerName": userSnapshot!.get("name"),
      "comment": 0
    });
    String? objectId = await _algolia.addObject(id, postDetail);
    postDetail.remove("ownerName");
    postDetail.remove("comment");
    postDetail.addAll({"objectID": objectId!});
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

  void clearAllTopic() {
    _alltopic = [];
  }

  Future<void> getPostByTopic(String topic, {bool isLoadAll = false}) async {
    try {
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
        clearPost();
        _isSafeLoad = false;
        CommunityBoardModel model = CommunityBoardModel();
        for (int i = 0; i < snapshot.docs.length; i++) {
          final userSnapshot = await _serviceUser
              .getDocumentById(snapshot.docs[i].get("ownerId"));
          final commentSnapshot =
              await _service.getAllSubDocument(snapshot.docs[i].id, "comment");
          if (isLoadAll) {
            List<dynamic> topic = snapshot.docs[i].get("topics");
            for (int j = 0; j < topic.length; j++) {
              List<Map<String, dynamic>> postList = _posts
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
                  snapshot.docs[i].get("imageUrl"),
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
                  snapshot.docs[i].get("imageUrl"),
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
              snapshot.docs[i].get("imageUrl"),
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
        "imageUrl": request.imageUrl,
        "dateCreate": DateTime.now(),
        "dateEdit": null
      });
      final objectId = await _service.getDocumentById(request.docId);
      final reply = await _service.getAllSubDocument(request.docId, "comment");
      await _algolia.updateObject(objectId!.get("objectID"), {
        "comment": reply!.size
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
    final objectId = await _service.getDocumentById(parentId);
    final reply = await _service.getAllSubDocument(parentId, "comment");
    await _algolia.updateObject(objectId!.get("objectID"), {
      "comment": reply!.size
    });
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

  void reconstructSearchResult(List<dynamic> hits, String topic) {
    clearPost();
    clearController();
    CommunityBoardModel model = CommunityBoardModel();
    for (var item in hits) {
      bool isTagetObject = false;
      List<dynamic> topics = item["topics"] as List<dynamic>;
      bool isApproved = item["isApproved"] as bool;
      if (topic.isNotEmpty) {
        if (topics.toString().contains(topic) && isApproved) {
          isTagetObject = true;
        } 
      } else if (isApproved) {
        isTagetObject = true;
      }
      if (isTagetObject) {
        model.addPost(
          item["ownerId"],
          item["ownerName"],
          item["title"],
          item["detail"],
          item["comment"],
          item["imageUrl"],
          item["topics"],
          postId: item["id"],
          docId: item["id"],
          postDateCreate: DateTime.parse(item["dateCreate"])
        );
      }
    }
    _posts.add({
      "post": model
    });
  }

  Future<String?> getImageUrl(Uint8List? file, String fileName, String path) async {
    try {
      String? imageUrl;
      if (file != null) {
        FirebaseStorage storage = FirebaseStorage.instance;
        Reference ref = storage.ref().child("$path/Image-$fileName");

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

// *****************************************************************************
  final _serviceFaq = FirebaseServices("faq");
  final AlgoliaServices _algoliaFaq = AlgoliaServices("faq");
  List<Map<String, dynamic>> _faq = [];

  get getFaq => _faq;

  Future<void> createFaq(Map<String, dynamic> detail) async {
    try {
      String docId = DateTime.now().millisecondsSinceEpoch.toString();
      detail.addAll({"id": docId});
      String? objectId = await _algoliaFaq.addObject(docId, detail);
      detail.addAll({"objectId": objectId});
      _serviceFaq.setDocument(docId, detail);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future<void> editFaq(String docId, Map<String, dynamic> detail) async {
    try {
      final snapshot =await _serviceFaq.getDocumentById(docId);
      await _serviceFaq.editDocument(docId, detail);
      await _algoliaFaq.updateObject(snapshot!.get("objectId"), detail);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future<void> deleteFaq(String docId) async {
    try {
      final snapshot = await _serviceFaq.getDocumentById(docId);
      await _algoliaFaq.deleteObject(snapshot!.get("objectId"));
      await _serviceFaq.deleteDocument(docId);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future<void> fetchFaq(String category) async {
    try {
      dynamic snapshot;
      if (category.isNotEmpty) {
        snapshot = await _serviceFaq.getDocumnetByKeyValuePair(
          ["category"], 
          [category]
        );
      } else {
        snapshot = await _serviceFaq.getAllDocument();
      }
      if (snapshot!.size != 0) {
        _faq = [];
        _isSafeLoad = false;
        for (int i = 0; i < snapshot.docs.length; i++) {
          List<Map<String, dynamic>> faqList = _faq.where((element) => element["category"] == snapshot.docs[i].get("category")).toList();
          final categorySnapshot = await _serviceCategory.getDocumentById(snapshot.docs[i].get("category"));
          if (faqList.isEmpty) {
            if (snapshot.docs[i].get("category") == "General") {
              _faq.insert(0, {
                "category": snapshot.docs[i].get("category"),
                "description": categorySnapshot!.get("description"),
                "faq": [{
                  "id": snapshot.docs[i].id,
                  "question": snapshot.docs[i].get("question"),
                  "answer": snapshot.docs[i].get("answer")
                }],
                "lastDoc": snapshot.docs[i]
              });
            } else {
              _faq.add({
                "category": snapshot.docs[i].get("category"),
                "description": categorySnapshot!.get("description"),
                "faq": [{
                  "id": snapshot.docs[i].id,
                  "question": snapshot.docs[i].get("question"),
                  "answer": snapshot.docs[i].get("answer")
                }],
                "lastDoc": snapshot.docs[i]
              });
            }
          } else {
            if (category.isEmpty && faqList[0]["faq"].length < 3) {
              faqList[0]["lastDoc"] = snapshot.docs[i];
              faqList[0]["faq"].add({
                "id": snapshot.docs[i].id,
                "question": snapshot.docs[i].get("question"),
                "answer": snapshot.docs[i].get("answer")
              });
            } else if (category.isNotEmpty) {
              faqList[0]["lastDoc"] = snapshot.docs[i];
              faqList[0]["faq"].add({
                "id": snapshot.docs[i].id,
                "question": snapshot.docs[i].get("question"),
                "answer": snapshot.docs[i].get("answer")
              });
            }
          }
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print("err $e");
      }
    }
  }  

  Future<void> getNextFaq(String topic, DocumentSnapshot? startDoc) async {
    if (startDoc != null) {
      final snapshot = await _serviceFaq.getDocumnetByKeyValuePair(
        ["category"], 
        [topic],
        limit: 5,
        startDoc: startDoc);
      if (snapshot!.docs.isNotEmpty) {
        List<Map<String, dynamic>> faqList = _faq.where((element) => element["category"] == topic).toList();
        for (int i = 0; i < snapshot.docs.length; i++) {
          faqList[0]["faq"].add({
            "id": snapshot.docs[i].id,
            "question": snapshot.docs[i].get("question"),
            "answer": snapshot.docs[i].get("answer")
          });
        }
        faqList[0]["lastDoc"] = snapshot.docs.last;
        notifyListeners();
      }
    }
  }
  
  void reconstructSearchFaqResult(List<dynamic> hits, String category) {
    try {
      _faq = [];
      clearController();
      for (var item in hits) {
        bool isTagetObject = false;
        if (category.isNotEmpty) {
          if (item["category"].toString().contains(category)) {
            isTagetObject = true;
          } 
        } else {
          isTagetObject = true;
        }
        if (isTagetObject) {
          _faq.add({
            "category": item["category"],
            "id": item["id"],
            "question": item["question"],
            "answer": item["answer"]
          });
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }
}
