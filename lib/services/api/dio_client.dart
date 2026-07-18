import 'package:dio/dio.dart';

class DioClient {
  static final Dio myDioObj = Dio(
    BaseOptions(
      baseUrl: 'https://api.infoboxx.com/api',
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
    ),
  );
}