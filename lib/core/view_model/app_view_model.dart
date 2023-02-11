import 'package:flutter/cupertino.dart';
import 'package:senior_project/core/model/app.dart';
import 'package:senior_project/core/model/user/app_user.dart';

class AppViewModel extends ChangeNotifier {
  App app = App();
  late bool _isMobileSite;
  final double _mobileWidthBreakpoint = 430;
  late bool isLogin;

  void selectView(double pixelWidth) {
    if(pixelWidth <= _mobileWidthBreakpoint) {
      _isMobileSite = true;
    } else {
      _isMobileSite = false;
    }
  }

  void initializeLoginState(bool state) {
    isLogin = state;
  }

  bool get getMobileSiteState => _isMobileSite;

  void setLoggedInUser(Map<String, dynamic> detail) {
    AppUser user = AppUser.overloaddedConstructor(detail);
    app.setAppUser = user;
    isLogin = true;
    notifyListeners();
  }

  void logout() {
    app.setAppUser = AppUser();
    isLogin = false;
    notifyListeners();
  }

  bool get hasUser => isLogin;
}