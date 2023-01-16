import 'package:senior_project/core/model/user/app_user.dart';

class App {
  AppUser? loggedInUser;

  void login(AppUser user) {
    loggedInUser = user;
  }

  void logout() {
    loggedInUser = null;
  }
}
