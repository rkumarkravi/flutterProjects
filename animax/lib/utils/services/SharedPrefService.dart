import 'package:animax/constants/UrlConsts.dart';
import 'package:shared_preferences/shared_preferences.dart';

saveToken(token) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString(JWT_NAME, token);
}

Future<String?> getToken() async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString(JWT_NAME);
}

removeToken() async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.remove(JWT_NAME);
}