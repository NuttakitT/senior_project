import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:senior_project/core/view_model/cryptor.dart';

import '../model/role_management_model.dart';

class RoleManagementViewModel extends ChangeNotifier {
  final List<Admin> _admins = [
    Admin(
        userId: "32",
        firstName: "firstName",
        lastName: "lastName",
        email: "email",
        role: "role",
        responsibility: [
          TopicCategory(
              number: "01", categoryName: "นอน", description: "bvjoevbwo"),
          TopicCategory(
              number: "02", categoryName: "ปลูกผัก", description: "bvjoevbwo")
        ]),
    Admin(
        userId: "33",
        firstName: "firstName",
        lastName: "lastName",
        email: "email",
        role: "role",
        responsibility: [
          TopicCategory(
              number: "03", categoryName: "ถูพื้น", description: "bvjoevbwo"),
          TopicCategory(
              number: "04", categoryName: "ล้างจาน", description: "bvjoevbwo")
        ]),
  ];

  final List<TopicCategory> _categories = [
    TopicCategory(number: "01", categoryName: "นอน", description: "bvjoevbwo"),
    TopicCategory(
        number: "02", categoryName: "ปลูกผัก", description: "bvjoevbwo"),
    TopicCategory(
        number: "03", categoryName: "ถูพื้น", description: "bvjoevbwo"),
    TopicCategory(
        number: "04", categoryName: "ล้างจาน", description: "bvjoevbwo"),
  ];
  get categories => _categories;

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
