import 'package:flutter/material.dart';
import 'package:infoboxx/util/app_colors.dart';
import 'package:infoboxx/util/mock_data/leads_mock_data.dart';
import 'package:intl/intl.dart';

class GeneralFunctions {
  static String getFormatedDate() {
    final now = DateTime.now();

    final dayName = DateFormat('EEEE').format(now); // Friday
    final month = DateFormat('MMMM').format(now); // July
    final year = now.year;

    return '$dayName, ${now.day}${_getDaySuffix(now.day)} $month $year';
  }

  static String _getDaySuffix(int day) {
    if (day >= 11 && day <= 13) {
      return 'th';
    }

    switch (day % 10) {
      case 1:
        return 'st';
      case 2:
        return 'nd';
      case 3:
        return 'rd';
      default:
        return 'th';
    }
  }

  static String getGreeting() {
    int hour = DateTime.now().hour;
    if (hour >= 0 && hour < 12) {
      return "Morning";
    } else if (hour >= 12 && hour < 16) {
      return "Afternoon";
    } else if (hour > 16 && hour <= 23) {
      return "Evening";
    } else {
      return "Welcome";
    }
  }

  static Widget getOnboardingStatusText({bool isCompleted = false}) {
    String status = isCompleted ? "COMPLETED" : "PENDING";

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: isCompleted == true
            ? AppColors.greenVibrantEmerald.withOpacity(0.12)
            : AppColors.redCrimson.withOpacity(0.12),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        status,
        style: TextStyle(
          color: isCompleted == true
              ? AppColors.greenVibrantEmerald.withOpacity(0.8)
              : AppColors.redCrimson.withOpacity(0.8),
          fontSize: 13,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  static String getInitials(String name) {
    if (name.trim().isEmpty) return "";

    final parts = name.trim().split(RegExp(r'\s+'));

    if (parts.length == 1) {
      return parts.first[0].toUpperCase();
    }

    return (parts.first[0] + parts.last[0]).toUpperCase();
  }
}
