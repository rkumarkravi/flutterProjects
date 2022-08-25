import 'dart:convert';
import 'package:animax/utils/services/SharedPrefService.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../constants/UrlConsts.dart';

dynamic attemptLogIn(String email, String password) async {
  var res = await http.post(
      Uri(scheme: 'http', host: SERVER_IP, port: 8080, path: 'anime/login'),
      body: {"username": email, "password": password});
  if (res.statusCode == 200) {
    debugPrint(res.body);
    final body = jsonDecode(res.body);
    var jwt = body['access_token'];
    saveToken(ACCESS_TOKEN_KEY, jwt);
    return body;
  } else {
    var msg = "";
    var type = "";
    final body = jsonDecode(res.body);
    if (body['status'] == 'FAIL' &&
        body['message'].toString().contains("INVALID_CREDENTIALS")) {
      msg = "Invalid Credentials";
      type = "Failed";
    } else {
      type = "Error";
      msg = "An unknown error occurred.";
    }
    if (type.isNotEmpty) {
      Get.snackbar(type, msg,
          snackPosition: SnackPosition.BOTTOM,
          margin: const EdgeInsets.all(8.0));
    }
  }
}

// dynamic attemptLogIn(String email, String password) async {
//   var res = await http.post(
//       Uri(
//           scheme: 'http',
//           host: SERVER_IP,
//           port: 8080,
//           path: 'anime/auth/login'),
//       headers: {
//         "content-type": "application/json",
//         "accept": "application/json",
//       },
//       body: jsonEncode({"emailId": email, "password": password}));
//   if (res.statusCode == 200) {
//     final body = jsonDecode(res.body);
//     var jwt = body['jwtToken'];
//     saveToken(jwt);
//     return body;
//   } else {
//     var msg = "";
//     var type = "";
//     final body = jsonDecode(res.body);
//     if (body['status'] == 'FAIL' &&
//         body['message'].toString().contains("INVALID_CREDENTIALS")) {
//       msg = "Invalid Credentials";
//       type = "Failed";
//     } else {
//       type = "Error";
//       msg = "An unknown error occurred.";
//     }
//     if (type.isNotEmpty) {
//       Get.snackbar(type, msg,
//           snackPosition: SnackPosition.BOTTOM,
//           margin: const EdgeInsets.all(8.0));
//     }
//   }

//   return null;
// }

dynamic validateToken(token) async {
  var res = await http.get(
      Uri(
          scheme: 'http',
          host: SERVER_IP,
          port: 8080,
          path: 'anime/auth/validate',
          queryParameters: {"t": token}),
      headers: {
        "content-type": "application/json",
        "accept": "application/json",
      });
  return res;
}
