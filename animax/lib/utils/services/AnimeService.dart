import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../constants/UrlConsts.dart';
import '../../core/models/anime_detail/anime_detail.dart';
import 'dart:convert';
import 'SharedPrefService.dart';

Future<AnimeRespone> fetchData(page, size) async {
  debugPrint("fetchData called!! ${await getToken()}");
  //http://localhost:8080/anime/api/v1/anime/getAll
  final response = await http.post(
      Uri(
          scheme: 'http',
          host: SERVER_IP,
          port: 8080,
          path: 'anime/api/v1/anime/getAll'),
      headers: await getHeader,
      body: '{"page": $page,"size": $size}');
  if (response.statusCode == 200) {
    debugPrint(response.body);
    return AnimeRespone.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Unexpected error occurred!');
  }
}

Future<Map<String, String>> get getHeader async {
  return {
    'Content-type': 'application/json',
    "Authorization": "Bearer ${await getToken()}"
  };
}

Future<AnimeDetail> fetchDataInitialLoad(animeId) async {
  //http://localhost:8080/anime/api/v1/anime/getAll
  final response = await http.get(
      Uri(
          scheme: 'http',
          host: 'localhost',
          port: 8080,
          path: 'anime/api/v1/anime/get/$animeId/1'),
      headers: {'Content-type': 'application/json'});
  if (response.statusCode == 200) {
    debugPrint(response.body);
    return AnimeDetail.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Unexpected error occured!');
  }
}

Future<ApiResponse> fetchMyList(page, size) async {
  debugPrint("fetchMyList called!! ${await getToken()}");
  final response = await http.post(
      Uri(
          scheme: 'http',
          host: SERVER_IP,
          port: 8080,
          path: 'anime/api/v1/user/myList'),
      headers: await getHeader,
      body: '{"page": $page,"size": $size}');
  if (response.statusCode == 200) {
    debugPrint(response.body);
    return ApiResponse.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Unexpected error occurred!');
  }
}

Future removeFromMyList(aid) async {
  debugPrint("removeFromMyList called!! ${await getToken()}");
  final response = await http.delete(
      Uri(
          scheme: 'http',
          host: SERVER_IP,
          port: 8080,
          path: 'anime/api/v1/user/myList/remove/$aid'),
      headers: await getHeader);
  if (response.statusCode == 200) {
    debugPrint(response.body);
    return jsonDecode(response.body);
  } else {
    throw Exception('Unexpected error occurred!');
  }
}

addToMyList(aid) async {
  debugPrint("addToMyList called!! ${await getToken()}");
  final response = await http.put(
      Uri(
          scheme: 'http',
          host: SERVER_IP,
          port: 8080,
          path: 'anime/api/v1/user/myList/add/$aid'),
      headers: await getHeader);
  if (response.statusCode == 200) {
    showSnackbar("Info", "Added to your list");
  } else {
    showSnackbar("Error", "Something Went Wrong!");
    throw Exception('Unexpected error occurred!');
  }
}

showSnackbar(type, msg) {
  Get.snackbar(type, msg,
      duration: const Duration(seconds: 2),
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(8.0));
}
