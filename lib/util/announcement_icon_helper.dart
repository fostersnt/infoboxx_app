import 'package:flutter/material.dart';

class AnnouncementIconHelper {
  static IconData getIconForCategory(String? type) {
    switch (type?.toLowerCase()) {
      case 'system':
      case 'maintenance':
        return Icons.build_circle_outlined;
      case 'lead':
      case 'opportunity':
        return Icons.person_search_rounded;
      case 'security':
      case 'verification':
        return Icons.verified_user_outlined;
      case 'promo':
      case 'feature':
        return Icons.stars_rounded;
      case 'warning':
      case 'alert':
        return Icons.warning_amber_rounded;
      default:
        return Icons.campaign_rounded; // Default broadcast horn
    }
  }

  static Color getIconColor(String? type) {
    switch (type?.toLowerCase()) {
      case 'warning':
      case 'alert':
        return const Color(0xFFE57373); // Red
      case 'security':
        return const Color(0xFF4CAF50); // Green
      default:
        return const Color(0xFFFBC31B); // Brand Amber Yellow
    }
  }
}