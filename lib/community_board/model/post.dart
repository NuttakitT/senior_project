// ignore_for_file: prefer_final_fields

import 'package:senior_project/core/model/content.dart';
import 'package:uuid/uuid.dart';

class Post {
  late String _id;
  late String _docId;
  late String _ownerId;
  late String _ownerName;
  late Content _content;
  late String? _imageUrl;
  late DateTime _dateCreate;
  late int _comment;
  List<dynamic> _topic = [];
  late bool isApproved;

  Post(String ownerId, String ownerName, String? imageUrl, int comment, {String? id, String? docId, DateTime? dateCreate}) {
    _ownerId = ownerId;
    _ownerName = ownerName;
    _comment = comment;
    _imageUrl = imageUrl;
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
    if (docId != null) {
      _docId = docId;
    }
  }

  void addTopic(String topic) {
    _topic.add(topic);
  }

  void addContent(String title, String detail) {
    _content = Content(title);
    _content.setOptionalString = detail;
  }

  get getImageUrl => _imageUrl;
  get getComment => _comment;
  get getDocId => _docId;
  get getId => _id;
  get getDateCreate => _dateCreate;
  get getTopic => _topic;
  get getContent => _content;
  get getOwnerId => _ownerId;
  get getOwnerName => _ownerName;
}