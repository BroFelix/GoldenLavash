import 'package:shared_preferences/shared_preferences.dart';

Future<String> getFCMToken() async {
  var prefs = await SharedPreferences.getInstance();
  return prefs.getString("fcmtoken");
}

Future<void> setFCMToken(String token) async {
  var prefs = await SharedPreferences.getInstance();
  return prefs.setString("fcmtoken", token);
}
