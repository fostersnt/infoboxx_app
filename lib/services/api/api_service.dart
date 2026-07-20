import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:infoboxx/services/api/dio_client.dart';
import 'package:infoboxx/services/api/api_endpoints.dart';
import 'package:infoboxx/util/response_convertor.dart';

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

      //! Log response to console
      // ResponseConvertor.convertToJson(result);

      if (result["data"]["status_code"] == 200) {
        return {"is_success": true, "api_response": result["data"]};
      }
      return {
        "is_success": false,
        "error_message": result["data"]["reason"],
        "api_response": result["data"],
      };
    } catch (e) {
      String errorMessage = "An unexpected error occurred.";

      if (e is DioException) {
        var res = e.response;
        if (res != null && res.data != null) {
          //! Log response to console
          // ResponseConvertor.convertToJson(res.data);

          // The server WAS reached, but returned an error status (400, 401, 500, etc.)
          errorMessage =
              e.response?.data['data']['reason'] ??
              e.response?.data['data']['reason'] ??
              "Server error.";
        } else {
          //! Log response to console
          var data = {
            "data": {
              "status_code": 1000,
              "reason": "FAILURE ON MOBILE APP",
              "message": "The request did not reach the API server",
            },
          };

          // ResponseConvertor.convertToJson(data);
          // The request NEVER reached your server!
          // Let's find out exactly why:
          switch (e.type) {
            case DioExceptionType.connectionTimeout:
              errorMessage = "Connection timed out. Please try again later.";
              break;
            case DioExceptionType.sendTimeout:
              errorMessage =
                  "Failed to send data to the server. Please check your connection.";
              break;
            case DioExceptionType.receiveTimeout:
              errorMessage =
                  "Server took too long to respond. Please try again.";
              break;
            case DioExceptionType.connectionError:
              errorMessage =
                  "No internet connection or the host server is completely unreachable.";
              break;
            case DioExceptionType.cancel:
              errorMessage = "The request was cancelled.";
              break;
            default:
              errorMessage = "Network connection failed: ${e.message}";
              break;
          }
        }
      } else {
        errorMessage = e.toString();
      }

      return {"is_success": false, "error_message": errorMessage};
    }
  }

  static Future<Map<String, dynamic>> getLeadsApi(String token, Map<String, dynamic> requestBody) async {
    try {
      String endpoint = ApiEndpoints.GET_LEADS;
      // var requestBody = {};
      var response = await DioClient.myDioObj.post(
        endpoint,
        data: requestBody,
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      var result = response.data;

      //! Log response to console
      ResponseConvertor.convertToJson(result);

      if (result["data"]["status_code"] == 200) {
        return {"is_success": true, "api_response": result["data"]};
      }
      return {
        "is_success": false,
        "error_message": result["data"]["reason"],
        "api_response": result["data"],
      };
    } catch (e) {
      String errorMessage = "An unexpected error occurred.";

      if (e is DioException) {
        var res = e.response;
        if (res != null && res.data != null) {
          //! Log response to console
          ResponseConvertor.convertToJson(res.data);

          // The server WAS reached, but returned an error status (400, 401, 500, etc.)
          errorMessage =
              e.response?.data['data']['reason'] ??
              e.response?.data['data']['reason'] ??
              "Server error.";
        } else {
          //! Log response to console
          var data = {
            "data": {
              "status_code": 1000,
              "reason": "FAILURE ON MOBILE APP",
              "message": "The request did not reach the API server",
            },
          };

          ResponseConvertor.convertToJson(data);
          // The request NEVER reached your server!
          // Let's find out exactly why:
          switch (e.type) {
            case DioExceptionType.connectionTimeout:
              errorMessage = "Connection timed out. Please try again later.";
              break;
            case DioExceptionType.sendTimeout:
              errorMessage =
                  "Failed to send data to the server. Please check your connection.";
              break;
            case DioExceptionType.receiveTimeout:
              errorMessage =
                  "Server took too long to respond. Please try again.";
              break;
            case DioExceptionType.connectionError:
              errorMessage =
                  "No internet connection or the host server is completely unreachable.";
              break;
            case DioExceptionType.cancel:
              errorMessage = "The request was cancelled.";
              break;
            default:
              errorMessage = "Network connection failed: ${e.message}";
              break;
          }
        }
      } else {
        errorMessage = e.toString();
      }

      return {"is_success": false, "error_message": errorMessage};
    }
  }
}
