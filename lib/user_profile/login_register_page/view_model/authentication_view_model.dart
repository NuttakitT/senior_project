// ignore_for_file: use_build_context_synchronously

import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senior_project/core/datasource/firebase_services.dart';
import 'package:senior_project/core/view_model/app_view_model.dart';
import 'package:senior_project/core/view_model/cryptor.dart';
import 'package:senior_project/user_profile/login_register_page/model/register_model.dart';

class AuthenticationViewModel extends ChangeNotifier {
  RegisterModel registerModel = RegisterModel();
  String _errorText = "";
  bool _isEmptyEmail = false;
  bool _isEmptyPassword = false;
  bool _isEmptyUsername = false;
  bool _visibilityText = true;
  bool _isShowLoginPage = true;

  bool get getVisibilityState => _visibilityText;
  bool get getIsShowLoginPage => _isShowLoginPage;
  bool get getIsEmptyEmail => _isEmptyEmail;
  bool get getIsEmptyPassword => _isEmptyPassword;
  bool get getIsEmptyUsername => _isEmptyUsername;
  String get getErrorText => _errorText;
  
  void clearErrorText() {
    _errorText = "";
    notifyListeners();
  }

  void clearIsEmptyEmail() {
    _isEmptyEmail = false;
    notifyListeners();
  }

  void clearIsEmptyPassword() {
    _isEmptyPassword = false;
    notifyListeners();
  }

  void clearIsEmptyUsername() {
    _isEmptyUsername = false;
    notifyListeners();
  }

  void changeVisibilityState() {
    _visibilityText = !_visibilityText;
    notifyListeners();
  }

  void changeShowPageState() {
    _isShowLoginPage = !_isShowLoginPage;
    notifyListeners();
  }

  void clearModel() {
    registerModel = RegisterModel();
    notifyListeners();
  }

  void getUserInput(int inputType, String input) {
    // if (inputType == 0) {
    //   registerModel.setUsername = input;
    // } else if (inputType == 1) {
    //   final bool emailValid = 
    //     RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
    //     .hasMatch(input);
    //   if (emailValid) {
    //     registerModel.setEmail = input;
    //   } else {
    //     registerModel.setEmail = "";
    //   }
    // } else if (inputType == 2) {
    //   registerModel.setPassword = input;
    // } 
  }

  bool checkkUserInput(bool isRegister) {
    // if(registerModel.getPassword!.isEmpty && 
    // registerModel.getEmail.isEmpty && 
    // ((isRegister && registerModel.getUsername.isEmpty) || !isRegister)) {
    //   _isEmptyPassword = true;
    //   _isEmptyEmail = true;
    //   _isEmptyUsername = true;
    //   notifyListeners();
    //   return false;
    // }
    // if(registerModel.getPassword!.isEmpty) {
    //   _isEmptyPassword = true;
    //   notifyListeners();
    //   return false;
    // } 
    // if(registerModel.getEmail.isEmpty) {
    //   _isEmptyEmail = true;
    //   notifyListeners();
    //   return false;
    // } 
    // if(isRegister && registerModel.getUsername.isEmpty) {
    //   _isEmptyUsername = true;
    //   notifyListeners();
    //   return false;
    // }
    // _errorText = "";
    // notifyListeners();
    return true;
  }

  Map<String, dynamic> storeAppUser(DocumentSnapshot snapshot) {
    List<String> list = ["id", "username", "email", "role", "gender", "secret", "birthday", "linkId"];
    Map<String, dynamic> result = {};
    String data = snapshot.data().toString();
    data = data.substring(1, data.length-1);
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

  Future<bool> loginUser(BuildContext context) async {
    try {
      final secret = await FirebaseServices("user").getDocumnetByKeyValuePair(["email"], [registerModel.getEmail]);
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: registerModel.getEmail, 
        password: Cryptor.encrypt(registerModel.getPassword as String, customSeed: secret!.docs.first.get("secret"))[0]
      );
      if (!credential.user!.emailVerified) {
        _errorText = "Please verify your email to login.";
        notifyListeners();
        return false;
      }
      final snapshot = await FirebaseServices("user").getDocumentById(credential.user!.uid);
      Map<String, dynamic> detail = storeAppUser(snapshot!);
      context.read<AppViewModel>().setLoggedInUser(detail);
      _errorText = "";
      notifyListeners();
      return true;
    } on FirebaseAuthException catch (e) {
      _errorText = "An error occurred, ${e.code.replaceAll("-", " ")}";
      notifyListeners();
      return false;
    } catch (e) {
      _errorText = "An error occurred, $e";
      notifyListeners();
      return false;
    }
  }

