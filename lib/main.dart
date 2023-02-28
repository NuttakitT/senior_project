import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:senior_project/core/template_community_board/view/desktop/page/template_community_board_desktop.dart';
import 'package:senior_project/core/template_community_board/view/mobile/page/template_community_board_mobile.dart';
import 'package:senior_project/core/template_community_board/view/mobile/widget/community_content_mobile.dart';
import 'package:senior_project/core/template_desktop/view/page/template_desktop.dart';
import 'package:senior_project/help_desk/help_desk_main/view/page/help_desk_main_view.dart';
import 'package:senior_project/help_desk/help_desk_reply/mobile/view/widget/description_mobile.dart';
import 'package:senior_project/help_desk/help_desk_reply/desktop/view/page/help_desk_reply_desktop.dart';
import 'package:senior_project/help_desk/help_desk_reply/mobile/view/page/help_desk_reply_mobile.dart';
import 'package:senior_project/my_profile/view/my_profile_view.dart';
import 'package:senior_project/core/template_desktop/view_model/template_desktop_view_model.dart';
import 'package:senior_project/core/view_model/app_view_model.dart';
import 'package:senior_project/teacher_contact/view/teacher_contact_view.dart';
import 'package:senior_project/user_authentication/login_register_page/view_model/authentication_view_model.dart';
import 'package:senior_project/user_authentication/role_selection_page/view_model/role_selection_view_model.dart';
import 'core/template_mobile/view_model/template_mobile_view_model.dart';
import 'firebase_options.dart';
import 'help_desk/help_desk_main/view_model/help_desk_view_model.dart';

void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthenticationViewModel()),
        ChangeNotifierProvider(create: (context) => AppViewModel()),
        ChangeNotifierProvider(create: (context) => RoleSelectionViewModel()),
        ChangeNotifierProvider(create: (context) => HelpDeskViewModel()),
        ChangeNotifierProvider(create: (context) => TemplateDesktopViewModel()),
        ChangeNotifierProvider(create: (context) => TemplateMobileViewModel()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    if (FirebaseAuth.instance.currentUser != null) {
      context.read<AppViewModel>().initializeLoginState(true);
    } else {
      context.read<AppViewModel>().initializeLoginState(false);
    }

    return MaterialApp(
        title: 'Test',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const TemplateCommunityBoardDesktop());
  }
}
