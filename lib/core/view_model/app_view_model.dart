// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:senior_project/core/datasource/firebase_services.dart';
import 'package:senior_project/core/model/app.dart';
import 'package:senior_project/core/model/user/app_user.dart';

class AppViewModel extends ChangeNotifier {
  App app = App();
  final double _mobileWidthBreakpoint = 430;
  late bool _isLogin;
  bool _isEmailEnable = false;
  TimeOfDay _startTime = const TimeOfDay(hour: 8, minute: 0);
  TimeOfDay _endTime = const TimeOfDay(hour: 17, minute: 0);

  bool get isEmailEnable => _isEmailEnable;
  TimeOfDay get startTime => _startTime;
  TimeOfDay get endTime => _endTime;

  bool getMobileSiteState(double pixelWidth) {
    if (pixelWidth <= _mobileWidthBreakpoint) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> updateSwitchValue(bool value) async {
    Map<String, dynamic> detail = {Consts.emailEnabled: value};
    String userId = app.getUser.getId;
    final service = FirebaseServices("user");
    final snapshot = await service.getAllSubDocument(userId, Consts.setting);
    if (snapshot?.size == 0) {
      service.addSubDocument(userId, Consts.setting, detail);
    } else {
      final subDocId = snapshot?.docs[0].id;
      if (subDocId == null) return;
      service.editSubDocument(userId, Consts.setting, subDocId, detail);
    }

    _isEmailEnable = value;
    notifyListeners();
  }

  Future<void> setTime(TimeOfDay start, TimeOfDay end) async {
    final startDate = DateTime(0, 0, 0, start.hour, start.minute);
    final startTimeStamp = Timestamp.fromDate(startDate);
    final endDate = DateTime(0, 0, 0, end.hour, end.minute);
    final endTimeStamp = Timestamp.fromDate(endDate);
    Map<String, dynamic> detail = {
      Consts.startTime: startTimeStamp,
      Consts.endTime: endTimeStamp
    };
    String userId = app.getUser.getId;
    final service = FirebaseServices("user");
    final snapshot = await service.getAllSubDocument(userId, Consts.setting);
    if (snapshot?.size == 0) {
      service.addSubDocument(userId, Consts.setting, detail);
    } else {
      final subDocId = snapshot?.docs[0].id;
      if (subDocId == null) return;
      service.editSubDocument(userId, Consts.setting, subDocId, detail);
    }

    _startTime = start;
    _endTime = end;
    notifyListeners();
  }

  void getSettingDetail() async {
    String userId = app.getUser.getId;
    final service = FirebaseServices("user");
    final snapshot = await service.getAllSubDocument(userId, Consts.setting);
    if (snapshot?.size == 0) {
      Map<String, dynamic> detail = {
        Consts.emailEnabled: false,
        Consts.startTime: const TimeOfDay(hour: 8, minute: 0),
        Consts.endTime: const TimeOfDay(hour: 17, minute: 0)
      };
      service.addSubDocument(userId, Consts.setting, detail);
      return;
    } else {
      try {
        final data = snapshot?.docs[0];
        _isEmailEnable = data?[Consts.emailEnabled];

        final start = data?[Consts.startTime] as Timestamp;
        final startDateTime = start.toDate();
        final startTimeOfDay = TimeOfDay.fromDateTime(startDateTime);
        _startTime = startTimeOfDay;

        final end = data?[Consts.endTime] as Timestamp;
        final endDateTime = end.toDate();
        final endTimeOfDay = TimeOfDay.fromDateTime(endDateTime);
        _endTime = endTimeOfDay;

        notifyListeners();
      } catch (e) {
        if (kDebugMode) {
          print(e);
        }
      }
    }
  }

  void setLoggedInUser(Map<String, dynamic> detail) {
    AppUser user = AppUser.overloaddedConstructor(detail);
    app.setAppUser = user;
    _isLogin = true;
    notifyListeners();
  }

  Map<String, dynamic> storeAppUser(DocumentSnapshot snapshot) {
    return {
      "id": snapshot.get("id"),
      "name": snapshot.get("name"),
      "email": snapshot.get("email"),
      "phone": snapshot.get("phone"),
      "role": snapshot.get("role"),
      "profileImageUrl": snapshot.get("profileImageUrl"),
      "responsibility": snapshot.get("responsibility"),
    };
  }

  Future<void> initializeLoginState(BuildContext context, bool state) async {
    _isLogin = state;
    if (state) {
      final snapshot = await FirebaseServices("user").getDocumentById(
        FirebaseAuth.instance.currentUser!.uid
      );
      if (snapshot!.exists) {
        Map<String, dynamic> detail = storeAppUser(snapshot);
        setLoggedInUser(detail);
      }
    } 
  }

  Future<bool> login(BuildContext context) async {
    final provider = OAuthProvider("microsoft.com");
    provider.setCustomParameters(
        {"tenant": "6f4432dc-20d2-441d-b1db-ac3380ba633d"});
    provider.addScope("email");
    provider.addScope("User.read");
    try {
      final credential = await FirebaseAuth.instance.signInWithPopup(provider);
      dynamic snapshot = await FirebaseServices("user").getDocumentById(
        credential.user!.uid
      );
      if (!snapshot!.exists) {
        await FirebaseServices("user").setDocument(credential.user!.uid, {
          "id": credential.user!.uid,
          "email": credential.user!.email,
          "name": credential.user!.displayName,
          "phone": credential.user!.phoneNumber,
          "profileImageUrl": credential.user!.photoURL,
          "role": 1,
          "responsibility": []
        });
        snapshot = await FirebaseServices("user").getDocumentById(
          credential.user!.uid
        );
      }
      setLoggedInUser({
        "id": credential.user!.uid,
        "email": credential.user!.email,
        "name": credential.user!.displayName,
        "phone": credential.user!.phoneNumber,
        "profileImageUrl": credential.user!.photoURL,
        "role": snapshot.get("role"),
        "responsibility": snapshot.get("responsibility")
      });
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<void> logout() async {
    app.setAppUser = AppUser();
    _isLogin = false;
    await FirebaseAuth.instance.signOut();
    notifyListeners();
  }

  bool get isLogin => _isLogin;
}

class Consts {
  static String setting = "setting";
  static String emailEnabled = "emailEnabled";
  static String startTime = "startTime";
  static String endTime = "endTime";
}
