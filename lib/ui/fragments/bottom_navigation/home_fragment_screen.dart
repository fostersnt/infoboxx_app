import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:infoboxx/services/app/user_service.dart';
import 'package:infoboxx/ui/cards/greeting_card.dart';
import 'package:infoboxx/ui/cards/leads_count_card.dart';
import 'package:infoboxx/ui/components/custom_refresh_indicator.dart';
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

    String currentDate = GeneralFunctions.getFormatedDate();

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
            child: CustomRefreshIndicator(
              onRefresh: () async {
                await userService.getLeads();
              },
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                // padding: EdgeInsets.fromLTRB(0, 10, 0, 30),
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 20, 10, 20),
                      child: Row(
                        // mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: const Color(0xFFFBC31B).withOpacity(0.12),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Icon(
                              Icons.calendar_today_rounded,
                              color: Color(0xFFFBC31B),
                              size: 18,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            currentDate,
                            style: TextStyle(
                              color: AppColors.blackCharcoal,
                              fontSize: 15,
                              // fontWeight: FontWeight.w600,
                              letterSpacing: -0.2,
                            ),
                          ),
                        ],
                      ),
                    ),
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
      ),
    );
  }
}
