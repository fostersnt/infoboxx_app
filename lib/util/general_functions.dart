import 'package:flutter/material.dart';
import 'package:infoboxx/util/mock_data/leads_mock_data.dart';
import 'package:intl/intl.dart';

class GeneralFunctions {
  static String getFormatedDate()
  {
    final now = DateTime.now();

    final dayName = DateFormat('EEEE').format(now); // Friday
    final month = DateFormat('MMMM').format(now);   // July
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

  static String getGreeting()
  {
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

  static Map<String, int> getMonthlyConvertedLeads() {
    // Initialize last 6 months with 0
    var leads = LeadsMockData.mockLeads;
    final monthNames = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];

    Map<String, int> monthlyCounts = {
      for (var i = 5; i >= 0; i--)
        monthNames[DateTime.now().subtract(Duration(days: i * 30)).month - 1]: 0
    };

    for (var lead in leads) {
      // Only count CONVERTED status
      if (lead.status?.toUpperCase() == 'CONVERTED' && lead.createdAt != null) {
        try {
          DateTime date = DateTime.parse(lead.createdAt!);
          String monthKey = monthNames[date.month - 1];
          if (monthlyCounts.containsKey(monthKey)) {
            monthlyCounts[monthKey] = (monthlyCounts[monthKey] ?? 0) + 1;
          }
        } catch (_) {}
      }
    }

    return monthlyCounts;
  }
}