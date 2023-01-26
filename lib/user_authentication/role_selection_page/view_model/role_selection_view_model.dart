import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:senior_project/core/datasource/firebase_services.dart';
import 'package:senior_project/user_authentication/role_selection_page/model/role_selection_model.dart';

class RoleSelectionViewModel extends ChangeNotifier{
  RoleSelectionModel model = RoleSelectionModel();

  bool get getTextBreakpoint => model.getIsTextbreakpoint as bool;
  bool get getStudentCardSelected => model.getIsStudentCardSelected;

  void calculateTextBreakpoint(double pixelWidth) {
    model.calculateTextBreakpoint(pixelWidth);
  }

  void changeCardSelectedState(bool isSelected) {
    model.changeStudentCardSelectedState();
    notifyListeners();
  }

  Future<bool> confirmButtonLogic() async {
    try {
      FirebaseServices service = FirebaseServices("user");
      String uid = FirebaseAuth.instance.currentUser!.uid;
      await service.editDocument(uid, {"role": getStudentCardSelected ? 1 : 2});
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