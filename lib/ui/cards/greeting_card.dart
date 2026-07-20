import 'package:flutter/material.dart';
import 'package:infoboxx/util/app_colors.dart';

class GreetingCard extends StatelessWidget {
  final String name;
  final bool selected;
  final ValueChanged<bool> onChanged;
  final IconData icon;

  const GreetingCard({
    super.key,
    required this.name,
    required this.selected,
    required this.onChanged,
    this.icon = Icons.waving_hand_rounded,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedScale(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeOut,
      scale: selected ? 1.02 : 1,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeOut,
        margin: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          // borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: selected
                ? AppColors.yellowMustard
                : Colors.grey.shade200,
            width: 1.3,
          ),
          boxShadow: [
            BoxShadow(
              color: selected
                  ? AppColors.yellowMustard.withOpacity(.25)
                  : Colors.black.withOpacity(.05),
              blurRadius: selected ? 20 : 10,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(24),
          onTap: () => onChanged(!selected),
          child: Row(
            children: [

              /// Yellow Accent
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: 7,
                height: 115,
                decoration: BoxDecoration(
                  color: AppColors.yellowMustard,
                  borderRadius: const BorderRadius.horizontal(
                    left: Radius.circular(24),
                  ),
                ),
              ),

              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(18),
                  child: Row(
                    children: [

                      /// Icon
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        height: 62,
                        width: 62,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: selected
                              ? AppColors.yellowMustard
                              : AppColors.yellowMustard
                              .withOpacity(.15),
                        ),
                        child: Icon(
                          icon,
                          color: selected
                              ? Colors.white
                              : AppColors.yellowMustard,
                          size: 32,
                        ),
                      ),

                      const SizedBox(width: 18),

                      /// Text
                      Expanded(
                        child: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          mainAxisAlignment:
                          MainAxisAlignment.center,
                          children: [

                            Text(
                              name,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: AppColors.blackCharcoal,
                              ),
                            ),

                            const SizedBox(height: 6),

                            Text(
                              "Welcome back! Let's make today productive.",
                              style: TextStyle(
                                color: Colors.grey.shade600,
                                fontSize: 14,
                              ),
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
                              ? Colors.green
                              : Colors.transparent,
                          border: Border.all(
                            color: selected
                                ? Colors.green
                                : Colors.grey.shade400,
                            width: 2,
                          ),
                        ),
                        child: AnimatedSwitcher(
                          duration: const Duration(
                              milliseconds: 250),
                          transitionBuilder:
                              (child, animation) =>
                              ScaleTransition(
                                scale: animation,
                                child: child,
                              ),
                          child: selected
                              ? const Icon(
                            Icons.check,
                            key: ValueKey(1),
                            color: Colors.white,
                            size: 20,
                          )
                              : const SizedBox(
                            key: ValueKey(0),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}