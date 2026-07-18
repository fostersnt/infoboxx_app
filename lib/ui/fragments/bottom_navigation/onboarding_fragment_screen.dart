import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infoboxx/services/app/user_service.dart';

class OnboardingFragmentScreen extends StatelessWidget {
  OnboardingFragmentScreen({super.key});

  final userService = Get.find<UserService>();

  @override
  Widget build(BuildContext context) {
    String companyName = userService.userData.value["service_provider"]["company_name"] ?? "N/A";
    return Center(
        child: Text("Hi $companyName, welcome to More screen"),
    );
  }
}
