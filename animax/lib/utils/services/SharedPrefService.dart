import 'package:animax/constants/UrlConsts.dart';
import 'package:shared_preferences/shared_preferences.dart';

saveToken(keyName, token) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString(keyName, token);
}

Future<String?> getToken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString(ACCESS_TOKEN_KEY);
}

removeToken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.remove(ACCESS_TOKEN_KEY);
}
