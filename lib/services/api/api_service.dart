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
      var result = response.data;
      if(result["data"]["status_code"] == 200)
        {
          return {"is_success": true, "api_response": result["data"]};
        }
      return {"is_success": false, "error_message": result["data"]["reason"], "api_response": result["data"]};
    } catch (e) {
      return {"is_success": false, "error_message": e.toString()};
    }
  }
}
