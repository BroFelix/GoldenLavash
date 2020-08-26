import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

saveLogout() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  await preferences.setString('token', "");
  await preferences.setString('refreshToken', "");
  await preferences.setString('user', "");
}
