// ignore_for_file: unused_field

class AppUser {
  String _id = "";
  int? _role;
  String _name = "";
  String _email = "";
  String? _phone;
  String? _profileImageUrl;
  List<dynamic> _responsibility = [];

  AppUser();

  // * map structure include the attribute of this class
  AppUser.overloaddedConstructor(Map<String, dynamic> detail) {
    _id = detail.keys.contains("id") ? detail["id"] : "";
    _name = detail.keys.contains("name") ? detail["name"] : "";
    _email = detail.keys.contains("email") ? detail["email"] : "";
    _phone = detail.keys.contains("phone") ? detail["phone"] : null;
    _role = detail.keys.contains("role") ? detail["role"] : null;
    _profileImageUrl = detail.keys.contains("profileImageUrl") ? detail["profileImageUrl"] : null;
    _responsibility = detail.keys.contains("responsibility") ? detail["responsibility"] : [];
  }

  String get getName => _name;
  String get getEmail => _email;
  String? get getPhone => _phone;
  String? get getProfileImageUrl => _profileImageUrl;
  String get getId => _id;
  int? get getRole => _role;
  List<dynamic> get getResponsibility => _responsibility;

  set setProfileImageUrl(String url) => _profileImageUrl = url;
  set setRole(int role) => _role = role;
}
