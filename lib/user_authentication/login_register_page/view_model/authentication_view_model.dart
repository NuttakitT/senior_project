import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:senior_project/core/datasource/firebase_services.dart';
import 'package:senior_project/user_authentication/login_register_page/model/register_model.dart';

class AuthenticationViewModel extends ChangeNotifier {
  RegisterModel registerModel = RegisterModel();
  late bool visibilityText = true;
  bool _isShowLoinPage = true;

  bool get getPageState => _isShowLoinPage;

  void changeViewState() {
    _isShowLoinPage = !_isShowLoinPage;
    notifyListeners();
  }

  void changeVisibilityTextState() {
    visibilityText = !visibilityText;
    notifyListeners();
  }

  void getUserInput(int inputType, String input) {
    if (inputType == 0) {
      registerModel.setUsername = input;
    } else if (inputType == 1) {
      final bool emailValid = 
        RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(input);
      if (emailValid) {
        registerModel.setEmail = input;
      }
    } else if (inputType == 2) {
      registerModel.setPassword = input;
    } 
  }

  bool checkkUserInput(bool isRegister) {
    if(registerModel.getPassword == null) {
      return false;
    } 
    if(registerModel.getEmail == null) {
      return false;
    } 
    if(isRegister && registerModel.getUsername == null) {
      return false;
    }
    return true;
  }

  bool checkIsUserLogin() {
    if (FirebaseAuth.instance.currentUser != null) {
      return true;
    }  
    return false;
  }

  Future<Map<String, dynamic>> loginUser() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: registerModel.getEmail as String, 
        password: registerModel.getPassword as String
      );
      return {"success": true};
    } on FirebaseAuthException catch (e) {
      return {"success": false, "comment": e.code};
    } catch (e) {
      return {"success": false, "comment": e.toString()};
    }
  }

  Future<Map<String, dynamic>> createUser() async {
    try {
      final creadential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: registerModel.getEmail as String, 
        password: registerModel.getPassword as String
      );
      FirebaseServices("user").setDocument(
        creadential.user!.uid,
        {
          "id": creadential.user!.uid,
          "email": creadential.user!.email as String,
          "username": registerModel.getUsername as String,
        }
      );
      return {"success": true};
    } on FirebaseAuthException catch (e) {
      return {"success": false, "comment": e.code};
    } catch (e) {
      return {"success": false, "comment": e.toString()};
    }
  }
  
  Future<bool> googleSignIn() async {
    try {
      GoogleAuthProvider provider = GoogleAuthProvider();
      provider.addScope("https://www.googleapis.com/auth/contacts.readonly");
      final creadential = await FirebaseAuth.instance.signInWithPopup(provider);
      FirebaseServices("user").setDocument(
        creadential.user!.uid,
        {
          "id": creadential.user!.uid,
          "email": creadential.user!.email as String,
        }
      );
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> facebookSignIn() async {
    try {
      FacebookAuthProvider  provider = FacebookAuthProvider ();
      provider.addScope("email");
      final creadential = await FirebaseAuth.instance.signInWithPopup(provider);
      FirebaseServices("user").setDocument(
        creadential.user!.uid,
        {
          "id": creadential.user!.uid,
          "email": creadential.user!.email as String,
        }
      );
      return true;
    } catch (e) {
      return false;
    }
  }
}