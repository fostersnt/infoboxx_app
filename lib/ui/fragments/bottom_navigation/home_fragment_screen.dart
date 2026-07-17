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
      child: Container(
        color: AppColors.whitePure,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Row(
          children: [
            Expanded(
              child: AppShimmers.circleShimmer(200),
            ),
          ],
        ),
      ),
    );
  }
}