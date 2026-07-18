import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infoboxx/services/api/api_service.dart';

class UserService extends GetxService {
  final loginResponse = Rx<Map<String, dynamic>>({});
  RxBool isLoading = false.obs;
  RxString errorMessage = "".obs;

  Future<bool> userLogin({bool forceRefresh = false, String email = "", String password = ""}) async {
    // Skip fetching if data already exists
    if (forceRefresh == false && loginResponse.value.isNotEmpty) {
      return true;
    }

    isLoading.value = true;

    try {
      var result = await ApiService.userLoginApi(email, password);
      if(result['is_success'] == true)
        {
          var response = result["api_response"];
          loginResponse.value = response["data"];
          return true;
        }else{
        errorMessage.value = result['error_message'];
      }
      return false;
    } catch(e) {
      isLoading.value = false;
      return false;
    }
  }
}