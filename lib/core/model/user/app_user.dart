class AppUser {
  late String id;
  late int role;
  late String name;
  late String email;
  late String phone;
  late int gender;
  late DateTime birthday;
  String? profileImageUrl;
  String? linkId;

  AppUser();

  // * map structure include the attribute of this class
  AppUser.overloaddedConstructor(Map<String, dynamic> detail) {
    id = detail["id"]!;
    name = detail["name"]!;
    email = detail["email"]!;
    phone = detail["phone"]!;
    gender = detail["gender"]!;
    role = detail["role"]!;
    birthday = detail["birthday"]!;
    profileImageUrl = detail["profileImageUrl"]!;
    linkId = detail["linkId"]!;
  }

  String get getName => name;
  String get getEmail => email;
  String get getBirthday => birthday.toString();
  String get getPhone => phone;
  String? get getProfileImageUrl => profileImageUrl;
  String? get getLinkId => linkId;
  String get getRole {
    if(role == 0) return "admin";
    if(role == 1) return "student";
    return "teacher";
  }
  String get getGender {
    if(gender == 0) return "male";
    return "female";
  }

  set setProfileImageUrl(String url) => profileImageUrl = url;
  set setBirthday(DateTime birthday) => this.birthday = birthday;
  set setName(String name) => this.name = name;
  set setPhone(String phone) => this.phone = phone;
  set setGender(int gender) => this.gender = gender;
}
