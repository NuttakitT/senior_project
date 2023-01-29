class AppUser {
  int? _role;
  String? _username;
  String? _name;
  String?_email;
  String? _phone;
  int? _gender;
  DateTime? _birthday;
  String? _profileImageUrl;
  String? _linkId;

  AppUser();

  // * map structure include the attribute of this class
  AppUser.overloaddedConstructor(Map<String, dynamic> detail) {
    _username = detail.keys.contains("username") ? detail["username"] : null;
    _name = detail.keys.contains("name") ? detail["name"] : null;
    _email = detail.keys.contains("email") ? detail["email"] : null;
    _phone = detail.keys.contains("phone") ? detail["phone"] : null;
    _gender = detail.keys.contains("gender") ? int.parse(detail["gender"]) : null;
    _role = detail.keys.contains("role") ? int.parse(detail["role"]) : null;
    _birthday = detail.keys.contains("birthday") ? detail["birthday"] : null;
    _profileImageUrl = detail.keys.contains("profileImageUrl") ? detail["profileImageUrl"] : null;
    _linkId = detail.keys.contains("linkId") ? detail["linkId"] : null;
  }

  String? get getUsername => _username;
  String? get getName => _name;
  String? get getEmail => _email;
  String? get getBirthday => _birthday.toString();
  String? get getPhone => _phone;
  String? get getProfileImageUrl => _profileImageUrl;
  String? get getLinkId => _linkId;
  String? get getRole {
    if(_role == 0) return "admin";
    if(_role == 1) return "student";
    if(_role == 2) return "teacher";
    return null;
  }
  String? get getGender {
    if(_gender == 0) return "male";
    if(_gender == 1) return "female";
    return null;
  }

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
