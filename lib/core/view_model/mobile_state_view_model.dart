import 'package:flutter/cupertino.dart';

class MobileStateViewModel extends ChangeNotifier {
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