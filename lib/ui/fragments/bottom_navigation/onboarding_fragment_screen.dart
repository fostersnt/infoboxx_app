import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:infoboxx/services/app/user_service.dart';
import 'package:infoboxx/ui/cards/onboarding_card.dart';
import 'package:infoboxx/ui/cards/onboarding_summary_card.dart';
import 'package:infoboxx/util/app_colors.dart';
import 'package:infoboxx/util/general_functions.dart';

class OnboardingFragmentScreen extends StatelessWidget {
  OnboardingFragmentScreen({super.key});

  final userService = Get.find<UserService>();
  final bool isCompleted_1 = false;
  final bool isCompleted_2 = true;
  final bool isCompleted_3 = false;
  // final RxBool isCompleted_identity = false.obs;
  // final RxBool isCompleted_identity = false.obs;

  String status_1 = "";
  String status_2 = "";
  String status_3 = "";

  @override
  Widget build(BuildContext context) {
    String companyName =
        userService.userData.value["service_provider"]["company_name"] ?? "N/A";

    status_1 = isCompleted_1 == true ? status_1 = "COMPLETED" : "PENDING";
    status_2 = isCompleted_2 == true ? status_2 = "COMPLETED" : "PENDING";
    status_3 = isCompleted_3 == true ? status_3 = "COMPLETED" : "PENDING";

    return Scaffold(
      // backgroundColor: AppColors.whitePure,
      appBar: AppBar(
        // title: const Text("Onboarding"),
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
              Container(
                margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
                child: OnboardingSummaryCard(
                  completionRate: 0.75, // 75% completed
                  approvalStatus:
                      "UNDER_REVIEW", // PENDING, APPROVED, REJECTED, etc.
                  completedSteps: 3,
                  totalSteps: 4,
                  onTapContinue: () {
                    // Navigate to remaining onboarding screens/steps
                  },
                ),
              ),
              OnboardingCard(
                    name: "Identity Verification",
                    completed: isCompleted_1,
                    icon: Icons.verified_user,
                    miniText: GeneralFunctions.getOnboardingStatusText(isCompleted: isCompleted_1),
                  )
                  .animate()
                  .fade(duration: 400.ms)
                  .slideY(begin: .25)
                  .scale(begin: const Offset(.95, .95)),
              OnboardingCard(
                    name: "Business Documents",
                    completed: isCompleted_2,
                    icon: Icons.edit_document,
                    miniText: GeneralFunctions.getOnboardingStatusText(isCompleted: isCompleted_2),
                  )
                  .animate()
                  .fade(duration: 400.ms)
                  .slideY(begin: .25)
                  .scale(begin: const Offset(.95, .95)),

              OnboardingCard(
                    name: "Contact Persons",
                    completed: isCompleted_3,
                    icon: Icons.contact_phone,
                    miniText: GeneralFunctions.getOnboardingStatusText(isCompleted: isCompleted_3),
                  )
                  .animate()
                  .fade(duration: 400.ms)
                  .slideY(begin: .25)
                  .scale(begin: const Offset(.95, .95)),
            ],
          ),
        ),
      ),
    );
  }
}
