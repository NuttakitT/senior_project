import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:senior_project/user_authentication/login_page/view/desktop/widget/registration_widget_desktop.dart';
import 'package:senior_project/user_authentication/role_selection_page/view/desktop/page/role_selection_page_desktop.dart';
import 'firebase_options.dart';

void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
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
        body: Center(
          child: RoleSelectionPage()
        ),
      ),
    );
  }
}