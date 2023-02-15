import 'package:flutter/material.dart';
import 'package:senior_project/core/my_profile/view/user/user_profile_view.dart';

class MyProfileView extends StatelessWidget {
  final bool isAdmin;
  MyProfileView({super.key, required this.isAdmin});

  final Map<String, dynamic> data = {
    "imageUrl": "https://picsum.photos/200/300",
    "name": "RunnZazazazazaza",
    "surname": "Siriphuwanich",
    "aboutMe":
        "lkjhgofdsgreewzxcxvvbnm,ertyulkijhgfd ,mnbvctxyhjkygf nbvgcyhxuji g7hb fudjcis hrfuejidwx 8rfheijcnksx fheidcnk ihackzjb m9eqioadhkbczm9iyqdahbcz iwhfscbjkmx ",
    "email": "runn@gmail.com",
    "phone": "0909111111",
    "gender": "Male"
  };

  @override
  Widget build(BuildContext context) {
    if (isAdmin) {
      return Container();
    } else {
      return UserProfileView(data: data);
    }
  }
}
