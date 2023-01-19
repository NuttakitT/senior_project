import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:senior_project/user_authentication/login_register_page/view/page/authentication_page.dart';
import 'package:senior_project/user_authentication/role_selection_page/view/page/role_selection_page.dart';
import 'firebase_options.dart';
// * test ceck web on desktop/mobile size
// * import 'package:flutter/foundation.dart';

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
    // * test ceck web on desktop/mobile size
    // * final isWebMobile = kIsWeb && (defaultTargetPlatform == TargetPlatform.iOS || defaultTargetPlatform == TargetPlatform.android); 
    // * print("log: web is on mobile /$isWebMobile/ ");

    return MaterialApp(
      title: 'Test',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Scaffold(
        body: RoleSelectionPage(),
      ),
    );
  }
}