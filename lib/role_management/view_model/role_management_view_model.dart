import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:senior_project/core/datasource/firebase_services.dart';
import 'package:uuid/uuid.dart';

import '../model/role_management_model.dart';

class RoleManagementViewModel extends ChangeNotifier {
  final FirebaseServices _serviesCategory = FirebaseServices("category");
  RoleManagementModel _model = RoleManagementModel();
  final List<Admin> _admins = [
    Admin(
        userId: "32",
        firstName: "firstName",
        lastName: "lastName",
        email: "emailemailemailemailemail",
        role: "role",
        responsibility: [
          TopicCategory(
              id: "01", categoryName: "นอน", description: "bvjoevbwo"),
          TopicCategory(
              id: "02", categoryName: "ปลูกผัก", description: "bvjoevbwo")
        ]),
    Admin(
        userId: "33",
        firstName: "firstName",
        lastName: "lastName",
        email: "email",
        role: "role",
        responsibility: [
          TopicCategory(
              id: "03333333",
              categoryName: "ถูพื้นถูพื้นถูพื้นถูพื้นถูพื้นถูพื้นถูพื้น",
              description: "bvjoevbwo"),
          TopicCategory(
              id: "04", categoryName: "ล้างจาน", description: "bvjoevbwo")
        ]),
  ];

  void initModel() {
    _model = RoleManagementModel();
  }

  List<TopicCategory> get getCategories => _model.getCategory;

  // Role management
  Future<List<Admin>> getAdmins() async {
    return Future.value(_admins);
  }

  Future<bool> addAdmin(AddAdminRequest request) async {
    return false;
  }

  Future<void> changeResponsibility(
      List<TopicCategory> newResponsibility) async {}

  void setSearchText(String text) {
    // TODO: make search text
    notifyListeners();
  }

  Future<bool> addCategory(AddCategoryRequest request) async {
    bool isSuccess = await _serviesCategory.addDocument({
      "name": request.categoryName,
      "description": request.description
    });
    return isSuccess;
  }

  Future<RoleManagementModel> fetchPage() async {
    List<TopicCategory> category = [];
    final admins = await getAdmins();
    final cateogorySnapshot = await _serviesCategory.getAllDocument();
    for(int i = 0; i < cateogorySnapshot!.docs.length; i++) {
      category.add(
        TopicCategory(
          id: cateogorySnapshot.docs[i].id, 
          categoryName: cateogorySnapshot.docs[i].get("name"), 
          description: cateogorySnapshot.docs[i].get("description")
        )
      );
    }

    _model = RoleManagementModel.overloaddedConstructor(admins, category);
    return _model;
  }
}
