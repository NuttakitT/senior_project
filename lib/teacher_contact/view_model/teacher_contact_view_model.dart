import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../../core/datasource/firebase_services.dart';
import '../model/teacher_contact_model.dart';

class TeacherContactViewModel extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();
  final firebaseService = FirebaseServices("teacherContact");
  List<Map<String, dynamic>?>? _teacherList;
  List<Map<String, dynamic>?>? get teacherList => _teacherList;

  // MARK: - Add Contact
  Future<void> createNewContact(AddTeacherContactRequest request) async {
    final docId = getUuid();
    TeacherContactModel model = TeacherContactModel(
      id: docId,
      imageUrl: request.imageUrl,
      name: "${request.firstName} ${request.lastName}",
      thaiName: "${request.thaiName} ${request.thaiLastName}",
      email: request.email,
      phone: request.phone,
      officeHours: request.officeHours,
      facebookLink: request.facebookLink,
      subjectId: request.subjectId,
    );

    Map<String, dynamic> teacherContactDetail = {
      "id": docId,
      "imageUrl": model.imageUrl,
      "name": model.name,
      "thaiName": model.thaiName,
      "email": model.email,
      "phone": model.phone,
      "officeHours": model.officeHours,
      "facebookLink": model.facebookLink,
      "subjectId": model.subjectId
    };
    await firebaseService.setDocument(docId, teacherContactDetail);
  }

  String getUuid() {
    return const Uuid().v1();
  }

  // MARK: - Teacher Contact

  Future<List<Map<String, dynamic>?>?> _getAllTeacherContacts() async {
    final snapshot = await firebaseService.getAllDocument();

    if (snapshot?.size == 0) {
      return null;
    }

    List<Map<String, dynamic>> teacherContacts = [];

    for (QueryDocumentSnapshot doc in snapshot!.docs) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      teacherContacts.add(data);
    }

    _teacherList = teacherContacts;
    return _teacherList;
  }

  Future<List<Map<String, dynamic>?>?> getTeacherContacts() async {
    return await _getAllTeacherContacts();
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

  Future<void> _uploadImageAndTurnToUrl(File file) async {}
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
