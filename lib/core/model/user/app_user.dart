class AppUser {
  late String _id;
  late int _role;
  late String _username;
  late String _name;
  late String _email;
  late String _phone;
  late int _gender;
  late DateTime _birthday;
  String? _profileImageUrl;
  String? _linkId;

  AppUser();

  // * map structure include the attribute of this class
  AppUser.overloaddedConstructor(Map<String, dynamic> detail) {
    _id = detail["id"]!;
    _name = detail["name"]!;
    _email = detail["email"]!;
    _phone = detail["phone"]!;
    _gender = detail["gender"]!;
    _role = detail["role"]!;
    _birthday = detail["birthday"]!;
    _profileImageUrl = detail["profileImageUrl"]!;
    _linkId = detail["linkId"]!;
  }

  String get getUsername => _username;
  String get getName => _name;
  String get getEmail => _email;
  String get getBirthday => _birthday.toString();
  String get getPhone => _phone;
  String? get getProfileImageUrl => _profileImageUrl;
  String? get getLinkId => _linkId;
  String get getRole {
    if(_role == 0) return "admin";
    if(_role == 1) return "student";
    return "teacher";
  }
  String get getGender {
    if(_gender == 0) return "male";
    return "female";
  }

  set setProfileImageUrl(String url) => _profileImageUrl = url;
  set setBirthday(DateTime birthday) => _birthday = birthday;
  set setName(String name) => _name = name;
  set setPhone(String phone) => _phone = phone;
  set setGender(int gender) => _gender = gender;
}
