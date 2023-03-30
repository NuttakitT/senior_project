import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:senior_project/core/view_model/cryptor.dart';

import '../model/role_management_model.dart';

class RoleManagementViewModel extends ChangeNotifier {
  final List<Admin> _admins = [
    Admin(
        firstName: "firstName",
        lastName: "lastName",
        email: "email",
        role: "role",
        responsibility: ["นอน", "ปลูกผัก"]),
    Admin(
        firstName: "firstName",
        lastName: "lastName",
        email: "email",
        role: "role",
        responsibility: ["ถูพื้น", "ล้างจาน"]),
  ];

  final List<TopicCategory> _categories = [
    TopicCategory(number: "01", categoryName: "www", description: "bvjoevbwo")
  ];

  // Role management
  Future<List<Admin>> getAdmins() async {
    return Future.value(_admins);
  }

  Future<bool> addAdmin(AddAdminRequest request) async {
    return false;
  }

  Future<void> changeResponsibility() async {}

  void setSearchText(String text) {
    // TODO: make search text
    notifyListeners();
  }

  // List category
  Future<List<TopicCategory>> getCategories() async {
    return Future.value(_categories);
  }

  Future<bool> addCategory(AddCategoryRequest request) async {
    return false;
  }

  Future<RoleManagementModel> fetchPage() async {
    final admins = await getAdmins();
    final categories = await getCategories();

    final model = RoleManagementModel(admins: admins, categories: categories);
    return model;
  }
}
