import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senior_project/core/template_mobile/view/template_menu_mobile.dart';
import 'package:senior_project/user_profile/my_profile/view/user/widget/admin_profile_mobile.dart';
import 'package:senior_project/user_profile/my_profile/view/user/widget/user_profile_card.dart';
import 'package:senior_project/user_profile/my_profile/view/user/widget/user_profile_header.dart';
import 'package:senior_project/core/template_desktop/view/page/template_desktop.dart';

import '../../../../../core/view_model/app_view_model.dart';

class AdminProfileView extends StatelessWidget {
  final Map<String, dynamic> data;
  const AdminProfileView({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    bool isMobileSite = context.watch<AppViewModel>().getMobileSiteState(MediaQuery.of(context).size.width);

    if (isMobileSite) {
      return TemplateMenuMobile(
          content: AdminProfileMobile(
        profileData: data,
      ));
    } else {
      return TemplateDesktop(
          faqmenu: false,
          faqmenuadmin: false,
          helpdesk: false,
          helpdeskadmin: false,
          home: false,
          useTemplatescroll: false,
          content: Column(
            children: [
              UserProfileHeader.widget(context),
              UserProfileCard.widget(context, data)
            ],
          ));
    }
  }
}
