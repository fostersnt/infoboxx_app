import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:infoboxx/services/app/user_service.dart';
import 'package:infoboxx/ui/cards/onboarding_card.dart';
import 'package:infoboxx/util/app_colors.dart';

class OnboardingFragmentScreen extends StatelessWidget {
  OnboardingFragmentScreen({super.key});

  final userService = Get.find<UserService>();
  final RxBool isSelected_identity_verification = false.obs;
  final RxBool isSelected_business_document = true.obs;
  final RxBool isSelected_contact_persons = false.obs;
  // final RxBool isSelected_identity = false.obs;
  // final RxBool isSelected_identity = false.obs;

  @override
  Widget build(BuildContext context) {
    String companyName =
        userService.userData.value["service_provider"]["company_name"] ?? "N/A";
    return Scaffold(
      // backgroundColor: AppColors.whitePure,
      appBar: AppBar(
        title: const Text("Onboarding"),
        backgroundColor: AppColors.whitePure,
        elevation: 0,
        // flexibleSpace: Container(
        //   decoration: const BoxDecoration(
        //     gradient: LinearGradient(
        //       colors: [
        //         AppColors.whitePure,
        //         AppColors.blackCharcoal, // Blue
        //       ],
        //       begin: Alignment.topLeft,
        //       end: Alignment.bottomRight,
        //     ),
        //   ),
        // ),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: AppColors.whitePure,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Obx(
                () =>
                    OnboardingCard(
                          name: "Identity Verification",
                          selected: isSelected_identity_verification.value,
                          icon: Icons.verified_user,
                          onChanged: (value) {
                            // isSelected_identity_verification.value = !isSelected_identity_verification.value;
                          },
                        )
                        .animate()
                        .fade(duration: 400.ms)
                        .slideY(begin: .25)
                        .scale(begin: const Offset(.95, .95)),
              ),
              Obx(
                () =>
                    OnboardingCard(
                          name: "Business Documents",
                          selected: isSelected_business_document.value,
                          icon: Icons.edit_document,
                          onChanged: (value) {
                            // isSelected_business_document.value = !isSelected_business_document.value;
                          },
                        )
                        .animate()
                        .fade(duration: 400.ms)
                        .slideY(begin: .25)
                        .scale(begin: const Offset(.95, .95)),
              ),
              Obx(
                () =>
                    OnboardingCard(
                          name: "Contact Persons",
                          selected: isSelected_contact_persons.value,
                          icon: Icons.contact_phone,
                          onChanged: (value) {
                            // isSelected_contact_persons.value = !isSelected_contact_persons.value;
                          },
                        )
                        .animate()
                        .fade(duration: 400.ms)
                        .slideY(begin: .25)
                        .scale(begin: const Offset(.95, .95)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
