// ignore_for_file: use_build_context_synchronously

import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:senior_project/core/datasource/firebase_services.dart';
import 'package:senior_project/core/model/user/app_user.dart';
import 'package:senior_project/core/view_model/app_view_model.dart';

class RoleSelectionViewModel extends ChangeNotifier{
  bool _isStudentCardSelected = true;

  bool get getStudentCardSelected => _isStudentCardSelected;

  void changeCardSelectedState(bool isSelected) {
    _isStudentCardSelected = !_isStudentCardSelected;
    notifyListeners();
  }

  Future<bool> confirmButtonLogic(BuildContext context) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      FirebaseServices service = FirebaseServices("user");
      String uid = user!.uid;
      await service.editDocument(uid, {"role": getStudentCardSelected ? 1 : 2});
      context.read<AppViewModel>().app.getUser.setRole = getStudentCardSelected ? 1 : 2;
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> backButtonLogic(BuildContext context) async {
    try {
      FirebaseServices service = FirebaseServices("user");
      String uid = FirebaseAuth.instance.currentUser!.uid;
      await service.deleteDocument(uid);
      await FirebaseAuth.instance.currentUser!.delete();
      context.read<AppViewModel>().app.setAppUser = AppUser();
      return true;
    } catch (e) {
      return false;
    }
  }
}