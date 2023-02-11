import 'package:senior_project/core/model/user/app_user.dart';
import 'package:senior_project/help_desk/help_desk_main/view/widget/help_desk_desktop_body_widget.dart';

class HelpDeskModel extends AppUser {
  HelpDeskCard? card;
}

class HelpDeskCard {
  final String? title;
  final int? cardNumber;
  final String? category;
  final String? detail;
  final String? priority;
  final Status? status;
  final String? userName;

  HelpDeskCard(
      {this.title,
      this.cardNumber,
      this.category,
      this.detail,
      this.priority,
      this.status,
      this.userName});
}

enum Status { notStart, inProgress, done }
