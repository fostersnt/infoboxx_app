import 'package:flutter/material.dart';
import 'package:infoboxx/util/app_colors.dart';

class OnboardingCard extends StatelessWidget {
  final String name;
  final bool selected;
  final IconData icon;
  final Widget miniText;

  const OnboardingCard({
    super.key,
    required this.name,
    required this.selected,
    this.icon = Icons.rocket_launch_rounded,
    required this.miniText,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedScale(
      duration: const Duration(milliseconds: 250),
      scale: selected ? 1.02 : 1,
      curve: Curves.easeOut,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          gradient: LinearGradient(
            colors: selected
                ? [
              Color(0xff059669),
              Color(0xff10B981),
            ]
                : [
              // AppColors.blackCharcoal,
              // AppColors.yellowMustard.withOpacity(.85),
              // Color(0xffF59E0B),
              AppColors.blackCharcoal,
              AppColors.orangeMain,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          border: Border.all(
            color: selected
                ? Colors.white.withOpacity(.6)
                : Colors.transparent,
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: selected
                  ? AppColors.blackGunMetal.withOpacity(.45)
                  : Colors.black26,
              blurRadius: selected ? 0.5 : 0.5,
              spreadRadius: selected ? 2 : 0,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(24),
            onTap: () => selected,
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Row(
                children: [

                  /// Icon
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    height: 68,
                    width: 68,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withOpacity(
                        selected ? .30 : .18,
                      ),
                    ),
                    child: Icon(
                      icon,
                      size: 34,
                      color: Colors.white,
                    ),
                  ),

                  const SizedBox(width: 18),

                  /// Text
                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      children: [

                        Text(
                          name,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          ),
                        ),

                        const SizedBox(height: 5),

                        AnimatedOpacity(
                          duration:
                          const Duration(milliseconds: 250),
                          opacity: selected ? 1 : .75,
                          child: miniText,
                          // child: const Text(
                          //   "Tap to onboard",
                          //   style: TextStyle(
                          //     color: Colors.white70,
                          //     fontSize: 13,
                          //   ),
                          // ),
                        ),
                      ],
                    ),
                  ),

                  /// Animated Check
                  AnimatedContainer(
                    duration:
                    const Duration(milliseconds: 250),
                    height: 34,
                    width: 34,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: selected
                          ? Colors.white
                          : Colors.transparent,
                      border: Border.all(
                        color: Colors.white,
                        width: 2,
                      ),
                    ),
                    child: AnimatedSwitcher(
                      duration:
                      const Duration(milliseconds: 200),
                      transitionBuilder:
                          (child, animation) =>
                          ScaleTransition(
                            scale: animation,
                            child: child,
                          ),
                      child: selected
                          ? Icon(
                        Icons.check,
                        key: const ValueKey(true),
                        color: AppColors.blackCharcoal,
                        size: 20,
                      )
                          : const SizedBox(
                        key: ValueKey(false),
                      ),
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