import 'package:shared_preferences/shared_preferences.dart';

saveToken(token) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('jwt', token);
}

Future<String?> getToken() async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('jwt');
}