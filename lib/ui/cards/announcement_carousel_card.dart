import 'package:flutter/material.dart';
import 'package:infoboxx/util/announcement_icon_helper.dart';
import 'package:infoboxx/util/app_colors.dart';

class AnnouncementCarouselCard extends StatelessWidget {
  final String title;
  final String type;
  final String message;
  final String dateText;
  // final IconData icon;
  final VoidCallback? onTap;

  const AnnouncementCarouselCard({
    super.key,
    required this.title,
    required this.type,
    required this.message,
    required this.dateText,
    // this.icon = Icons.campaign_rounded,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 300,
        margin: const EdgeInsets.only(right: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.whitePure,
          // color: const Color(0xFF1E1E1E), // Dark Charcoal
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: const Color(0xFFFBC31B).withOpacity(0.2),
            width: 1,
          ),
          // boxShadow: [
          //   BoxShadow(
          //     color: Colors.black.withOpacity(0.2),
          //     blurRadius: 12,
          //     offset: const Offset(0, 4),
          //   ),
          // ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Top Row: Icon Badge & Date
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFBC31B).withOpacity(0.12),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    AnnouncementIconHelper.getIconForCategory(type),
                    color: const Color(0xFFFBC31B),
                    size: 18,
                  ),
                ),
                Text(
                  dateText,
                  style: TextStyle(
                    // color: Colors.white.withOpacity(0.4),
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            // Title
            Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                // color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.bold,
                letterSpacing: -0.2,
              ),
            ),
            const SizedBox(height: 6),
            // Message Body
            Text(
              message,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                // color: Colors.white.withOpacity(0.6),
                fontSize: 12,
                height: 1.3,
              ),
            ),
          ],
        ),
      ),
    );
  }
}