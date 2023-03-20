import 'package:flutter/material.dart';
import 'package:senior_project/community_board/model/community_board_model.dart';

class CommunityBoardViewModel extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();

  Future<void> createPost(CreatePostRequest request) async {}
  Future<void> getAllPosts(int limit) async {}
  Future<void> getAllPostFromCategory(String category, int limit) async {}
  Future<void> getPostDetail(String docId) async {}
  Future<void> approvePost(String docId) async {}

  Future<void> createComment(CreateCommentRequest request) async {}
  Future<void> editComment(EditCommentRequest request) async {}
  Future<void> deleteComment(String docId) async {}

  Future<void> createTags(CreateTagRequest request) async {}
}
