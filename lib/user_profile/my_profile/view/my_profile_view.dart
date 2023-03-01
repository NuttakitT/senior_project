import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senior_project/core/view_model/app_view_model.dart';
import 'package:senior_project/user_profile/login_register_page/view/page/authentication_page.dart';
import 'package:senior_project/user_profile/my_profile/view/user/user_profile_view.dart';
import 'package:senior_project/user_profile/my_profile/view/user/widget/admin_profile_view.dart';

class MyProfileView extends StatelessWidget {
  MyProfileView({super.key});

  final Map<String, dynamic> data = {
    "imageUrl": "https://picsum.photos/200/300",
    "name": "RunnZazazazazaza",
    "surname": "Siriphuwanich",
    "aboutMe":
        "lkjhgofdsgreewzxcxvvbnm,ertyulkij bowrbvfgiru bofgbrgbvoru botgbrewuofgberwou gboewrgberowuber bougterbugoe boregb eorugbeorugerg b eorgbeouj bo beroj gber ojgber ogjer hgfd ,mnbvctxyhjkygf nbvgcyhxuji g7hb fudjcis hrfuejidwx 8rfheijcnksx fheidcnk ihackzjb m9eqioadhkbczm9iyqdahbcz iwhfscbjkmx ",
    "email": "runnsiriphuwanich@gmail.com",
    "phone": "0909111111",
    "gender": "Male",
    "role": "User"
  };

  final Map<String, dynamic> adminData = {
    "imageUrl": "https://picsum.photos/200/300",
    "name": "Na Yao Yao yao yaoya ",
    "surname": "DDDDDDDD",
    "aboutMe":
        "lkjhgofdsgreewzxcxvvbnm,ertyulkij bowrbvfgiru bofgbrgbvoru botgbrewuofgberwou gboewrgberowuber bougterbugoe boregb eorugbeorugerg b eorgbeouj bo beroj gber ojgber ogjer hgfd ,mnbvctxyhjkygf nbvgcyhxuji g7hb fudjcis hrfuejidwx 8rfheijcnksx fheidcnk ihackzjb m9eqioadhkbczm9iyqdahbcz iwhfscbjkmx ",
    "email": "1234543212345@gmail.com",
    "phone": "0909111111",
    "officeHours": "9.30 - 16.30",
    "role": "Admin"
  };

  @override
  Widget build(BuildContext context) {
    int? role = context.watch<AppViewModel>().app.getUser.getRole; 
    if (!context.watch<AppViewModel>().isLogin) {
      return const AuthenticationPage();
    }
    if (role == 0) {
      return AdminProfileView(data: adminData);
    } else {
      return UserProfileView(data: data);
    }
  }
}
