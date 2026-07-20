import 'package:flutter/material.dart';
import 'package:infoboxx/util/app_colors.dart';

class CustomRefreshIndicator extends StatelessWidget {
  final Future<void> Function() onRefresh;
  final Widget child;

  const CustomRefreshIndicator({
    super.key,
    required this.onRefresh,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      color: AppColors.yellowAmber, // Your accent yellow
      backgroundColor: AppColors.blackCharcoal,
      onRefresh: onRefresh,
      child: child,
    );
  }
}