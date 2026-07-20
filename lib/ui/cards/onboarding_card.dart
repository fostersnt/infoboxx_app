import 'package:flutter/material.dart';
import 'package:infoboxx/util/app_colors.dart';

class OnboardingCard extends StatelessWidget {
  final String name;
  final bool completed;
  final IconData icon;
  final Widget miniText;

  const OnboardingCard({
    super.key,
    required this.name,
    required this.completed,
    this.icon = Icons.rocket_launch_rounded,
    required this.miniText,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedScale(
      duration: const Duration(milliseconds: 250),
      scale: completed ? 1.02 : 1,
      curve: Curves.easeOut,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          gradient: LinearGradient(
            colors: completed
                ? [
              Color(0xff059669),
              // Color(0xff10B981),
              AppColors.whitePure
            ]
                : [
              // AppColors.blackCharcoal,
              // AppColors.yellowMustard.withOpacity(.85),
              // Color(0xffF59E0B),
              AppColors.blackCharcoal,
              AppColors.whitePure,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          border: Border.all(
            color: completed
                ? AppColors.greenVibrantEmerald.withOpacity(0.6)
                : Colors.transparent,
            width: 1.5,
          ),
          // boxShadow: [
          //   BoxShadow(
          //     color: completed
          //         ? AppColors.blackGunMetal.withOpacity(.45)
          //         : Colors.black26,
          //     blurRadius: completed ? 0.5 : 0.5,
          //     spreadRadius: completed ? 2 : 0,
          //     offset: const Offset(0, 10),
          //   ),
          // ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(24),
            onTap: () => completed,
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
                        completed ? .30 : .18,
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
                          opacity: completed ? 1 : .75,
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

                  //Checked circle
                  Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      color: AppColors.whitePure,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Icon(
                       completed ? Icons.check_rounded : Icons.question_mark,
                        color: completed ? AppColors.greenVibrantEmerald : AppColors.grayCoolSlate,
                        size: 40 * 0.65, // Scales proportionally with size
                      ),
                    ),
                  )

                  /// Animated Check
                  // AnimatedContainer(
                  //   duration:
                  //   const Duration(milliseconds: 250),
                  //   height: 34,
                  //   width: 34,
                  //   decoration: BoxDecoration(
                  //     shape: BoxShape.circle,
                  //     color: selected
                  //         ? Colors.white
                  //         : Colors.transparent,
                  //     border: Border.all(
                  //       color: Colors.white,
                  //       width: 2,
                  //     ),
                  //   ),
                  //   child: AnimatedSwitcher(
                  //     duration:
                  //     const Duration(milliseconds: 200),
                  //     transitionBuilder:
                  //         (child, animation) =>
                  //         ScaleTransition(
                  //           scale: animation,
                  //           child: child,
                  //         ),
                  //     child: selected
                  //         ? Icon(
                  //       Icons.check,
                  //       key: const ValueKey(true),
                  //       color: AppColors.blackCharcoal,
                  //       size: 20,
                  //     )
                  //         : const SizedBox(
                  //       key: ValueKey(false),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}