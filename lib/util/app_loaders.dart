import 'package:flutter/material.dart';
import 'package:flutter_loading_animation_kit/flutter_loading_animation_kit.dart';

class AppLoaders {
  // Brand fallback yellow color if needed elsewhere
  static const Color primaryYellow = Color(0xFFFBC31B);

  /// 1. Returns the FourCirclePulse animation widget
  static Widget fourCirclePulse() {
    return const Center(
      child: FourCirclePulse(),
    );
  }

  /// 2. Returns the YinAndYang animation widget using your active theme's primary color
  static Widget yinAndYang(BuildContext context) {
    return Center(
      child: YinAndYang(
        yangColor: Theme.of(context).colorScheme.primary,
      ),
    );
  }

  /// 3. Returns the RippleRing animation widget
  static Widget rippleRing() {
    return const Center(
      child: RippleRing(),
    );
  }

  /// 4. Returns the LineEllipsis animation widget
  static Widget lineEllipsis() {
    return const Center(
      child: LineEllipsis(),
    );
  }
}