// ignore_for_file: depend_on_referenced_packages, library_prefixes
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../../core/datasource/firebase_services.dart';
import '../model/teacher_contact_model.dart';

class TeacherContactViewModel extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();
  final firebaseService = FirebaseServices("teacherContact");
  final firebaseServiceSuject = FirebaseServices("subject");
  List<Map<String, dynamic>?>? _teacherList;
  List<Map<String, dynamic>?>? get teacherList => _teacherList;
  // List<Map<String, dynamic>?>? _subjects;
  // List<Map<String, dynamic>?>? get subjects => _subjects;

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
    notifyListeners();
  }

  Future<bool> editContact(String id, AddTeacherContactRequest request) async {
    String name = "${request.firstName} ${request.lastName}";
    String thaiName = "${request.thaiName} ${request.thaiLastName}";
    Map<String, dynamic> teacherContactDetail = {
      "imageUrl": request.imageUrl,
      "name": name,
      "thaiName": thaiName,
      "email": request.email,
      "phone": request.phone,
      "officeHours": request.officeHours,
      "facebookLink": request.facebookLink,
      "subjectId": request.subjectId
    };
    final bool isSuccess =
        await firebaseService.editDocument(id, teacherContactDetail);
    notifyListeners();
    return isSuccess;
  }

  Future<bool> deleteContact(String id) async {
    final isSuccess = await firebaseService.deleteDocument(id);
    notifyListeners();
    return isSuccess;
  }

  bool validateNameField(String input) {
    if (input.isEmpty) {
      return false;
    }
    if (input.contains(RegExp(r'^[\s\S]+$'))) {
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
    // if (input.isEmpty) {
    //   return false;
    // }
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

  Future<List<Subject>> _getAllSujects() async {
    final snapshot = await firebaseServiceSuject.getAllDocument();

    if (snapshot?.size == 0) {
      return [];
    }

    List<Subject> subjects = [];

    for (QueryDocumentSnapshot doc in snapshot!.docs) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      Subject subject = Subject.fromJson(data);
      subjects.add(subject);
    }

    return subjects;
  }

  Future<List<Map<String, dynamic>?>?> getTeacherContacts() async {
    return await _getAllTeacherContacts();
  }

  Future<List<Subject>> getSubjects() async {
    return await _getAllSujects();
  }

  List<String> getSubjectStrings(List<dynamic> list) {
    return list.map((subject) => "${subject.id} ${subject.name}").toList();
  }

  List<Subject> convertSubjectStringToObject(List<String> strList) {
    List<Subject> list = [];
    for (String str in strList) {
      List<String> subjectParts = str.split(" ");
      String subjectId = subjectParts[0];
      String name = subjectParts.sublist(1).join(" ");
      Subject subject = Subject(id: subjectId, name: name);
      list.add(subject);
    }
    return list;
  }

  Future<void> updateTeacherContactDetailById(
      String uid, Map<String, dynamic> data) async {
    try {
      await firebaseService.editDocument(uid, data);
      if (kDebugMode) {
        print('Update success');
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future<String?> getImageUrl(Uint8List? file, String fileName) async {
    String? imageUrl;
    if (file != null) {
      FirebaseStorage storage = FirebaseStorage.instance;
      Reference ref = storage.ref().child("Image-$fileName");

      UploadTask task = ref.putData(file);
      await task.whenComplete(() async {
        var url = await ref.getDownloadURL();
        imageUrl = url.toString();
      }).catchError((e) {
        if (kDebugMode) {
          print(e);
        }
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
