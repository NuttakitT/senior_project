import 'package:image_picker/image_picker.dart';

class CommunityBoardModel {}

class CreatePostRequest {
  String title;
  String detail;
  List<XFile>? files;
  List<String> topics;
  bool isApproved;

  CreatePostRequest(
      {required this.title,
      required this.detail,
      this.files,
      required this.topics,
      required this.isApproved});
}

class CreateCommentRequest {}

class EditCommentRequest {}

class CreateTagRequest {}
