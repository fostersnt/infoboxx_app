import 'package:flutter/material.dart';

class AppValidators {
  static bool isValidEmail(String email) {
    // The most reliable regex pattern for standard email formats
    final RegExp emailRegex = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
    );

    // Clean trailing spaces and check against the pattern
    return emailRegex.hasMatch(email.trim());
  }
}
