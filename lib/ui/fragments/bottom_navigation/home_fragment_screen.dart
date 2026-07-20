import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:infoboxx/services/app/user_service.dart';
import 'package:infoboxx/ui/cards/greeting_card.dart';
import 'package:infoboxx/ui/cards/leads_count_card.dart';
import 'package:infoboxx/util/app_colors.dart';
import 'package:infoboxx/util/app_shimmers.dart';
import 'package:infoboxx/util/general_functions.dart';
import 'package:shimmer_animation_kit/shimmer_animation_kit.dart';

class HomeFragmentScreen extends StatefulWidget {
  const HomeFragmentScreen({super.key});

  @override
  State<HomeFragmentScreen> createState() => _HomeFragmentScreenState();
}

class _HomeFragmentScreenState extends State<HomeFragmentScreen> {
  final userService = Get.find<UserService>();
  // Reactive loading state tracker
  final RxBool _isLoading = true.obs;
  final bool isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    String token = userService.accessToken.value;
    print(
      "======== LeadStatisticsScreen initState ======= TOKEN == $token ======",
    );
    userService.getLeads();
  }

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;
    RxBool isSelected = false.obs;

    String greeting = GeneralFunctions.getGreeting();
    // var leadStats = userService.leadStatistics();

    var userData = userService.userData.value;
    String companyName = userData["service_provider"]["company_name"] ?? "N/A";

    double verticalHeight = 10;
    double addOnValue = 50;
    double boxWidth = (deviceWidth / 3.5);
    double boxHeight = boxWidth + addOnValue;
    double containerHeight = addOnValue + boxHeight;

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          SystemNavigator.pop();
        }
      },
      child: SizedBox(
        width: double.infinity,
        child: ShimmerScope(
          child: SizedBox(
            width: deviceWidth,
            child: SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(0, 10, 0, 30),
              child: Column(
                children: [
                  GreetingCard(
                        name: "Greetings",
                        selected: isSelected.value,
                        onChanged: (val) {
                          if (val != null) {
                            isSelected.value = !isSelected.value;
                          }
                        },
                      )
                      .animate()
                      .fade(duration: 400.ms)
                      .slideY(begin: .25)
                      .scale(begin: const Offset(.95, .95)),
                  Container(
                    margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                    child: Obx(
                      () => AnimatedLeadCountCard(
                        totalLeads: userService.leads.length,
                        percentageChange: 14.2,
                        onTap: () {
                          // Navigate to lead list or filter view
                        },
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(10, 0, 10, 20),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: AppColors.blackGunMetal,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    width: deviceWidth,
                    // height: 300,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.fromLTRB(16, 5, 16, 5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: BoxBorder.all(
                              width: 1,
                              color: AppColors.yellowAmber,
                            ),
                          ),
                          child: SizedBox(
                            width: 140,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.group_add,
                                  color: AppColors.yellowAmber,
                                ),
                                SizedBox(width: 10),
                                Expanded(
                                  child: Text(
                                    "Lead Overview",
                                    style: TextStyle(
                                      color: AppColors.yellowAmber,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 30),
                        Text(
                          "Good $greeting, $companyName",
                          style: TextStyle(
                            color: AppColors.whitePure,
                            fontSize: 18,
                            // fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          "Stay on top of new enquiries and outreach",
                          style: TextStyle(
                            color: AppColors.yellowAmber,
                            fontSize: 18,
                            // fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 20),
                        Text(
                          GeneralFunctions.getFormatedDate(),
                          style: TextStyle(
                            color: AppColors.grayLight,
                            // fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  SizedBox(
                    width: deviceWidth,
                    height: 230,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            AppShimmers.boxShimmer(boxWidth, boxHeight),
                            SizedBox(height: 10),
                            AppShimmers.textShimmer(boxWidth),
                          ],
                        ),
                        Column(
                          children: [
                            AppShimmers.boxShimmer(boxWidth, boxHeight),
                            SizedBox(height: 10),
                            AppShimmers.textShimmer(boxWidth),
                          ],
                        ),
                        Column(
                          children: [
                            AppShimmers.boxShimmer(boxWidth, boxHeight),
                            SizedBox(height: 10),
                            AppShimmers.textShimmer(boxWidth),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
