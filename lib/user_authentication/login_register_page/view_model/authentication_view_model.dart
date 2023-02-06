// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senior_project/core/datasource/firebase_services.dart';
import 'package:senior_project/core/view_model/app_view_model.dart';
import 'package:senior_project/user_authentication/login_register_page/model/register_model.dart';

class AuthenticationViewModel extends ChangeNotifier {
  RegisterModel registerModel = RegisterModel();

  bool get getPageState => registerModel.getIsShowLoginPage;
  bool get getVisibilityState => registerModel.getVisibilityState;

  void changeViewState() {
    registerModel.changeShowPageState();
    notifyListeners();
  }

  void changeVisibilityTextState() {
    registerModel.changeVisibilityState();
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

  Map<String, dynamic> storeAppUser(DocumentSnapshot snapshot) {
    Map<String, dynamic> result = {};
    String data = snapshot.data().toString();
    data = data.substring(1, data.length-1);
    List<String> chunk = data.split(", ");
    for (int i = 0; i < chunk.length; i++) {
      List<String> chunkData = chunk[i].split(": ");
      result[chunkData[0]] = chunkData[1];
    }
    return result;
  }

  Future<Map<String, dynamic>> loginUser(BuildContext context) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: registerModel.getEmail as String, 
        password: registerModel.getPassword as String
      );
      final snapshot = await FirebaseServices("user").getDocumentById(credential.user!.uid);
      Map<String, dynamic> detail = storeAppUser(snapshot);
      context.read<AppViewModel>().setLoggedInUser(detail);
      return {"success": true};
    } on FirebaseAuthException catch (e) {
      return {"success": false, "comment": e.code};
    } catch (e) {
      return {"success": false, "comment": e.toString()};
    }
  }

  Future<Map<String, dynamic>> createUser(BuildContext context) async {
    try {
      final creadential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: registerModel.getEmail as String, 
        password: registerModel.getPassword as String
      );
      Map<String, dynamic> detail = {
        "id": creadential.user!.uid,
        "email": creadential.user!.email as String,
        "username": registerModel.getUsername as String,
      };
      FirebaseServices("user").setDocument(
        creadential.user!.uid,
        detail
      );
      context.read<AppViewModel>().setLoggedInUser(detail);
      return {"success": true};
    } on FirebaseAuthException catch (e) {
      return {"success": false, "comment": e.code};
    } catch (e) {
      return {"success": false, "comment": e.toString()};
    }
  }
  
  Future<bool> googleSignIn(BuildContext context) async {
    try {
      GoogleAuthProvider provider = GoogleAuthProvider();
      provider.addScope("https://www.googleapis.com/auth/contacts.readonly");
      final creadential = await FirebaseAuth.instance.signInWithPopup(provider);
      Map<String, dynamic> detail = {
        "id": creadential.user!.uid,
        "email": creadential.user!.email as String,
      };
      FirebaseServices("user").setDocument(
        creadential.user!.uid,
        {
          "id": creadential.user!.uid,
          "email": creadential.user!.email as String,
        }
      );
      context.read<AppViewModel>().setLoggedInUser(detail);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> facebookSignIn(BuildContext context) async {
    try {
      FacebookAuthProvider  provider = FacebookAuthProvider ();
      provider.addScope("email");
      final creadential = await FirebaseAuth.instance.signInWithPopup(provider);
      Map<String, dynamic> detail = {
        "id": creadential.user!.uid,
        "email": creadential.user!.email as String,
      };
      FirebaseServices("user").setDocument(
        creadential.user!.uid,
        {
          "id": creadential.user!.uid,
          "email": creadential.user!.email as String,
        }
      );
      context.read<AppViewModel>().setLoggedInUser(detail);
      return true;
    } catch (e) {
      return false;
    }
  }
}