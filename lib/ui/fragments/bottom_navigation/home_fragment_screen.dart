import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:infoboxx/services/app/user_service.dart';
import 'package:infoboxx/ui/cards/announcement_carousel_card.dart';
import 'package:infoboxx/ui/cards/greeting_card.dart';
import 'package:infoboxx/ui/cards/leads_count_card.dart';
import 'package:infoboxx/ui/cards/onboarding_summary_card.dart';
import 'package:infoboxx/ui/components/custom_refresh_indicator.dart';
import 'package:infoboxx/ui/components/monthly_converted_leads_chart.dart';
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

  final List<Map<String, dynamic>> announcements = [
    {
      "title": "Announcement 1",
      "type": "leads",
      "message": "Hello world",
      "dateText": "2026-06-30 14:15:10",
    },
    {
      "title": "Announcement 2",
      "type": "system",
      "message": "This is system maintenance",
      "dateText": "2026-06-30 14:15:10",
    },
  ];

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
      child: Container(
        color: AppColors.whitePure,
        width: double.infinity,
        child: ShimmerScope(
          child: SizedBox(
            width: deviceWidth,
            child: CustomRefreshIndicator(
              onRefresh: () async {
                await userService.getLeads(forceRefresh: true);
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
                    // GreetingCard(
                    //       name: "Greetings",
                    //       selected: isSelected.value,
                    //       onChanged: (val) {
                    //         if (val != null) {
                    //           isSelected.value = !isSelected.value;
                    //         }
                    //       },
                    //     )
                    //     .animate()
                    //     .fade(duration: 400.ms)
                    //     .slideY(begin: .25)
                    //     .scale(begin: const Offset(.95, .95)),
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
                    // SizedBox(
                    //   width: deviceWidth,
                    //   height: 230,
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    //     children: [
                    //       Column(
                    //         children: [
                    //           AppShimmers.boxShimmer(boxWidth, boxHeight),
                    //           SizedBox(height: 10),
                    //           AppShimmers.textShimmer(boxWidth),
                    //         ],
                    //       ),
                    //       Column(
                    //         children: [
                    //           AppShimmers.boxShimmer(boxWidth, boxHeight),
                    //           SizedBox(height: 10),
                    //           AppShimmers.textShimmer(boxWidth),
                    //         ],
                    //       ),
                    //       Column(
                    //         children: [
                    //           AppShimmers.boxShimmer(boxWidth, boxHeight),
                    //           SizedBox(height: 10),
                    //           AppShimmers.textShimmer(boxWidth),
                    //         ],
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 10,
                      ),
                      child: Obx(
                        () => MonthlyConvertedLeadsChart(
                          monthlyData: userService.getMonthlyConvertedLeads(),
                        ),
                      ),
                    ),
                    Container(
                      // height: 140, 2peter 1:21
                      // 0547555587
                      // padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                      color: AppColors.whitePure,
                      margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                      height: 150,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: announcements.length,
                        itemBuilder: (BuildContext context, int index) {
                          // return ListTile(title: Text('Item $index'));
                          return AnnouncementCarouselCard(
                            title: announcements[index]["title"],
                            type: announcements[index]["type"],
                            message: announcements[index]["message"],
                            dateText: announcements[index]["dateText"],
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 20),
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
