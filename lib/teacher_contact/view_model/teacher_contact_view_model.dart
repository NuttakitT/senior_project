import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
import '../../core/datasource/firebase_services.dart';
import '../model/teacher_contact_model.dart';
import 'package:path/path.dart' as Path;

class TeacherContactViewModel extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();
  final firebaseService = FirebaseServices("teacherContact");
  final firebaseServiceSuject = FirebaseServices("subject");
  List<Map<String, dynamic>?>? _teacherList;
  List<Map<String, dynamic>?>? get teacherList => _teacherList;
  List<Map<String, dynamic>?>? _subjects;
  List<Map<String, dynamic>?>? get subjects => _subjects;

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

  bool validateNameField(String input) {
    if (input.isEmpty) {
      return false;
    }
    if (input.contains(RegExp('^[a-zA-Z]+'))) {
      return true;
    }
    return false;
  }

  bool validateEmailField(String input) {
    final bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(input);
    return emailValid;
  }

  bool validatePhoneNumber(String input) {
    if (input.isEmpty) {
      return false;
    }
    return int.tryParse(input) != null;
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

  Future<List<Map<String, dynamic>?>?> _getAllSujects() async {
    final snapshot = await firebaseServiceSuject.getAllDocument();

    if (snapshot?.size == 0) {
      return null;
    }

    List<Map<String, dynamic>> subjects = [];

    for (QueryDocumentSnapshot doc in snapshot!.docs) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      subjects.add(data);
    }

    _subjects = subjects;
    return _subjects;
  }

  Future<List<Map<String, dynamic>?>?> getTeacherContacts() async {
    return await _getAllTeacherContacts();
  }

  Future<List<Map<String, dynamic>?>?> getSubjects() async {
    return await _getAllSujects();
  }

  List<String> getSubjectStrings(List<dynamic> list) {
    return list.map((subject) => "${subject.id} ${subject.name}").toList();
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

  Future<String?> getImageUrl(XFile? file) async {
    String? imageUrl;
    if (file != null) {
      final imageFile = File(file.path);
      String fileName = Path.basename(imageFile.path);
      FirebaseStorage storage = FirebaseStorage.instance;
      Reference ref = storage.ref().child("Image-$fileName");

      UploadTask task = ref.putFile(imageFile);
      await task.whenComplete(() async {
        var url = await ref.getDownloadURL();
        imageUrl = url.toString();
      }).catchError((e) {
        print(e);
      });
      return imageUrl;
    }
    return null;
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
