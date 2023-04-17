import 'dart:html';

import 'package:senior_project/core/model/content.dart';
import 'package:uuid/uuid.dart';

class Comment {
  late final String _id;
  late final String _ownerId;
  late DateTime _dateCreate;
  late Content _comment;
  
  Comment(String ownerId, {String? id}) {
    _ownerId = ownerId;
    if (id != null) {
      _id = id;
    } else {
      _id = const Uuid().v1();
    }
  }

  void createComment(String comment, {File? file}) {
    _comment = Content(comment);
    // if (file != null) {
    //   _comment.addFile(file);
    // }
  }

  get getOwnerId => _ownerId;
  get getCommentId => _id;
  get getComment => _comment;
  get getDateCreate => _dateCreate;
}