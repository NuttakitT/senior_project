import 'package:flutter/cupertino.dart';
import 'package:senior_project/core/model/app.dart';

class AppViewModel extends ChangeNotifier {
  App app = App();
  late bool _isMobileSite;
  final double _mobileWidthBreakpoint = 430;

  void selectView(double pixelWidth) {
    if(pixelWidth <= _mobileWidthBreakpoint) {
      _isMobileSite = true;
    } else {
      _isMobileSite = false;
    }
  }

  bool get getMobileSiteState => _isMobileSite;
}