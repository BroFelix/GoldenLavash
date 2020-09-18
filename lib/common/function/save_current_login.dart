import 'dart:convert';

import 'package:golden_app/model/token.dart';
import 'package:golden_app/model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

saveCurrentLogin(Map responseJson) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var token = "";
  var user = "";
  if (responseJson != null && responseJson.isNotEmpty) {
    token = Token.fromJson(responseJson).token;
    user = responseJson['user'].toString();
  }
  print(token);
  await prefs.setString('userId', user);
  await prefs.setString(
      'token', (token != null && token.length > 0) ? token : "");
}

saveCurrentUser(Map responseJson) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var user = (responseJson != null && responseJson.isNotEmpty)
      ? json.encode(User.fromJson(responseJson).toJson())
      : "";
  print("User: $user");

  await prefs.setString(
      'user', (user != null && user.length > 0) ? user : "");
}
