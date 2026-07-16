import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infoboxx/ui/auth/login_screen.dart';
import 'package:infoboxx/ui/fragments/bottom_navigation/dashboard_fragment_screen.dart';
import 'package:flutter_loading_animation_kit/flutter_loading_animation_kit.dart';
import 'package:infoboxx/util/app_loaders.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      // title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      ),
      // home: LoginScreen()
      home: Center(
        child: AppLoaders.fourCirclePulse(),
      ),
    );
  }
}
