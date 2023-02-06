import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:senior_project/core/template_desktop/view/page/template_desktop.dart';
import 'package:senior_project/core/template_desktop/view_model/template_desktop_view_model.dart';
import 'package:senior_project/core/template_mobile/view/template_menu_mobile.dart';
import 'package:senior_project/core/view_model/app_view_model.dart';
import 'package:senior_project/user_authentication/login_register_page/view_model/authentication_view_model.dart';
import 'package:senior_project/user_authentication/role_selection_page/view_model/role_selection_view_model.dart';
import 'core/template_mobile/view/view_model/template_mobile_view_model.dart';
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
      home: const TemplateMenuMobile(content: Text("test"))
    );
  }
}
