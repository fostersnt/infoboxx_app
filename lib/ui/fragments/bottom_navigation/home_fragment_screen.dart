import 'package:flutter/material.dart';
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
    return ShimmerScope(
      child: Row(
        children: [
          Expanded(
            child: AppShimmers.circleShimmer(200, 200),
          ),
          // const SizedBox(width: 12),
          // Expanded(
          //   child: ShimmerBox(
          //     width: 150,
          //     height: 150,
          //     borderRadius: BorderRadius.circular(16),
          //   ),
          // ),
          // const SizedBox(width: 12),
          // // Expanded(child: ShimmerTextWidget(lines: 2, width: 140)),
        ],
      ),
    );
    // return UserCard();
    // return ShimmerScope(
    //   child: Scaffold(
    //     appBar: AppBar(title: const Text("Users")),
    //     body: Obx(
    //       () => ShimmerKit(isLoading: _isLoading.value, child: UserCard()),
    //     ),
    //   ),
    // );
  }
}

class UserCard extends StatelessWidget {
  const UserCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            CircleAvatar(radius: 30, backgroundColor: AppColors.redCrimson),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "John Doe",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.yellowColor,
                  ),
                ),
                SizedBox(height: 8),
                Text("Software Engineer"),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
