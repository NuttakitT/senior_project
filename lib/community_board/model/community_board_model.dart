// ignore_for_file: prefer_final_fields

import 'package:senior_project/community_board/model/post.dart';

class CommunityBoardModel {
  List<Post> _post = [];

  CommunityBoardModel() {
    _post = [];
  }
  
  get getPost => _post;
  void addPost(
    String ownerId, 
    String ownerName, 
    String title, 
    String detail, 
    int? comment,
    String? imageUrl,
    List<dynamic> topic,
    {String? postId, String? docId, DateTime? postDateCreate}
  ) {
    comment ??= 0;
    Post post = Post(ownerId, ownerName, imageUrl, comment, id: postId, docId: docId, dateCreate: postDateCreate);
    post.addContent(title, detail);
    for (int i = 0; i < topic.length; i++) {
      post.addTopic(topic[i].toString());
    }
    _post.add(post);
  }
}

class CreatePostRequest {
  String title;
  String detail;
  String? imageUrl;
  List<String> topics;
  bool isApproved = false;

  CreatePostRequest(
      {required this.title,
      required this.detail,
      required this.imageUrl,
      required this.topics});
}

class CreateCommentRequest {
  dynamic docId;
  dynamic ownerId;
  dynamic text;

  CreateCommentRequest(this.docId, this.ownerId, this.text);
}

class EditCommentRequest {
  dynamic parentId;
  dynamic docId;
  dynamic text;

  EditCommentRequest(this.parentId, this.docId, this.text);
}

class CreateTagRequest {
  String id;
  String name;

  CreateTagRequest({required this.id, required this.name});
}
