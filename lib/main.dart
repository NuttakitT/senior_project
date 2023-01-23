import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:senior_project/core/view_model/mobile_state_view_model.dart';
import 'package:senior_project/user_authentication/login_register_page/view/page/authentication_page.dart';
import 'package:senior_project/user_authentication/login_register_page/view_model/page_view_model.dart';
import 'package:senior_project/user_authentication/login_register_page/view_model/register_view_model.dart';
import 'package:senior_project/user_authentication/role_selection_page/view_model/role_selection_view_model.dart';
import 'firebase_options.dart';

void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => RegisterViewModel()),
        ChangeNotifierProvider(create: (context) => PageViewModel()),
        ChangeNotifierProvider(create: (context) => MobileStateViewModel()),
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
      home: const Scaffold(
        body: AuthenticationPage(),
      ),
    );
  }
}