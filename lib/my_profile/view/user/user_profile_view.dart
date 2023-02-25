import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senior_project/core/template_mobile/view/template_menu_mobile.dart';
import 'package:senior_project/my_profile/view/user/widget/user_profile_card.dart';
import 'package:senior_project/my_profile/view/user/widget/user_profile_edit_button_bar.dart';
import 'package:senior_project/my_profile/view/user/widget/user_profile_header.dart';
import 'package:senior_project/core/template_desktop/view/page/template_desktop.dart';
import 'package:senior_project/my_profile/view/user/widget/user_profile_mobile.dart';
import '../../../core/view_model/app_view_model.dart';

class UserProfileView extends StatelessWidget {
  final Map<String, dynamic> data;
  const UserProfileView({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    context.read<AppViewModel>().selectView(MediaQuery.of(context).size.width);
    bool isMobileSite = context.watch<AppViewModel>().getMobileSiteState;
    bool isCurrentlyEditData = false;

    if (isMobileSite) {
      return TemplateMenuMobile(
          content: UserProfileMobile(
        profileData: data,
        isCurrentlyEditData: isCurrentlyEditData,
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
              UserProfileCard.widget(context, data, isCurrentlyEditData),
              UserProfileEditButtonBar(
                didTapCancel: (p0) {},
                didTapSaveChange: (p0) {},
              )
            ],
          ));
    }
  }
}
