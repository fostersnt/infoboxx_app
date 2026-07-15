import 'dart:convert';

import 'package:flutter/cupertino.dart';

class ResponseConvertor {
  static void convertToJson(Map<String, dynamic> apiResponse) {
    // 1. Convert the JSON object into a pretty-printed string
    var encoder = const JsonEncoder.withIndent('  ');
    String prettyJson = encoder.convert(apiResponse);

    // 2. Print it out
    debugPrint("--- API RESPONSE DATA ---");
    debugPrint(prettyJson);
    debugPrint("-------------------------");

    if (apiResponse['data']['status_code'] == 200) {
      debugPrint("--- API REQUEST IS COMPLETED WITH SUCCESS RESPONSE ---");
    }else{
      debugPrint("--- API REQUEST IS COMPLETED WITH FAILED RESPONSE ---");
    }
  }
}
