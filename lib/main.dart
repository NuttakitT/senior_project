import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:senior_project/help_desk/help_desk_main/view/page/help_desk_main_view.dart';
import 'package:senior_project/help_desk/help_desk_reply/view_model/reply_channel_view_model.dart';
import 'package:senior_project/core/template_desktop/view_model/template_desktop_view_model.dart';
import 'package:senior_project/core/view_model/app_view_model.dart';
import 'package:senior_project/role_management/view/role_management_view.dart';
import 'package:senior_project/role_management/view_model/role_management_view_model.dart';
import 'package:senior_project/teacher_contact/view/teacher_contact_view.dart';
import 'package:senior_project/teacher_contact/view_model/teacher_contact_view_model.dart';
import 'core/template_mobile/view_model/template_mobile_view_model.dart';
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
        ChangeNotifierProvider(create: (context) => RoleManagementViewModel()),
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
      title: 'CPE Services',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FutureBuilder(
          future: context.read<AppViewModel>().initializeLoginState(context,
              !(FirebaseAuth.instance.currentUser == null)),
          builder: (context, _) {
            if (_.connectionState == ConnectionState.done) {
              return HelpDeskMainView(isAdmin: context.watch<AppViewModel>().app.getUser.getRole == 0);
            }
            return Container();
          }),
    );
  }
}
