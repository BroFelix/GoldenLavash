import 'dart:convert';

import 'package:golden_app/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

getUser() async {
  var prefs = await SharedPreferences.getInstance();
  var user = prefs.getString("user");
  return User.fromJson(json.decode(user));
}