  Future<void> createUser(BuildContext context) async {
    // try {
    //   final int seed = Random().nextInt(100);
    //   final doc = await FirebaseServices("user").getDocumnetByKeyValuePair(["username"], [registerModel.getUsername]);
    //   if (doc != null && doc.size != 0) {
    //     _errorText = "Username already in user.";
    //     notifyListeners();
    //     return false;
    //   }
    //   final creadential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
    //     email: registerModel.getEmail, 
    //     password: Cryptor.encrypt(registerModel.getPassword as String, customSeed: seed)[0]
    //   );
    //   Map<String, dynamic> detail = {
    //     "id": creadential.user!.uid,
    //     "email": creadential.user!.email as String,
    //     "username": registerModel.getUsername,
    //     "secret": seed
    //   };
    //   FirebaseServices("user").setDocument(
    //     creadential.user!.uid,
    //     detail
    //   );
    //   FirebaseAuth.instance.currentUser?.sendEmailVerification();
    //   _errorText = "";
    //   notifyListeners();
    //   return true;
    // } on FirebaseAuthException catch (e) {
    //   _errorText = "An error occurred, ${e.code.replaceAll("-", " ")}";
    //   notifyListeners();
    //   return false;
    // } catch (e) {
    //   _errorText = "An error occurred, $e";
    //   notifyListeners();
    //   return false;
    // }
  }
  
  Future<bool> googleSignIn(BuildContext context) async {
    try {
      final int seed = Random().nextInt(100);
      GoogleAuthProvider provider = GoogleAuthProvider();
      provider.addScope("https://www.googleapis.com/auth/contacts.readonly");
      final credential = await FirebaseAuth.instance.signInWithPopup(provider);
      final snapshot = await FirebaseServices("user").getDocumentById(credential.user!.uid);
      Map<String, dynamic> detail = {
        "id": credential.user!.uid,
        "email": credential.user!.email as String,
      };
      if (!snapshot!.exists) {
        FirebaseServices("user").setDocument(
          credential.user!.uid,
          {
            "id": credential.user!.uid,
            "email": credential.user!.email as String,
            "username": Cryptor.encrypt(credential.user!.displayName as String, customSeed: seed)[0],
            "secret": seed
          }
        );
      }
      context.read<AppViewModel>().setLoggedInUser(detail);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> facebookSignIn(BuildContext context) async {
    try {
      final int seed = Random().nextInt(100);
      FacebookAuthProvider  provider = FacebookAuthProvider ();
      provider.addScope("email");
      final credential = await FirebaseAuth.instance.signInWithPopup(provider);
      Map<String, dynamic> detail = {
        "id": credential.user!.uid,
        "email": credential.user!.email as String,
      };
      final snapshot = await FirebaseServices("user").getDocumentById(credential.user!.uid);
      if (!snapshot!.exists) {
        FirebaseServices("user").setDocument(
          credential.user!.uid,
          {
            "id": credential.user!.uid,
            "email": credential.user!.email as String,
            "username": Cryptor.encrypt(credential.user!.displayName as String, customSeed: seed)[0],
            "secret": seed
          }
        );
      }
      context.read<AppViewModel>().setLoggedInUser(detail);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> login(BuildContext context) async {
    final provider = OAuthProvider("microsoft.com");
    provider.setCustomParameters({
      "tenant": "6f4432dc-20d2-441d-b1db-ac3380ba633d"
    });
    provider.addScope("email");
    provider.addScope("User.read");
    try {
      final credential = await FirebaseAuth.instance.signInWithPopup(provider);
      context.read<AppViewModel>().setLoggedInUser({
        "id": credential.user!.uid,
        "email": credential.user!.email,
        "name": credential.user!.displayName,
        "phone": credential.user?.phoneNumber,
        "profileImageUrl": credential.user?.photoURL
      });
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<void> resetPassword(String email) async {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  }
}