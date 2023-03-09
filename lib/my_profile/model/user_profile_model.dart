class UserModel {
  final String uid;
  final String imageUrl;
  final String name;
  final String surname;
  final String aboutMe;
  final String email;
  final String phone;
  final String officeHours;
  final String role;

  UserModel({
    required this.uid,
    required this.imageUrl,
    required this.name,
    required this.surname,
    required this.aboutMe,
    required this.email,
    required this.phone,
    required this.officeHours,
    required this.role,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'imageUrl': imageUrl,
      'name': name,
      'surname': surname,
      'aboutMe': aboutMe,
      'email': email,
      'phone': phone,
      'officeHours': officeHours,
      'role': role
    };
  }
}
