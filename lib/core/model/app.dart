import 'package:senior_project/core/model/user/app_user.dart';

class App {
  AppUser? _user;

  AppUser get getUser => _user as AppUser;
  set setAppUser(AppUser user) => _user = user;
}
