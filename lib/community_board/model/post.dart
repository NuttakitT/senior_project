// ignore_for_file: prefer_final_fields

import 'package:senior_project/community_board/model/comment.dart';
import 'package:senior_project/core/model/content.dart';
import 'package:uuid/uuid.dart';

class Post {
  late  String _id;
  late String _ownerId;
  late Content _content;
  late DateTime _dateCreate;
  List<dynamic> _topic = [];
  List<Comment> _comment = [];
  late bool isApproved;

  Post(String ownerId, {String? id, DateTime? dateCreate}) {
    _ownerId = ownerId;
    if (id != null) {
      _id = id;
    } else {
      _id = const Uuid().v1();
    }
    if (dateCreate != null) {
      _dateCreate = dateCreate;
    } else {
      _dateCreate = DateTime.now();
    }
  }

  void addTopic(String topic) {
    _topic.add(topic);
  }

  void addContent(String title, String detail) {
    _content = Content(title);
    _content.setOptionalString = detail;
  }

  void addComment(String ownerId, String detail, {String? id}) {
    Comment comment = Comment(ownerId, id: id);
    comment.createComment(detail);
    _comment.add(comment);
  }

  get getId => _id;
  get getDateCreate => _dateCreate;
  get getTopic => _topic;
  get getContent => _content;
  get getOwnerId => _ownerId;
  get getComment => _comment;
}