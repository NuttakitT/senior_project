import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senior_project/user_profile/my_profile/view/user/user_profile_view.dart';
import 'package:senior_project/user_profile/my_profile/view/user/widget/admin_profile_view.dart';

import '../../../my_profile/model/user_profile_model.dart';
import '../view_model/user_profile_view_model.dart';

class MyProfileView extends StatefulWidget {
  final bool isAdmin;
  const MyProfileView({super.key, required this.isAdmin});

  @override
  State<MyProfileView> createState() => _MyProfileViewState();
}

class _MyProfileViewState extends State<MyProfileView> {
  @override
  void initState() {
    super.initState();
    context.read<UserProfileViewModel>().currentUserId;
  }

  @override
  Widget build(BuildContext context) {
    final isAdmin = widget.isAdmin;
    final userData = context.select<UserProfileViewModel, UserModel?>(
        (viewModel) => viewModel.user);

    if (userData == null) {
      return const Center(
        child: Text("No results"),
      );
    }

    if (isAdmin) {
      return AdminProfileView(data: userData.toMap());
    } else {
      return UserProfileView(data: userData.toMap());
    }
  }
}

  // final Map<String, dynamic> data = {
  //   "imageUrl": "https://picsum.photos/200/300",
  //   "name": "RunnZazazazazaza",
  //   "surname": "Siriphuwanich",
  //   "aboutMe":
  //       "lkjhgofdsgreewzxcxvvbnm,ertyulkij bowrbvfgiru bofgbrgbvoru botgbrewuofgberwou gboewrgberowuber bougterbugoe boregb eorugbeorugerg b eorgbeouj bo beroj gber ojgber ogjer hgfd ,mnbvctxyhjkygf nbvgcyhxuji g7hb fudjcis hrfuejidwx 8rfheijcnksx fheidcnk ihackzjb m9eqioadhkbczm9iyqdahbcz iwhfscbjkmx ",
  //   "email": "runnsiriphuwanich@gmail.com",
  //   "phone": "0909111111",
  //   "gender": "Male",
  //   "role": "User"
  // };

  // final Map<String, dynamic> adminData = {
  //   "imageUrl": "https://picsum.photos/200/300",
  //   "name": "Na Yao Yao yao yaoya ",
  //   "surname": "DDDDDDDD",
  //   "aboutMe":
  //       "lkjhgofdsgreewzxcxvvbnm,ertyulkij bowrbvfgiru bofgbrgbvoru botgbrewuofgberwou gboewrgberowuber bougterbugoe boregb eorugbeorugerg b eorgbeouj bo beroj gber ojgber ogjer hgfd ,mnbvctxyhjkygf nbvgcyhxuji g7hb fudjcis hrfuejidwx 8rfheijcnksx fheidcnk ihackzjb m9eqioadhkbczm9iyqdahbcz iwhfscbjkmx ",
  //   "email": "1234543212345@gmail.com",
  //   "phone": "0909111111",
  //   "officeHours": "9.30 - 16.30",
  //   "role": "Admin"
  // };