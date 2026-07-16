import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppNotifications {
static void showSuccessSnackBar(String title, String successMessage) {
  Get.snackbar(
    title,
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
  static void showErrorSnackBar(String title, String errorMessage) {
    Get.snackbar(
      title,
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