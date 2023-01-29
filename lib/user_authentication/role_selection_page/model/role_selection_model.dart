class RoleSelectionModel {
  final double _textBreakpoint = 620;
  late bool _isTextBreakpoint;
  bool _isStudentCardSelected = true;

  double get getTextBreakpoint => _textBreakpoint;
  bool? get getIsTextbreakpoint => _isTextBreakpoint;
  bool get getIsStudentCardSelected => _isStudentCardSelected;

  set setIsTextBreakpoint(bool state) => _isTextBreakpoint = state;

  void changeStudentCardSelectedState() {
    _isStudentCardSelected = !_isStudentCardSelected;
  }

  void calculateTextBreakpoint(double pixelWidth) {
    if (pixelWidth <= _textBreakpoint) {
      _isTextBreakpoint = true;
    } else {
      _isTextBreakpoint = false;
    }
  }
}