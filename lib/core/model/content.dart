import 'dart:io';

class Content {
  late String _text;
  String? _optionalString;
  File? _file;

  Content(String text) {
    _text = text;
  }

  set setOptionalString(String text) {
    _optionalString = text;
  }

  String get getText => _text;
  String? get getOptionalString => _optionalString;
  File? get getFile => _file;

  void addFile(File file) {
    _file = file;
  }
}