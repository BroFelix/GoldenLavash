import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

getUser() async {
  var prefs = await SharedPreferences.getInstance();
  var user = prefs.getString("user");
  return json.decode(user);
}
