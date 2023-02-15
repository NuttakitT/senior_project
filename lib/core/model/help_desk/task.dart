import 'package:senior_project/core/model/content.dart';
import 'package:senior_project/core/model/help_desk/reply_channel.dart';

class Task {
  late String _id;
  late String _ownerId;
  late DateTime _dateCreate;
  late String _category;
  late int _priority;
  late int _status;
  late String _title;
  late Content _content;
  ReplyChannel? _replyCannel;

  Task(
    String ownerId,
    String title,
    Content content,
    int priority,
    String category,
    {String? id, DateTime? dateCreate}
  ) {
    if (id != null) {
      _id = id;
    } else {  
      _id = DateTime.now().microsecondsSinceEpoch.toString();
    } 
    if (dateCreate != null) {
      _dateCreate = dateCreate;
    } else {
      _dateCreate = DateTime.now();
    }
    _ownerId = ownerId;
    _title = title;
    _content = content;
    _priority = priority;
    _category = category;
    _status = 0;
  }

  String get getTaskId => _id;
  String get getOwnerId => _ownerId;
  DateTime get getDateCreate => _dateCreate;
  String get getCategory => _category;
  int get getStatus => _status;
  int get getPriority => _priority;
  String get getTitle => _title;
  Content get getContent => _content;
  ReplyChannel? get getRepkyChannel => _replyCannel;

  bool changePriority(int newPriority) {
    if (newPriority >= 0 && newPriority < 4) {
      _priority = newPriority;
      return true;
    }
    return false;
  }

  bool changeStatus(int newStatus) {
    if (newStatus >= 0 && newStatus < 3) {
      _status = newStatus;
      return true;
    } 
    return false;
  }

  // ReplyChannel createReplyChannel() {
    
  // }
}