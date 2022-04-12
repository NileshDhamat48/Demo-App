import 'dart:convert';
import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;


import '../response/common_response.dart';

class ApiManager {
  BuildContext? context;
  ApiManager(this.context);

  ApiManager.empty();

  static Future<bool> checkInternet() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      return false;
    } else {
      return true;
    }
  }



  // --- GEt Call ---
  Future<Map<String, dynamic>> getCall(
      String url, [
        Map<String, dynamic>? request,
      ]) async {
    try {
      Map<String, String> headers;

      headers = await getHeaders();

      var uri = Uri.parse(url);
      // uri = uri.replace(queryParameters: request ?? {});

      AppLogs.debugging(uri);
      AppLogs.debugging(headers);

      http.Response response = await http.get(uri, headers: headers);

      AppLogs.debugging("${response.statusCode}");
      AppLogs.debugging(response.body);
      if (response.statusCode == 401) {
        // logoutUnauthenticated();
        CommonResponse commonResponse =
        CommonResponse(message: "Unauthenticated.", status: "0");
        return await json.decode(json.encode(commonResponse.toJson()));
      } else {
        final data = await json.decode(response.body);
        return data;
      }
    } catch (e, s) {
      AppLogs.debugging("crashed ::::$e ::::::$s");

      CommonResponse commonResponse =
      CommonResponse(message: e.toString(), status: "0");
      return await json.decode(commonResponse.toJson().toString());
    }
  }


// --- Headers ---
  Future<Map<String, String>> getHeaders() async {
    Map<String, String> headers = <String, String>{};

    try {
      // if (sharedPreferences.getString(AppStrings.userPrefKey) == null) {
        headers['Accept'] = 'application/json';
        headers['X-App-Locale'] = 'language';
      // }
      // else {
      //   UserResponse user = UserResponse.fromJson(jsonDecode(
      //       sharedPreferences.getString(AppStrings.userPrefKey) ?? ''));
      //
      //   if (user.token != null) {
      //     headers['Authorization'] = 'Bearer ' + user.token!.trim();
      //   }
      //   headers['Accept'] = 'application/json';
      //   // headers['X-App-Locale'] = 'language';
      // }
    } catch (e) {
      log(e.toString());
    }
    return headers;
  }


}

class AppLogs {
  static debugging(Object object) {
    log(object.toString());
  }
}