import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infoboxx/model/Lead.dart';
import 'package:infoboxx/services/api/api_service.dart';
import 'package:infoboxx/util/response_convertor.dart';

class UserService extends GetxService {
  final userData = Rx<Map<String, dynamic>>({});
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

  Future<bool> getLeads() async {
    try {
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
          for (var item in allLeads) {
            leads.add(
              Lead(
                firstName: item["first_name"],
                lastName: item["last_name"],
                email: item["email"],
                msisdn: item["msisdn"],
                status: item["status"],
                comment: item["comment"],
                createdAt: item["created_at"],
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
}
