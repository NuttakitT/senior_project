import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../core/datasource/firebase_services.dart';
import '../model/teacher_contact_model.dart';

class TeacherContactViewModel extends ChangeNotifier {
  final firebaseService = FirebaseServices("teacherContact");
  bool _isEditing = false;
  List<TeacherContactModel>? _teacherList;
  List<TeacherContactModel>? get teacherList => _teacherList;

  bool get isEditing => _isEditing;

  void toggleEditButton() {
    _isEditing = !_isEditing;
    notifyListeners();
  }

  Future<List<TeacherContactModel>?> getAllTeacherContacts() async {
    final snapshot = await firebaseService.getAllDocument();

    if (snapshot == null) {
      return null;
    }

    List<TeacherContactModel> teacherContacts = [];

    for (QueryDocumentSnapshot doc in snapshot.docs) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      TeacherContactModel teacherContact = TeacherContactModel(
        uid: data['uid'],
        imageUrl: data['imageUrl'],
        gender: data['gender'],
        name: data['name'],
        thaiName: data['thaiName'],
        email: data['email'],
        phone: data['phone'],
        officeHours: data['officeHours'],
        facebookLink: data['facebookLink'],
        subjectId: List<String>.from(data['subjectId']),
      );
      teacherContacts.add(teacherContact);
    }

    _teacherList = teacherContacts;
    return _teacherList;
  }

  Future<void> getTeacherContacts() async {
    _teacherList = await getAllTeacherContacts();
    notifyListeners();
  }
}
