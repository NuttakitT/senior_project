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
    _name = detail["name"]!;
    _email = detail["email"]!;
    _phone = detail["phone"]!;
    _gender = detail["gender"]!;
    _role = detail["role"]!;
    _birthday = detail["birthday"]!;
    _profileImageUrl = detail["profileImageUrl"]!;
    _linkId = detail["linkId"]!;
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
}
