// ignore_for_file: prefer_final_fields

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:senior_project/core/datasource/algolia_services.dart';
import 'package:senior_project/core/datasource/firebase_services.dart';
import 'package:senior_project/role_management/model/role_management_model.dart';

class RoleManagementViewModel extends ChangeNotifier {
  final FirebaseServices _serviesCategory = FirebaseServices("category");
  final FirebaseServices _serviesTicket = FirebaseServices("ticket");
  final FirebaseServices _servicesUser = FirebaseServices("user");
  final FirebaseServices _servicesFAQ = FirebaseServices("faq");
  List<String> _alluser = [];
  RoleManagementModel _model = RoleManagementModel();

  void initModel() {
    _model = RoleManagementModel();
    _alluser = [];
  }

  List<TopicCategory> get getCategories => _model.getCategory;
  List<Admin> get getAdmin => _model.getAdmin;
  List<String> get getAllUser => _alluser;

  Future<bool> addAdmin(String email) async {
    final snaopshot =
        await _servicesUser.getDocumnetByKeyValuePair(["email"], [email]);
    if (snaopshot!.docs.isNotEmpty) {
      bool isSuccess =
          await _servicesUser.editDocument(snaopshot.docs.first.id, {
        "role": 0,
      });
      return isSuccess;
    } else {
      return false;
    }
  }

  Future<bool> changeResponsibility(
      String uid, List<TopicCategory> newResponsibility) async {
    try {
      List<String> responsibility = [];
      for (int i = 0; i < newResponsibility.length; i++) {
        responsibility.add(newResponsibility[i].id!);
      }
      bool isSuccess = await _servicesUser
          .editDocument(uid, {"responsibility": responsibility});
      for (int i = 0; i < responsibility.length; i++) {
        final snapshot = await _serviesTicket.getDocumnetByKeyValuePair(["category"], [responsibility[i]]);
        for (int j = 0; j < snapshot!.size; j ++) {
          if (snapshot.docs[j].get("status") == 0) {
            List<dynamic> adminList = snapshot.docs[j].get("relateAdmin");
            if(!adminList.contains(uid)) {
              adminList.add(uid);
              await _serviesTicket.editDocument(snapshot.docs[j].id, {"relateAdmin": adminList});
              await AlgoliaServices("ticket").updateObject(
                snapshot.docs[i].get("objectID"), 
                {"relateAdmin": adminList}
              );
            }
          }
        }
      }
      return isSuccess; 
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return false;
    }
  }

  Future<void> removeAdmin(String uid) async {
    try {
      final snapshot = await _servicesUser.getDocumentById(uid);
      List<dynamic> responsibility = [];
      if (snapshot != null) {
        responsibility = snapshot.get("responsibility");
      }
      await _servicesUser.editDocument(uid, {
        "responsibility": [],
        "role": 1
      });
      for (int i = 0; i < responsibility.length; i++) {
        final snapshot = await _serviesTicket.getDocumnetByKeyValuePair(["category"], [responsibility[i]]);
        for (int j = 0; j < snapshot!.size; j ++) {
          List<dynamic> adminList = snapshot.docs[j].get("relateAdmin");
          if (adminList.contains(uid)) {
            adminList.remove(uid);
            await _serviesTicket.editDocument(snapshot.docs[j].id, {
              "relateAdmin": adminList
            });
          }
        }
      }
    } catch(e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future<bool> addCategory(AddCategoryRequest request) async {
    bool isSuccess = await _serviesCategory.setDocument(request.categoryName, {
      "name": request.categoryName,
      "description": request.description,
      "isHelpDesk": true,
      "isCommunity": false,
      "isApproved": false
    });
    return isSuccess;
  }

  Future<RoleManagementModel> fetchPage() async {
    List<TopicCategory> category = [];
    List<Admin> admin = [];

    final categorySnapshot = await _serviesCategory
        .getDocumnetByKeyValuePair(["isHelpDesk"], [true]);
    if (categorySnapshot != null) {
      category = categorySnapshot.docs
          .map((doc) => TopicCategory(
                id: doc.id,
                categoryName: doc.get("name"),
                description: doc.get("description"),
              ))
          .toList();
    }
    final adminSnapshot = await _servicesUser.getAllDocument();
    if (adminSnapshot != null) {
      for (int i = 0; i < adminSnapshot.docs.length; i++) {
        if (adminSnapshot.docs[i].get("role") == 0) {
          List<dynamic> resposibility =
              adminSnapshot.docs[i].get("responsibility");
          List<TopicCategory> cat = [];
          for (int j = 0; j < resposibility.length; j++) {
            final categorySnapshot =
                await _serviesCategory.getDocumentById(resposibility[j]);
            if (categorySnapshot != null && categorySnapshot.exists) {
              cat.add(TopicCategory(
                id: categorySnapshot.id,
                categoryName: categorySnapshot.get("name"),
                description: categorySnapshot.get("description"),
              ));
            }
          }

          List<String> name =
              adminSnapshot.docs[i].get("name").toString().split(" ");
          admin.add(Admin(
            adminSnapshot.docs[i].id,
            name[0],
            name[1],
            adminSnapshot.docs[i].get("email"),
            "Admin",
            cat,
          ));
        } else {
          _alluser.add(adminSnapshot.docs[i].get("email"));
        }
      }
    }
    final model = RoleManagementModel.overloaddedConstructor(admin, category);
    _model = model;
    return model;
  }

  Future<void> deleteCategory(String docId, bool isEdit) async {
    await _serviesCategory.deleteDocument(docId);
    if (!isEdit) {
      final snapshot = await _servicesFAQ.getDocumnetByKeyValuePair(["category"], [docId]);
      if (snapshot!.size != 0) {
        for (QueryDocumentSnapshot doc in snapshot.docs) {
          await _servicesFAQ.editDocument(doc.id, {
            "category": "General"
          });
        }
      }
    }
  }

  Future<void> editCategory(String docId, String title, String detail) async {
    if (title != docId) {
      await deleteCategory(docId, true);
      await _serviesCategory.setDocument(title, {
        "name": title,
        "description": detail,
        "isHelpDesk": true,
        "isCommunity": false,
        "isApproved": false
      });
      final snapshot = await _servicesFAQ.getDocumnetByKeyValuePair(["category"], [docId]);
      if (snapshot!.size != 0) {
        for (QueryDocumentSnapshot doc in snapshot.docs) {
          await _servicesFAQ.editDocument(doc.id, {
            "category": title
          });
        }
      }
    } else {
      await _serviesCategory.editDocument(docId, {
        "description": detail,
      });
    }
  }
}
