import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infoboxx/services/api/api_service.dart';
import 'package:infoboxx/util/response_convertor.dart';

class UserService extends GetxService {
  final userData = Rx<Map<String, dynamic>>({});
  RxBool isLoading = false.obs;
  RxString errorMessage = "".obs;
  RxString accessToken = "".obs;
  var leadStatistics = {}.obs;

  Future<bool> userLogin({
    bool forceRefresh = false,
    String email = "",
    String password = "",
  }) async {
    // Skip fetching if data already exists
    if (forceRefresh == false && userData.value.isNotEmpty) {
      return true;
    }

    isLoading.value = true;

    try {
      if (email == "") {
        errorMessage.value = "Email should not be blank";
        return false;
      }

      if (password == "") {
        errorMessage.value = "Password should not be blank";
        return false;
      }

      var result = await ApiService.userLoginApi(email, password);
      if (result['is_success'] == true) {
        var response = result["api_response"];
        userData.value = response["data"];
        accessToken.value = response["access_token"] ?? "NA_APP";

        var encoder = const JsonEncoder.withIndent('  ');
        String prettyJson = encoder.convert(userData.value);
        debugPrint("--------DATA FROM USER LOGIN SERVICE------------");
        debugPrint(prettyJson);
        debugPrint("--------END-----DATA FROM USER LOGIN SERVICE------------");

        return true;
      } else {
        errorMessage.value = result['error_message'];
        return false;
      }
    } catch (e) {
      isLoading.value = false;
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> getLeadStatistics() async {
    try {
      var result = await ApiService.getLeadStatisticsApi(accessToken.value);
      if (result['is_success'] == true) {
        var response = result["api_response"];
        leadStatistics.value = response["data"];

        var encoder = const JsonEncoder.withIndent('  ');
        String prettyJson = encoder.convert(userData.value);
        debugPrint("--------DATA FROM LEADS STATISTICS SERVICE------------");
        debugPrint(prettyJson);
        debugPrint("--------END-----DATA FROM LEADS STATISTICS SERVICE------------");

        return true;
      } else {
        errorMessage.value = result['error_message'];
        return false;
      }
    } catch (e) {
      isLoading.value = false;
      return false;
    } finally {
      isLoading.value = false;
    }
  }
}
