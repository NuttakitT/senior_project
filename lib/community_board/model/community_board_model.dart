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
    List<dynamic> topic,
    {String? postId, DateTime? postDateCreate}
  ) {
    Post post = Post(ownerId, ownerName, id: postId, dateCreate: postDateCreate);
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
  // List<XFile>? files;
  List<String> topics;
  bool isApproved = false;

  CreatePostRequest(
      {required this.title,
      required this.detail,
      // this.files,
      required this.topics});
}

class CreateCommentRequest {}

class EditCommentRequest {}

class CreateTagRequest {
  String id;
  String name;

  CreateTagRequest({required this.id, required this.name});
}
