// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:senior_project/core/datasource/firebase_services.dart';
import 'package:senior_project/core/model/app.dart';
import 'package:senior_project/core/model/user/app_user.dart';
import 'package:senior_project/user_authentication/login_register_page/view_model/authentication_view_model.dart';

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

  bool get getMobileSiteState => _isMobileSite;

  void setLoggedInUser(Map<String, dynamic> detail) {
    AppUser user = AppUser.overloaddedConstructor(detail);
    app.setAppUser = user;
    _isLogin = true;
    notifyListeners();
  }

  Future<void> initializeLoginState(BuildContext context, bool state) async {
    if (state) {
      final snapshot = await FirebaseServices("user").getDocumentById(
        FirebaseAuth.instance.currentUser!.uid
      );
      if (snapshot != null) {
        Map<String, dynamic> detail = context.read<AuthenticationViewModel>().storeAppUser(snapshot);
        setLoggedInUser(detail);
      }
    } else {
      _isLogin = false;
    }
  }

  void logout() {
    app.setAppUser = AppUser();
    _isLogin = false;
    notifyListeners();
  }

  bool get hasUser => _isLogin;
}