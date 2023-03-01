import 'package:flutter/material.dart';

class TeacherContactViewModel extends ChangeNotifier {
  bool _isEditing = false;

  bool get isEditing => _isEditing;

  void toggleEditButton() {
    _isEditing = !_isEditing;
    notifyListeners();
  }
}
