import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:senior_project/core/datasource/firebase_services.dart';

import '../model/user_profile_model.dart';

class UserProfileViewModel extends ChangeNotifier {
  final firebaseServiceForUser = FirebaseServices("user");
  bool _isEditing = false;
  UserModel? _user;
  UserModel? get user => _user;

  bool get isEditing => _isEditing;

  void toggleEditButton() {
    _isEditing = !_isEditing;
    notifyListeners();
  }

  Future<UserModel?> getUserProfile(String uid) async {
    final snapshot = await firebaseServiceForUser.getDocumentById(uid);

    if (snapshot != null) {
      final data = snapshot.data() as Map<String, dynamic>;
      return UserModel(
          uid: uid,
          imageUrl: data[Consts.imageUrl],
          name: data[Consts.name],
          surname: data[Consts.surname],
          aboutMe: data[Consts.aboutMe],
          email: data[Consts.email],
          phone: data[Consts.phone],
          officeHours: data[Consts.officeHours],
          role: data[Consts.role]);
    }
    return null;
  }

  Future<void> getUser(String uid) async {
    _user = await getUserProfile(uid);
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
