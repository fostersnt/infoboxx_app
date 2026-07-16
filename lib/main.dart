import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infoboxx/ui/auth/login_screen.dart';
import 'package:infoboxx/ui/fragments/bottom_navigation/dashboard_fragment_screen.dart';
import 'package:flutter_loading_animation_kit/flutter_loading_animation_kit.dart';
import 'package:infoboxx/ui/fragments/bottom_navigation/home_fragment_screen.dart';
import 'package:infoboxx/util/app_loaders.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // return GetMaterialApp(
    //   debugShowCheckedModeBanner: false,
    //   theme: ThemeData(
    //     colorScheme: .fromSeed(seedColor: Colors.deepPurple),
    //   ),
    //   home: LoginScreen()
    // );
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeFragmentScreen(),
    );
  }
}
