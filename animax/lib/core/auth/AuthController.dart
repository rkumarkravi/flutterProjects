import 'dart:convert';
import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../modules/dashboard/dashboarController.dart';

class AuthController extends GetxController {
  Future attemptLogIn(String email, String password) async {
    var res = await http.post(
        Uri(
            scheme: 'http',
            host: 'localhost',
            port: 8080,
            path: 'anime/auth/login'),
        headers: {
          "content-type": "application/json",
          "accept": "application/json",
        },
        body: jsonEncode({"emailId": email, "password": password}));
    if (res.statusCode == 200) {
      final body = jsonDecode(res.body);
      Get.find<DashboarController>().jwt.value = body['jwtToken'];
      return res.body;
    } else {
      var msg = "";
      var type = "";
      if (res == 409) {
        type = "Failure";
        msg =
            "That username is already registered Please try to sign up using another username or log in if you already have an account.";
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

    return null;
  }
}
