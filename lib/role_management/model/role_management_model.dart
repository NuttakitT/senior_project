class RoleManagementModel {
  // Default setting
  List<Admin> admins = [];
  List<TopicCategory> categories = [
    TopicCategory(id: null, categoryName: "General", description: "General"),
  ];

  RoleManagementModel();
  RoleManagementModel.overloaddedConstructor(List<Admin> admin, List<TopicCategory> category) {
    admins = admin;
    categories.addAll(category);
  }

  get getCategory => categories;
  get getAdmin => admins;
  void addCategory(TopicCategory category) => categories.add(category);
  void addAdmin(Admin admin) => admins.add(admin);
}

class Admin {
  final String userId;
  final String firstName;
  final String lastName;
  final String email;
  final String role;
  final List<TopicCategory> responsibility;

  Admin({
    required this.userId,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.role,
    required this.responsibility,
  });
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

class AddAdminRequest {}
