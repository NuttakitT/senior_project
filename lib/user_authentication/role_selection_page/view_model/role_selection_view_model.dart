import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:senior_project/core/datasource/firebase_services.dart';

class RoleSelectionViewModel extends ChangeNotifier{
  final double _textBreakpoint = 620;
  late bool _isTextBreakpoint;
  bool _isStudentCardSelected = true;

  bool get getTextBreakpoint => _isTextBreakpoint;
  bool get getStudentCardSelected => _isStudentCardSelected;

  void calculateTextBreakpoint(double pixelWidth) {
    if (pixelWidth <= _textBreakpoint) {
      _isTextBreakpoint = true;
    } else {
      _isTextBreakpoint = false;
    }
  }

  void changeCardSelectedState(bool isSelected) {
    _isStudentCardSelected = isSelected;
    notifyListeners();
  }

  Future<bool> confirmButtonLogic() async {
    try {
      FirebaseServices service = FirebaseServices("user");
      String uid = FirebaseAuth.instance.currentUser!.uid;
      await service.editDocument(uid, {"role": _isStudentCardSelected ? 1 : 2});
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> backButtonLogic() async {
    try {
      FirebaseServices service = FirebaseServices("user");
      String uid = FirebaseAuth.instance.currentUser!.uid;
      await service.deleteDocument(uid);
      await FirebaseAuth.instance.currentUser!.delete();
      return true;
    } catch (e) {
      return false;
    }
  }
}