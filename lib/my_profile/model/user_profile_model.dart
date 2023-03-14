class UserModel {
  final String id;
  final String imageUrl;
  final String name;
  final String aboutMe;
  final String email;
  final String phone;
  final String officeHours;
  final String role;

  UserModel({
    required this.id,
    required this.imageUrl,
    required this.name,
    required this.aboutMe,
    required this.email,
    required this.phone,
    required this.officeHours,
    required this.role,
  });

  Map<String, dynamic> toMap() {
    var nameOnly = name.split("_")[0];
    var surnameOnly = name.split("_")[1];

    return {
      'uid': id,
      'imageUrl': imageUrl,
      'name': nameOnly,
      'surname': surnameOnly,
      'aboutMe': aboutMe,
      'email': email,
      'phone': phone,
      'officeHours': officeHours,
      'role': role
    };
  }
}
