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

    double marginControl = 9;

    double boxWidth = (deviceWidth / 3);
    double boxHeight = deviceWidth / 3 + 50;

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          SystemNavigator.pop();
        }
      },
      child: ShimmerScope(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Expanded(child: AppShimmers.boxShimmer(boxWidth, boxHeight)),
                    Expanded(child: AppShimmers.textShimmer(boxWidth))
                  ],
                ),
                Column(
                  children: [
                    Expanded(child: AppShimmers.boxShimmer(boxWidth, boxHeight)),
                    Expanded(child: AppShimmers.textShimmer(boxWidth))
                  ],
                ),
                Column(
                  children: [
                    Expanded(child: AppShimmers.boxShimmer(boxWidth, boxHeight)),
                    Expanded(child: AppShimmers.textShimmer(boxWidth))
                  ],
                ),
                // Expanded(child: AppShimmers.boxShimmer(boxWidth, boxHeight)),
                // Expanded(child: AppShimmers.boxShimmer(boxWidth, boxHeight)),
              ],
            ),

            SizedBox(height: 10),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(child: AppShimmers.boxShimmer(boxWidth, boxHeight)),
                Expanded(child: AppShimmers.boxShimmer(boxWidth, boxHeight)),
                Expanded(child: AppShimmers.boxShimmer(boxWidth, boxHeight)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
