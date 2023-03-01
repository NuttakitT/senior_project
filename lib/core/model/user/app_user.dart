class AppUser {
  String _id = "";
  int? _role;
  String _username = "";
  String _name = "";
  String _email = "";
  String _phone = "";
  int? _gender;
  DateTime? _birthday;
  String _profileImageUrl = "";
  String _linkId = "";

  AppUser();

  // * map structure include the attribute of this class
  AppUser.overloaddedConstructor(Map<String, dynamic> detail) {
    _id = detail.keys.contains("id") ? detail["id"] : "";
    _username = detail.keys.contains("username") ? detail["username"] : "";
    _name = detail.keys.contains("name") ? detail["name"] : "";
    _email = detail.keys.contains("email") ? detail["email"] : "";
    _phone = detail.keys.contains("phone") ? detail["phone"] : "";
    _gender = detail.keys.contains("gender") ? int.parse(detail["gender"]) : null;
    _role = detail.keys.contains("role") ? int.parse(detail["role"]) : null;
    _birthday = detail.keys.contains("birthday") ? detail["birthday"] : null;
    _profileImageUrl = detail.keys.contains("profileImageUrl") ? detail["profileImageUrl"] : "";
    _linkId = detail.keys.contains("linkId") ? detail["linkId"] : "";
  }

  String get getUsername => _username;
  String get getName => _name;
  String get getEmail => _email;
  String get getBirthday => _birthday.toString();
  String get getPhone => _phone;
  String get getProfileImageUrl => _profileImageUrl;
  String get getLinkId => _linkId;
  String get getId => _id;
  int? get getRole => _role;
  int? get getGender => _gender;

  set setProfileImageUrl(String url) => _profileImageUrl = url;
  set setBirthday(DateTime birthday) => _birthday = birthday;
  set setUsername(String username) => _username = username;
  set setEmail(String email) => _email = email;
  set setName(String name) => _name = name;
  set setPhone(String phone) => _phone = phone;
  set setGender(int gender) => _gender = gender;
  set setLinkId(String linkId) => _linkId = linkId;
  set setRole(int role) => _role = role;
}
