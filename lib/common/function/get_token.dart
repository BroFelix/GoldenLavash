import 'package:shared_preferences/shared_preferences.dart';

Future<String> getToken() async {
  var prefs = await SharedPreferences.getInstance();
  return prefs.getString("token");
}

getRefreshToken() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();

  return preferences.getString("refreshToken");
}
