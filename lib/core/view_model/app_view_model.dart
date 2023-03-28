// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senior_project/core/datasource/firebase_services.dart';
import 'package:senior_project/core/model/app.dart';
import 'package:senior_project/core/model/user/app_user.dart';
import 'package:senior_project/core/view_model/cryptor.dart';

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

  AppViewModel() {
    getSettingDetail();
  }

  bool getMobileSiteState(double pixelWidth) {
    if (pixelWidth <= _mobileWidthBreakpoint) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> updateSwitchValue(bool value) async {
    Map<String, dynamic> detail = {"emailEnabled": value};
    String userId = app.getUser.getId;
    final service = FirebaseServices("user");
    final snapshot = await service.getAllSubDocument(userId, "setting");
    if (snapshot?.size == 0) {
      service.addSubDocument(userId, "setting", detail);
    } else {
      final subDocId = snapshot?.docs[0].id;
      if (subDocId == null) return;
      service.editSubDocument(userId, "setting", subDocId, detail);
    }

    _isEmailEnable = value;
    notifyListeners();
  }

  Future<void> setTime(TimeOfDay start, TimeOfDay end) async {
    Map<String, dynamic> detail = {
      "startTime": start.toString(),
      "endTime": end.toString()
    };
    String userId = app.getUser.getId;
    final service = FirebaseServices("user");
    final snapshot = await service.getAllSubDocument(userId, "setting");
    if (snapshot?.size == 0) {
      service.addSubDocument(userId, "setting", detail);
    } else {
      final subDocId = snapshot?.docs[0].id;
      if (subDocId == null) return;
      service.editSubDocument(userId, "setting", subDocId, detail);
    }

    _startTime = start;
    _endTime = end;
    notifyListeners();
  }

  void getSettingDetail() async {
    String userId = app.getUser.getId;
    final service = FirebaseServices("user");
    final snapshot = await service.getAllSubDocument(userId, "setting");
    if (snapshot?.size == 0) {
      Map<String, dynamic> detail = {
        "emailEnabled": false,
        "startTime": const TimeOfDay(hour: 8, minute: 30).toString(),
        "endTime": const TimeOfDay(hour: 17, minute: 30).toString()
      };
      service.addSubDocument(userId, "setting", detail);
      return;
    } else {
      try {
        final data = snapshot?.docs[0];
        _isEmailEnable = data?['emailEnabled'];
        _startTime = data?['startTime'];
        _endTime = data?['endTime'];
        notifyListeners();
      } catch (e) {
        print(e);
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
    List<String> list = [
      "id",
      "username",
      "email",
      "role",
      "gender",
      "secret",
      "birthday",
      "linkId"
    ];
    Map<String, dynamic> result = {};
    String data = snapshot.data().toString();
    data = data.substring(1, data.length - 1);
    List<String> chunk = data.split(", ");
    for (int i = 0; i < chunk.length; i++) {
      List<String> chunkData = chunk[i].split(": ");
      if (!list.contains(chunkData[0])) {
        result[chunkData[0]] = Cryptor.decrypt(chunkData[1]);
      } else {
        result[chunkData[0]] = chunkData[1];
      }
    }
    return result;
  }

  Future<void> initializeLoginState(BuildContext context, bool state) async {
    if (state) {
      // final snapshot = await FirebaseServices("user").getDocumentById(
      //   FirebaseAuth.instance.currentUser!.uid
      // );
      // if (snapshot != null) {
      //   Map<String, dynamic> detail = storeAppUser(snapshot);
      //   setLoggedInUser(detail);
      // }
      // TODO manage role
      final credential = FirebaseAuth.instance.currentUser;
      setLoggedInUser({
        "id": credential!.uid,
        "email": credential.email,
        "name": credential.displayName,
        "phone": credential.phoneNumber,
        "profileImageUrl": credential.photoURL,
      });
    }
    _isLogin = state;
  }

  Future<bool> login(BuildContext context) async {
    final provider = OAuthProvider("microsoft.com");
    provider.setCustomParameters(
        {"tenant": "6f4432dc-20d2-441d-b1db-ac3380ba633d"});
    provider.addScope("email");
    provider.addScope("User.read");
    try {
      final credential = await FirebaseAuth.instance.signInWithPopup(provider);
      setLoggedInUser({
        "id": credential.user!.uid,
        "email": credential.user!.email,
        "name": credential.user!.displayName,
        "phone": credential.user!.phoneNumber,
        "profileImageUrl": credential.user!.photoURL
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
