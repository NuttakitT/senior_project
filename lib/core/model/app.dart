import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:senior_project/core/model/user/app_user.dart';

class App {
  AppUser? loggedInUser;

  Future<bool> login(String email, String password) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email, 
        password: password
      );
      final users = await FirebaseFirestore
        .instance
        .collection("user")
        .doc(credential.user?.uid)
        .get();
      Map<String, dynamic> userDetail = {
        "id": credential.user?.uid,
        "email": credential.user?.email,
        "role": users.get("role"),
        "name": users.get("name"),
        "phone": users.get("phone"),
        "birthday": users.get("birthday"),
        "gender": users.get("gender"),
        "profileImageUrl": users.get("profileImageUrl"),
        "linkId": users.get("linkId")
      };
      AppUser.overloaddedConstructor(userDetail);
      return true;
    } catch (e) {
      return false;
    }
  }

  void logout() async {
    await FirebaseAuth.instance.signOut();
    loggedInUser = null;
  }
}
