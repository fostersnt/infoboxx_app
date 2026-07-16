import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppNotifications {
static void showSuccessSnackBar(String successMessage) {
  Get.snackbar(
    "An Error Occurred",
    successMessage,
    snackPosition: SnackPosition.TOP,
    backgroundColor: Colors.white,
    colorText: Colors.green,
    margin: const EdgeInsets.all(16),
    icon: const Icon(
      Icons.check,
      color: Colors.green
    ),
    duration: const Duration(seconds: 5),
    snackStyle: SnackStyle.FLOATING,
  );
}
  static void showErrorSnackBar(String errorMessage) {
    Get.snackbar(
      "An Error Occurred",
      errorMessage,
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.white,
      colorText: Colors.red,
      margin: const EdgeInsets.all(16),
      icon: const Icon(
        Icons.error,
        color: Colors.red,
      ),
      duration: const Duration(seconds: 5),
      snackStyle: SnackStyle.FLOATING,
    );
  }
}