import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
// * Testing database
import 'package:cloud_firestore/cloud_firestore.dart';

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
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
          // * Testing database
          child: FutureBuilder(
            future: FirebaseFirestore.instance.collection("dummy").get(),
            builder: ((context, snapshot) {
              if (snapshot.hasError) {
                return Text("Error occur: ${snapshot.error}");
              }
              if (snapshot.connectionState == ConnectionState.done) {
                String text = snapshot.data?.docs.first.get("dummy_field");
                return Text("Test successed, qurey text: $text");
              }
              return Text("Connection state: ${snapshot.connectionState}");
            }),
          ),
        ));
  }
}
