import 'package:flutter/material.dart';
import 'package:infoboxx/util/app_colors.dart';

class OnboardingCard extends StatelessWidget {
  final String name;
  final bool selected;
  final ValueChanged<bool?> onChanged;
  final IconData icon;

  const OnboardingCard({
    super.key,
    required this.name,
    required this.selected,
    required this.onChanged,
    this.icon = Icons.rocket_launch,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        gradient: const LinearGradient(
          colors: [
            AppColors.blackCharcoal,
            AppColors.yellowMustard
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.indigo.withOpacity(.25),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(22),
          onTap: () => onChanged(!selected),
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Row(
              children: [
                // Image/Icon
                Container(
                  height: 65,
                  width: 65,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(.2),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    icon,
                    color: Colors.white,
                    size: 34,
                  ),
                ),

                const SizedBox(width: 18),

                // Name
                Expanded(
                  child: Text(
                    name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      letterSpacing: .5,
                    ),
                  ),
                ),

                // Checkbox
                Transform.scale(
                  scale: 1.2,
                  child: Checkbox(
                    value: selected,
                    onChanged: onChanged,
                    activeColor: Colors.white,
                    checkColor: Colors.indigo,
                    side: const BorderSide(
                      color: Colors.white,
                      width: 2,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}