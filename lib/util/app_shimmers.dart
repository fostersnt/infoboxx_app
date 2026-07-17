import 'package:flutter/material.dart';
import 'package:infoboxx/util/app_colors.dart';
import 'package:shimmer_animation_kit/shimmer_animation_kit.dart';

class AppShimmers {
  static Widget textShimmer(double width, double height) {
    return ShimmerTextWidget(
      direction: ShimmerDirection.leftToRight,
      highlightColor: AppColors.redCrimson,
      baseColor: AppColors.whitePure,
      width: width,
    );
  }

  static Widget circleShimmer(double diameter) {
    return ShimmerCircleWidget(
      diameter: diameter,
      baseColor: AppColors.whitePure,
      highlightColor: AppColors.grayLightSilver,
    );
  }

  static Widget boxShimmer(double width, double height) {
    return ShimmerBox(
      width: width,
      height: height,
      baseColor: AppColors.whitePure,
      highlightColor: AppColors.grayLightSilver,
    );
  }

  static Widget listShimmer(int itemCount, var items) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        return ListTile(title: Text(items[index].title));
      },
    );
  }
}
