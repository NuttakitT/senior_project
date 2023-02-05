import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:senior_project/core/template_desktop/view/page/template_desktop.dart';
import 'package:senior_project/core/template_desktop/view/widget/desktop/template_navbar.dart';
import 'package:senior_project/core/template_desktop/view/widget/desktop/template_tagbar_faq.dart';
import 'package:senior_project/core/template_desktop/view/widget/desktop/template_tagbar_faq_admin.dart';
import 'package:senior_project/core/template_desktop/view/widget/desktop/template_tagbar_help_desk.dart';
import 'package:senior_project/core/template_desktop/view/widget/desktop/template_tagbar_help_desk_admin.dart';
import 'package:senior_project/core/template_desktop/view/widget/desktop/template_tagbar_home.dart';
import 'package:senior_project/core/template_mobile/view/template_menu_mobile.dart';
import 'package:senior_project/core/view_model/app_view_model.dart';
import 'package:senior_project/help_desk/help_desk_main/view/page/help_desk_main_view.dart';
import 'package:senior_project/user_authentication/login_register_page/view/page/authentication_page.dart';
import 'package:senior_project/user_authentication/login_register_page/view_model/authentication_view_model.dart';
import 'package:senior_project/user_authentication/role_selection_page/view_model/role_selection_view_model.dart';
import 'firebase_options.dart';

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
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Test',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: const TemplateMenuMobile(
      //   content: Text("data"),
      // )
      home: HelpDeskMainView(key: key),
    );
  }
}
