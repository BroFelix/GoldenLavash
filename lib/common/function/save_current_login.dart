import 'dart:convert';

import 'package:golden_app/models/token.dart';
import 'package:golden_app/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

saveCurrentLogin(Map responseJson) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();

  var token = (responseJson != null && responseJson.isNotEmpty)
      ? Token.fromJson(responseJson).token
      : "";
  print(token);
  await preferences.setString(
      'token', (token != null && token.length > 0) ? token : "");
}

saveCurrentUser(Map responseJson) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();

  var user = (responseJson != null && responseJson.isNotEmpty)
      ? json.encode(User.fromJson(responseJson).toJson())
      : "";
  print("User: ${user}");

  await preferences.setString(
      "user", (user != null && user.length > 0) ? user : "");
}
