import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../core/datasource/firebase_services.dart';
import '../model/teacher_contact_model.dart';

class TeacherContactViewModel extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();
  final firebaseService = FirebaseServices("teacherContact");
  List<TeacherContactModel>? _teacherList;
  List<TeacherContactModel>? get teacherList => _teacherList;

  // MARK: - Add Contact
  Future<void> addContact() async {
    final currentState = formKey.currentState;
    if (currentState == null) {
      return;
    }
    if (currentState.validate() == false) {
      return;
    }
    formKey.currentState?.save();
  }

  // MARK: - Teacher Contact
  void toggleAddContactButton() {
    // handle add Contacxt pop-up
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
        id: data[Consts.id],
        imageUrl: data[Consts.imageUrl],
        gender: data[Consts.gender],
        name: data[Consts.name],
        thaiName: data[Consts.thaiName],
        email: data[Consts.email],
        phone: data[Consts.phone],
        officeHours: data[Consts.officeHours],
        facebookLink: data[Consts.facebookLink],
        subjectId: List<String>.from(data[Consts.subjectId]),
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

  Future<void> updateTeacherContactDetailById(
      String uid, Map<String, dynamic> data) async {
    try {
      await firebaseService.editDocument(uid, data);
      print('Update success');
    } catch (e) {
      print(e);
    }
  }
}

class Consts {
  static String id = 'id';
  static String imageUrl = 'imageUrl';
  static String gender = 'gender';
  static String name = 'name';
  static String thaiName = 'thaiName';
  static String email = 'email';
  static String phone = 'phone';
  static String officeHours = 'officeHours';
  static String facebookLink = 'facebookLink';
  static String subjectId = 'subjectId';
}
