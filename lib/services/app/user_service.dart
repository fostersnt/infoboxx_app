import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infoboxx/services/api/api_service.dart';

class UserService extends GetxService {
  final user = Rx<Map<String, dynamic>>({});
  RxBool isLoading = false.obs;

  Future<void> userLogin({bool forceRefresh = false, String email = "", String password = ""}) async {
    // Skip fetching if data already exists
    if (forceRefresh == false && user.value.isNotEmpty) {
      return;
    }

    isLoading.value = true;

    try {
      user.value = await ApiService.userLoginApi(email, password);
    } finally {
      isLoading.value = false;
    }
  }
}