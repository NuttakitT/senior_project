import 'package:senior_project/core/model/user/app_user.dart';

class App {
  AppUser _user = AppUser();

  AppUser get getUser => _user;
  set setAppUser(AppUser user) => _user = user;
}
