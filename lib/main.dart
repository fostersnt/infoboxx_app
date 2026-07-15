import 'package:flutter/material.dart';
import 'package:infoboxx/ui/auth/login_screen.dart';
import 'package:infoboxx/ui/fragments/bottom_navigation/dashboard_fragment_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      ),
      home: LoginScreen()
    );
  }
}
