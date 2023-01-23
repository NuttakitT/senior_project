import 'package:senior_project/core/model/user/app_user.dart';

class App {
  AppUser? _loggedInUser;

  void login(AppUser user) {
    _loggedInUser = user;
  }

  void logout() async {
    _loggedInUser = null;
  }

  AppUser get getLoggedInUser => _loggedInUser as AppUser;
}
