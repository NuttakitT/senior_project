import 'package:senior_project/core/model/user/app_user.dart';

class RegisterModel extends AppUser {
  String? _password;
  bool _visibilityText = true;
  bool _isShowLoinPage = true;

  String? get getPassword => _password;
  bool get getVisibilityState => _visibilityText;
  bool get getIsShowLoginPage => _isShowLoinPage;

  set setPassword(String password) => _password = password;

  void changeVisibilityState() {
    _visibilityText = !_visibilityText;
  }
  void changeShowPageState() {
    _isShowLoinPage = !_isShowLoinPage;
  }
}