import 'package:flutter/material.dart';

class StatisticViewModel extends ChangeNotifier {
  final StatisticViewModel _model = StatisticViewModel();
  Future<StatisticViewModel> fetchPage() async {
    return _model;
  }
}
