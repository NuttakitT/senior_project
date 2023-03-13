import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:senior_project/core/datasource/firebase_services.dart';
import 'package:senior_project/my_profile/model/user_profile_model.dart';

class UserProfileViewModel extends ChangeNotifier {
  final firebaseServiceForUser = FirebaseServices("user");
  final _currentUserId = FirebaseAuth.instance.currentUser?.uid;

  UserModel? _user;
  UserModel? get user => _user;
  String? get currentUserId => _currentUserId;

  Future<UserModel?> getUserProfile(String uid) async {
    final snapshot = await firebaseServiceForUser.getDocumentById(uid);

    if (snapshot != null) {
      final data = snapshot.data() as Map<String, dynamic>;
      return UserModel(
          id: uid,
          imageUrl: data[Consts.imageUrl],
          name: data[Consts.name],
          aboutMe: data[Consts.aboutMe],
          email: data[Consts.email],
          phone: data[Consts.phone],
          officeHours: data[Consts.officeHours],
          role: data[Consts.role]);
    }
    return null;
  }

  Future<void> _getUser(String uid) async {
    _user = await getUserProfile(uid);
    notifyListeners();
  }

  Future<void> updateProfile(String uid, Map<String, dynamic> data) async {
    try {
      await firebaseServiceForUser.editDocument(uid, data);
      print('Update success');
    } catch (e) {
      print(e);
    }
  }

  void getUserUid() {
    final uid = currentUserId;
    if (uid == null) {
      return;
    }
    _getUser(uid);
    notifyListeners();
  }
}

class Consts {
  static String imageUrl = 'imageUrl';
  static String name = 'name';
  static String surname = 'surname';
  static String aboutMe = 'aboutMe';
  static String email = 'email';
  static String phone = 'phone';
  static String officeHours = 'officeHours';
  static String role = 'role';
}
