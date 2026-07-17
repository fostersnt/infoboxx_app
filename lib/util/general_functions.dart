import 'package:flutter/material.dart';
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
}