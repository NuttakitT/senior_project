class RoleManagementModel {
  List<Admin> admins;
  List<TopicCategory> categories;

  RoleManagementModel({required this.admins, required this.categories});
}

class Admin {
  final String firstName;
  final String lastName;
  final String email;
  final String role;
  final List<String> responsibility;

  Admin({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.role,
    required this.responsibility,
  });
}

class TopicCategory {
  final String number;
  final String categoryName;
  final String description;

  TopicCategory(
      {required this.number,
      required this.categoryName,
      required this.description});
}

class AddCategoryRequest {
  final String categoryName;
  final String description;

  AddCategoryRequest({required this.categoryName, required this.description});
}

class AddAdminRequest {}
