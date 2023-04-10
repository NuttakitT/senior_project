class RoleManagementModel {
  List<Admin> admins = [];
  List<TopicCategory> categories = [];

  RoleManagementModel();
  RoleManagementModel.overloaddedConstructor(List<Admin> admin, List<TopicCategory> category) {
    admins.addAll(admin);
    categories.addAll(category);
  }

  List<TopicCategory> get getCategory => categories;
  List<Admin> get getAdmin => admins;
  void addCategory(TopicCategory category) => categories.add(category);
  void addAdmin(Admin admin) => admins.add(admin);
}

class Admin {
  final String userId;
  final String firstName;
  final String lastName;
  final String email;
  final String role;
  List<TopicCategory> responsibility;

  Admin(
    this.userId,
    this.firstName,
    this.lastName,
    this.email,
    this.role,
    this.responsibility,
  );
}

class TopicCategory {
  final String? id;
  final String categoryName;
  final String description;

  TopicCategory(
      {required this.id,
      required this.categoryName,
      required this.description});
}

class AddCategoryRequest {
  final String categoryName;
  final String description;

  AddCategoryRequest({required this.categoryName, required this.description});
}
