import 'dart:io';

class Content {
  late String _text;
  File? _file;

  Content(String text) {
    _text = text;
  }

  String get getText => _text;
  File? get getFile => _file;

  void addFile(File file) {
    _file = file;
  }
}