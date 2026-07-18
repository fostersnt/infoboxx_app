import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infoboxx/services/app/user_service.dart';
import 'package:infoboxx/ui/cards/onboarding_card.dart';

class OnboardingFragmentScreen extends StatelessWidget {
  OnboardingFragmentScreen({super.key});

  var userService = Get.find<UserService>();
  RxBool isSelected = false.obs;

  @override
  Widget build(BuildContext context) {
    String companyName =
        userService.userData.value["service_provider"]["company_name"] ?? "N/A";
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Obx(
              () => OnboardingCard(
                name: "Identity Verification",
                selected: isSelected.value,
                icon: Icons.verified_user,
                onChanged: (value) {
                  isSelected.value = !isSelected.value;
                },
              ),
            ),
            Obx(
              () => OnboardingCard(
                name: "Business Documents",
                selected: isSelected.value,
                icon: Icons.edit_document,
                onChanged: (value) {
                  isSelected.value = !isSelected.value;
                },
              ),
            ),
            Obx(
              () => OnboardingCard(
                name: "Contact Persons",
                selected: isSelected.value,
                icon: Icons.contact_phone,
                onChanged: (value) {
                  isSelected.value = !isSelected.value;
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
