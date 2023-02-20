import 'package:senior_project/core/model/user/app_user.dart';

class App {
  AppUser _user = AppUser();
  // HelpDesk _helpDesk = HelpDesk();

  AppUser get getUser => _user;
  set setAppUser(AppUser user) => _user = user;

  // HelpDesk get getHelpDesk => _helpDesk;
  // void initHelpDesk([List<Task>? tasks]) {
  //   if (tasks!.isNotEmpty) {
  //     _helpDesk = HelpDesk.overloaddedConstructor(tasks);
  //   } else {
  //     _helpDesk = HelpDesk();
  //   }
  // }
}
