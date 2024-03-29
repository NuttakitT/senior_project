// ignore_for_file: use_build_context_synchronously
import 'dart:js';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:senior_project/approval/view_model/approval_view_model.dart';
import 'package:senior_project/assets/font_style.dart';
import 'package:senior_project/community_board/view/page/community_board_view.dart';
import 'package:senior_project/community_board/view_model/community_board_view_model.dart';
import 'package:senior_project/core/template/template_mobile/view_model/template_mobile_view_model.dart';
import 'package:senior_project/core/view_model/text_search.dart';
import 'package:senior_project/facility/view/facility_view.dart';
import 'package:senior_project/facility/view_model/facility_view_model.dart';
import 'package:senior_project/help_desk/help_desk_reply/view_model/reply_channel_view_model.dart';
import 'package:senior_project/core/template/template_desktop/view_model/template_desktop_view_model.dart';
import 'package:senior_project/core/view_model/app_view_model.dart';
import 'package:senior_project/role_management/view_model/role_management_view_model.dart';
import 'package:senior_project/statistic/view_model/statistic_view_model.dart';
import 'package:senior_project/teacher_contact/view_model/teacher_contact_view_model.dart';
import 'package:senior_project/user_profile/my_profile/view_model/user_profile_view_model.dart';
import 'firebase_options.dart';
import 'help_desk/help_desk_main/view_model/help_desk_view_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AppViewModel()),
        ChangeNotifierProvider(create: (context) => HelpDeskViewModel()),
        ChangeNotifierProvider(create: (context) => TemplateDesktopViewModel()),
        ChangeNotifierProvider(create: (context) => TemplateMobileViewModel()),
        ChangeNotifierProvider(create: (context) => ReplyChannelViewModel()),
        ChangeNotifierProvider(create: (context) => TeacherContactViewModel()),
        ChangeNotifierProvider(create: (context) => CommunityBoardViewModel()),
        ChangeNotifierProvider(create: (context) => RoleManagementViewModel()),
        ChangeNotifierProvider(create: (context) => StatisticViewModel()),
        ChangeNotifierProvider(create: (context) => TextSearch()),
        ChangeNotifierProvider(create: (context) => ApprovalViewModel()),
        ChangeNotifierProvider(create: (context) => UserProfileViewModel()),
        ChangeNotifierProvider(create: (context) => FacilityViewModel())
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Future<void> init(BuildContext context) async {
    await context.read<AppViewModel>().initializeLoginState(
        context, !(FirebaseAuth.instance.currentUser == null));
    await context.read<TemplateDesktopViewModel>().getCategory();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CPE Services',
      theme:
          ThemeData(primarySwatch: Colors.blue, fontFamily: AppFontStyle.font),
      home: FutureBuilder(
          future: init(context),
          builder: (context, _) {
            if (_.connectionState == ConnectionState.done) {
              return const CommunityBoardView();
            }
            return Container();
          }),
    );
  }
}
