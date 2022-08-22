import 'package:flutter/cupertino.dart';
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
      headers: {
        'Content-type': 'application/json',
        "Authorization": "Bearer ${await getToken()}"
      },
      body: '{"page": $page,"size": $size}');
  if (response.statusCode == 200) {
    debugPrint(response.body);
    return AnimeRespone.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Unexpected error occurred!');
  }
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