import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:senior_project/core/template/template_mobile/view/template_menu_mobile.dart';
import 'package:senior_project/user_profile/my_profile/view/user/widget/user_profile_card.dart';
import 'package:senior_project/user_profile/my_profile/view/user/widget/user_profile_header.dart';
import 'package:senior_project/core/template/template_desktop/view/page/template_desktop.dart';
import 'widget/user_profile_mobile.dart';

class UserProfileView extends StatelessWidget {
  final Map<String, dynamic> data;
  const UserProfileView({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    bool isMobileSite = kIsWeb &&
        (defaultTargetPlatform == TargetPlatform.iOS ||
            defaultTargetPlatform == TargetPlatform.android);
    // bool isMobileSite = context
    //     .watch<AppViewModel>()
    //     .getMobileSiteState(MediaQuery.of(context).size.width);

    if (isMobileSite) {
      return TemplateMenuMobile(
          content: UserProfileMobile(
        profileData: data,
      ));
    } else {
      return TemplateDesktop(
          helpdesk: false,
          helpdeskadmin: false,
          home: false,
          useTemplatescroll: false,
          content: Column(
            children: [
              UserProfileHeader.widget(context),
              UserProfileCard.widget(context, data),
            ],
          ));
    }
  }
}
