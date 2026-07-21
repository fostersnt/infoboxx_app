import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infoboxx/model/Lead.dart';
import 'package:infoboxx/services/api/api_service.dart';
import 'package:infoboxx/util/response_convertor.dart';

class UserService extends GetxService {
  final userData = Rx<Map<String, dynamic>>({});
  final userSignUpData = Rx<Map<String, dynamic>>({});
  RxBool isLoading = false.obs;
  RxString errorMessage = "".obs;
  RxString accessToken = "".obs;
  final RxList<Lead> leads = <Lead>[].obs;

  // @override
  // void onInit() {
  //   // TODO: implement onInit
  //   super.onInit();
  //   getLeadStatistics();
  // }

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
        accessToken.value = response["data"]["access_token"] ?? "NA_APP";

        var encoder = const JsonEncoder.withIndent('  ');
        String prettyJson = encoder.convert(userData.value);
        debugPrint("--------DATA FROM USER LOGIN SERVICE------------");
        String tk = accessToken.value;
        debugPrint("--------ACCESS TOKEN $tk ------------");
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

  Future<bool> userSignUp({
    bool forceRefresh = false,
    String company_name = "",
    String company_email = "",
    String company_phone = "",
  }) async {

    isLoading.value = true;

    try {
      if (company_name == "") {
        errorMessage.value = "Company name missing";
        return false;
      }
      if (company_email == "") {
        errorMessage.value = "Company email missing";
        return false;
      }
      if (company_phone == "") {
        errorMessage.value = "Phone number missing";
        return false;
      }

      Map<String, dynamic> reqBody = {
        "company_name": company_name,
        "company_email": company_email,
        "company_phone_number": company_phone
      };

      var result = await ApiService.userSignUpApi(reqBody);

      if (result['is_success'] == true) {
        var response = result["api_response"];
        userSignUpData.value = response["data"];

        var encoder = const JsonEncoder.withIndent('  ');
        String prettyJson = encoder.convert(userSignUpData.value);
        String prettyJsonReqBody = encoder.convert(reqBody);

        debugPrint("--------DATA FROM USER LOGIN SERVICE------------");
        debugPrint(prettyJson);
        debugPrint(prettyJsonReqBody);
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

  Future<bool> getLeads({bool forceRefresh = false}) async {
    try {
      if (forceRefresh == false && leads.isNotEmpty) {
        return true;
      }

      String token = accessToken.value;
      var data = {
        "service_provider_id": userData.value["service_provider"]["id"],
        "sub_category":
            userData.value["service_provider"]["sub_category"]["name"],
        "category": userData
            .value["service_provider"]["sub_category"]["category"]["name"],
      };
      var result = await ApiService.getLeadsApi(accessToken.value, data);
      if (result['is_success'] == true) {
        var response = result["api_response"];
        List<Map<String, dynamic>> allLeads = List<Map<String, dynamic>>.from(
          response["data"],
        );

        if (allLeads.isNotEmpty) {
          leads.value = [];
          for (var item in allLeads) {
            leads.add(
              Lead(
                firstName: item["first_name"] ?? "N/A",
                lastName: item["last_name"] ?? "N/A",
                email: item["email"] ?? "N/A",
                msisdn: item["msisdn"] ?? "N/A",
                status: item["status"] ?? "N/A",
                comment: item["comment"] ?? "N/A",
                createdAt: item["created_at"] ?? "N/A",
                convertedAt: item["converted_at"] ?? "N/A",
              ),
            );
          }
        }

        var encoder = const JsonEncoder.withIndent('  ');
        String prettyJson = encoder.convert(allLeads);
        debugPrint("--------DATA FROM LEADS STATISTICS SERVICE------------");
        debugPrint(prettyJson);
        debugPrint(
          "--------END-----DATA FROM LEADS STATISTICS SERVICE------------",
        );

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

  Map<String, int> getMonthlyConvertedLeads() {
    final userService = Get.find<UserService>();

    const monthNames = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];

    final now = DateTime.now();

    // Map<String, int> monthlyCounts = {};

    // Oldest -> Newest
    // for (int i = 5; i >= 0; i--) {
    //   final date = DateTime(now.year, now.month - i);
    //   monthlyCounts[monthNames[date.month - 1]] = 0;
    // }

    Map<String, int> monthlyCounts = {
      for (final month in monthNames) month: 0,
    };

    for (var lead in userService.leads) {
      if (lead.status?.toUpperCase() == 'CONVERTED' &&
          lead.createdAt != null) {
        try {
          final date = DateTime.parse(lead.createdAt!);
          final key = monthNames[date.month - 1];

          if (monthlyCounts.containsKey(key)) {
            monthlyCounts[key] = monthlyCounts[key]! + 1;
          }
        } catch (_) {}
      }
    }

    return monthlyCounts;
  }
}
