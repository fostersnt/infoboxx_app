import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:infoboxx/services/app/user_service.dart';
import 'package:infoboxx/util/app_colors.dart';
import 'package:infoboxx/util/app_shimmers.dart';
import 'package:infoboxx/util/general_functions.dart';
import 'package:shimmer_animation_kit/shimmer_animation_kit.dart';

class HomeFragmentScreen extends StatelessWidget {
  HomeFragmentScreen({super.key});

  final userService = Get.find<UserService>();

  // Reactive loading state tracker
  final RxBool _isLoading = true.obs;
  final bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;

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
                  Container(
                    margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
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
                            width: 160,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(Icons.group_add, color: AppColors.yellowAmber,),
                                SizedBox(width: 10,),
                                Expanded(
                                  child: Text(
                                    "LEAD OVERVIEW",
                                    style: TextStyle(color: AppColors.yellowAmber),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 30),
                        Text(
                          "Good Afternoon, Gwo Sevo",
                          style: TextStyle(
                            color: AppColors.whitePure,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          "Stay on top of new enquiries and outreach",
                          style: TextStyle(
                            color: AppColors.yellowAmber,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
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
