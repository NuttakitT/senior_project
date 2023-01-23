import 'package:flutter/foundation.dart';

class PageViewModel extends ChangeNotifier {
  bool _isShowLoinPage = true;

  void changeViewState() {
    _isShowLoinPage = !_isShowLoinPage;
    notifyListeners();
  }

  bool get getPageState => _isShowLoinPage;
}