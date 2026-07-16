import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infoboxx/util/app_colors.dart';

class AppNotifications {
  static void showSuccessSnackBar(String title, String successMessage) {
    Get.snackbar(
      title,
      "",
      messageText: Text(
        successMessage,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: AppColors.greenVibrantEmerald,
        ),
      ),
      snackPosition: SnackPosition.TOP,
      backgroundColor: AppColors.grayLightSilver,
      colorText: AppColors.greenVibrantEmerald,
      margin: const EdgeInsets.all(16),
      icon: const Icon(Icons.check, color: AppColors.greenVibrantEmerald),
      duration: const Duration(seconds: 5),
      snackStyle: SnackStyle.FLOATING,
    );
  }

  static void showErrorSnackBar(String title, String errorMessage) {
    Get.snackbar(
      title,
      "",
      messageText: Text(
        errorMessage,
        style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.redCrimson),
      ),
      snackPosition: SnackPosition.TOP,
      backgroundColor: AppColors.grayLightSilver,
      colorText: AppColors.redCrimson,
      margin: const EdgeInsets.all(16),
      icon: const Icon(Icons.error, color: AppColors.redCrimson),
      duration: const Duration(seconds: 5),
      snackStyle: SnackStyle.FLOATING,
    );
  }

  static void showDynamicErrorSnackBar(String title, RxString reactiveMessage) {
    Get.snackbar(
      title,
      "",
      messageText: Obx(
        () => Text(
          reactiveMessage.value,
          style: const TextStyle(color: AppColors.redCrimson),
        ),
      ),
      snackPosition: SnackPosition.TOP,
      backgroundColor: AppColors.grayLightSilver,
      colorText: AppColors.redCrimson,
      margin: const EdgeInsets.all(16),
      icon: const Icon(Icons.error, color: AppColors.redCrimson),
      duration: const Duration(seconds: 5),
      snackStyle: SnackStyle.FLOATING,
    );
  }
}
