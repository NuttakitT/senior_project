import 'package:image_picker/image_picker.dart';

class CommunityBoardModel {}

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
