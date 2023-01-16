import 'gender.dart';
import 'role.dart';

class AppUser {
  late String id;
  late Role role;
  late String name;
  late String email;
  late String phone;
  late Gender gender;
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
    if (detail.keys.contains("profileImageUrl")) {
      profileImageUrl = detail["profileImageUrl"]!;
    }
    if (detail.keys.contains("linkId")) {
      linkId = detail["linkId"]!;
    }
  }

  String get getName => name;
  String get getRole => role.toString();
  String get getEmail => email;
  String get getBirthday => birthday.toString();
  String get getPhone => phone;
  String? get getProfileImageUrl => profileImageUrl;
  String? get getLinkId => linkId;
  set setProfileImageUrl(String url) => profileImageUrl = url;
  set setBirthday(DateTime birthday) => this.birthday = birthday;
  set setName(String name) => this.name = name;
  set setPhone(String phone) => this.phone = phone;
}
