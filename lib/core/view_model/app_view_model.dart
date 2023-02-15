import 'package:flutter/cupertino.dart';
import 'package:senior_project/core/model/app.dart';
import 'package:senior_project/core/model/user/app_user.dart';

class AppViewModel extends ChangeNotifier {
  App app = App();
  late bool _isMobileSite;
  final double _mobileWidthBreakpoint = 430;
  late bool _isLogin;

  void selectView(double pixelWidth) {
    if(pixelWidth <= _mobileWidthBreakpoint) {
      _isMobileSite = true;
    } else {
      _isMobileSite = false;
    }
  }

  void initializeLoginState(bool state) {
    _isLogin = state;
  }

  bool get getMobileSiteState => _isMobileSite;

  void setLoggedInUser(Map<String, dynamic> detail) {
    AppUser user = AppUser.overloaddedConstructor(detail);
    app.setAppUser = user;
    _isLogin = true;
    notifyListeners();
  }

  void logout() {
    app.setAppUser = AppUser();
    _isLogin = false;
    notifyListeners();
  }

  bool get hasUser => _isLogin;
}