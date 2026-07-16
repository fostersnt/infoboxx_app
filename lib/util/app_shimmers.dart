import 'package:flutter/material.dart';
import 'package:infoboxx/util/app_colors.dart';
import 'package:shimmer_animation_kit/shimmer_animation_kit.dart';

class AppShimmers {

  static Widget textShimmer(double width, double height)
  {
    return ShimmerTextWidget(
      direction: ShimmerDirection.leftToRight,
      highlightColor: AppColors.redCrimson,
      baseColor: AppColors.whitePure,
      width: width,
    );
  }

  static Widget circleShimmer(double diameter, double height)
  {
    return ShimmerCircleWidget(
      diameter: diameter,
      baseColor: AppColors.whitePure,
      highlightColor: AppColors.grayLightSilver,
    );
  }
}