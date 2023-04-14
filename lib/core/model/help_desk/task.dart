import 'package:senior_project/core/model/content.dart';
import 'package:uuid/uuid.dart';

class Task {
  late String _id;
  late String _ownerId;
  late DateTime _dateCreate;
  DateTime? _dateComplete;
  late String _category;
  late int _priority;
  late int _status;
  late String _title;
  late Content _content;
  late List<dynamic>  _isSeen;
  late List<dynamic> _admin;

  Task(
    String ownerId,
    String title,
    Content content,
    int priority,
    String category,
    List<dynamic> seen,
    List<dynamic> admin,
    {String? id, DateTime? dateCreate, int? status, DateTime? dateComplete}
  ) {
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
    if (dateComplete != null) {
      _dateComplete = dateComplete;
    }
    if (status != null) {
      _status = status;
    } else {
      _status = 0;
    } 
    _ownerId = ownerId;
    _title = title;
    _content = content;
    _priority = priority;
    _category = category;
    _isSeen = seen;
    _admin = admin;
  }

  set setDateComplete(DateTime date) => _dateComplete = date;

  String get getId => _id;
  String get getOwnerId => _ownerId;
  DateTime get getDateCreate => _dateCreate;
  DateTime? get getDateComplete => _dateComplete;
  String get getCategory => _category;
  int get getStatus => _status;
  int get getPriority => _priority;
  String get getTitle => _title;
  Content get getContent => _content;
  List<dynamic>  get getSeen => _isSeen;
  List<dynamic> get getAdmin => _admin;

  bool changePriority(int newPriority) {
    if (newPriority >= 0 && newPriority < 4) {
      _priority = newPriority;
      return true;
    }
    return false;
  }

  bool changeStatus(int newStatus, {DateTime? dateComplete}) {
    if (newStatus >= 0) {
      if (newStatus >= 2 && dateComplete != null) {
        _dateComplete = dateComplete;
      } else {
        dateComplete = null;
      }
      _status = newStatus;
      return true;
    } 
    return false;
  }

  void changeIsSeen(List<dynamic> id) {
    _isSeen = [];
    _isSeen.addAll(id);
  }
}