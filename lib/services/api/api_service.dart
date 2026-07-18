import 'package:flutter/material.dart';
import 'package:infoboxx/services/api/dio_client.dart';
import 'package:infoboxx/services/api/api_endpoints.dart';

class ApiService {
  static Future<Map<String, dynamic>> userLoginApi(
    String email,
    String password,
  ) async {
    try {
      String endpoint = ApiEndpoints.SERVICE_PROVIDER_LOGIN;
      var requestBody = {"email": email, "password": password};
      var response = await DioClient.myDioObj.post(endpoint, data: requestBody);
      return {"is_success": true, "api_response": response.data};
    } catch (e) {
      return {"is_success": false, "error_message": e.toString()};
    }
  }
}
