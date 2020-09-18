import 'package:shared_preferences/shared_preferences.dart';

saveLogout() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('token', "");
  await prefs.setString('refreshToken', "");
  await prefs.setString('user', "");
  await prefs.setString('userId', "");
}
