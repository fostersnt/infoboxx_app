import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:infoboxx/util/app_colors.dart';
import 'package:infoboxx/util/app_shimmers.dart';
import 'package:shimmer_animation_kit/shimmer_animation_kit.dart';

class HomeFragmentScreen extends StatelessWidget {
  HomeFragmentScreen({super.key});

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
                    decoration: BoxDecoration(
                      color: AppColors.blackCharcoal,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    width: deviceWidth,
                    height: 300,
                    child: Column(
                      children: [

                      ],
                    ),
                  ),
                  SizedBox(height: 10,),
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

