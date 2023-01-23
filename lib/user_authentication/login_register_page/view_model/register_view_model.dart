import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:senior_project/core/datasource/firebase_services.dart';
import 'package:senior_project/user_authentication/login_register_page/model/register_model.dart';

class RegisterViewModel extends ChangeNotifier {
  RegisterModel registerModel = RegisterModel();
  late bool visibilityText = true;

  void changeVisibilityTextState() {
    visibilityText = !visibilityText;
    notifyListeners();
  }

  void getUserInput(int inputType, String input) {
    if (inputType == 0) {
      registerModel.setUsername = input;
    } else if (inputType == 1) {
      registerModel.setEmail = input;
    } else if (inputType == 2) {
      registerModel.setPassword = input;
    } else {
      registerModel.setGender = int.parse(input);
    }
  }

  Future<Map<String, dynamic>> createUser(
    String username, 
    String email, 
    String password
  ) async {
    try {
      final creadential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email, 
        password: password
      );
      FirebaseServices("user").addDocument({
        "id": creadential.user!.uid,
        "email": creadential.user!.email as String,
        "username": username,
      });
      return {"success": true};
    } on FirebaseAuthException catch (e) {
      return {"success": false, "comment": e.code};
    } catch (e) {
      return {"success": false, "comment": e.toString()};
    }
  }
}