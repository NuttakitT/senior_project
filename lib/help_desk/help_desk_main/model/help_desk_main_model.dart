import 'package:senior_project/core/model/user/app_user.dart';
import 'package:senior_project/help_desk/help_desk_main/view/widget/help_desk_desktop_body_widget.dart';

class HelpDeskModel extends AppUser {
  HelpDeskCard? card;
}

class HelpDeskCard {
  final String? title;
  final String? category;
  final String? detail;
  final String? priority;

  HelpDeskCard({this.title, this.category, this.detail, this.priority});
}

// const data = [
//   {
//     "title": "title01",
//     "category": "Room jeng",
//     "detail":
//         "Lorem ipsum grhbnujibnrogbibveifgwyvbiewvgviowevyueovfuyfsvuyfvwvu",
//     "priority": "high"
//   },
//   {
//     "title": "title02",
//     "category": "Roommmmmm jeng",
//     "detail":
//         "Lorem ipsum grhbnujibnrogbibveifgwyvbiewvgviowevyueovfuyfsvuyfvwvu",
//     "priority": "high"
//   },
//   {
//     "title": "title03",
//     "category": "GGGGGGGGGJGJGJGJGJGJGJGJG",
//     "detail":
//         "Lorem ipsum grhbnujibnrogbibveifgwyvbiewvgviowevyueovfuyfsvuyfvwvu",
//     "priority": "high"
//   },
// ];
