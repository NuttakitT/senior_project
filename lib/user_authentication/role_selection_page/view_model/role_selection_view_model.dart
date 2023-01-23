import 'package:flutter/cupertino.dart';

class RoleSelectionViewModel extends ChangeNotifier{
  final double _textBreakpoint = 620;
  late bool _isTextBreakpoint;
  bool _isStudentCardSelected = true;

  void calculateTextBreakpoint(double pixelWidth) {
    if (pixelWidth <= _textBreakpoint) {
      _isTextBreakpoint = true;
    } else {
      _isTextBreakpoint = false;
    }
  }

  void changeCardSelectedState(bool isSelected) {
    _isStudentCardSelected = isSelected;
    notifyListeners();
  }

  bool get getTextBreakpoint => _isTextBreakpoint;
  bool get getStudentCardSelected => _isStudentCardSelected;
}