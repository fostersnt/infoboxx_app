import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppNotifications {
  static void showSuccessSnackBar(String title, String successMessage) {
    Get.snackbar(
      title,
      successMessage,
      messageText: Text(
        successMessage,
        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green),
      ),
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.white,
      colorText: Colors.green,
      margin: const EdgeInsets.all(16),
      icon: const Icon(Icons.check, color: Colors.green),
      duration: const Duration(seconds: 5),
      snackStyle: SnackStyle.FLOATING,
    );
  }

  static void showErrorSnackBar(String title, String errorMessage) {
    Get.snackbar(
      title,
      errorMessage,
      messageText: Text(
        errorMessage,
        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
      ),
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.white,
      colorText: Colors.red,
      margin: const EdgeInsets.all(16),
      icon: const Icon(Icons.error, color: Colors.red),
      duration: const Duration(seconds: 5),
      snackStyle: SnackStyle.FLOATING,
    );
  }

  static void showDynamicErrorSnackBar(String title, RxString reactiveMessage) {
    Get.snackbar(
      title,
      "", // Leave the main message parameter blank
      messageText: Obx(
        () => Text(
          reactiveMessage
              .value, // 👈 The snackbar text will now morph in real-time if this changes!
          style: const TextStyle(color: Colors.red),
        ),
      ),
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.white,
      colorText: Colors.red,
      margin: const EdgeInsets.all(16),
      icon: const Icon(Icons.error, color: Colors.red),
      duration: const Duration(seconds: 5),
      snackStyle: SnackStyle.FLOATING,
    );
  }
}
