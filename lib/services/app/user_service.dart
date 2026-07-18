import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infoboxx/services/api/api_service.dart';

class UserService {
  Rx<User?> user = Rx<User?>(null);
  RxBool isLoading = false.obs;

  Future<void> fetchUser({bool forceRefresh = false, String email = "", String password = ""}) async {
    // Skip fetching if data already exists
    if (!forceRefresh && user.value != null) {
      return;
    }

    isLoading.value = true;

    try {
      user.value = await ApiService.loginUser(email, password);
    } finally {
      isLoading.value = false;
    }
  }
}