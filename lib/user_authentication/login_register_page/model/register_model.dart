import 'package:senior_project/core/model/user/app_user.dart';

class RegisterModel extends AppUser {
  String? _password;

  String? get getPassword => _password;
  set setPassword(String password) => _password = password;
}