import 'package:flutter/foundation.dart';
import 'package:senior_project/help_desk/help_desk_main/model/help_desk_main_model.dart';

class HelpDeskViewModel extends ChangeNotifier {
  HelpDeskModel helpDeskModel = HelpDeskModel();

  String getName() {
    String name = "George";
    return name;
  }
}
