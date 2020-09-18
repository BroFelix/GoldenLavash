import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:golden_app/common/function/get_token.dart';
import 'package:golden_app/common/function/save_current_login.dart';
import 'package:golden_app/common/function/save_logout.dart';
import 'package:golden_app/model/login.dart';
import 'package:golden_app/model/token.dart';
import 'package:golden_app/model/user.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final apiUrl = 'http://192.168.0.107:8001/api/v1';
  final apiUrl1 = 'http://85.143.175.111:1909/api/v1';

  Future<LoginModel> signOut(BuildContext context) async {
    saveLogout();
    return null;
  }

  // Future<Token> requestLogin(
  //     BuildContext context, String username, String password) async {
  //   final url = "${this.apiUrl}/rest-auth/login/";
  //   Map<String, String> body = {
  //     'username': username,
  //     'password': password,
  //   };
  //   final response = await http.post(url, body: body);
  //   if (response.statusCode == 200) {
  //     final responseJson = json.decode(response.body);
  //     final er = responseJson;
  //   }
  // }
  // fromJson(Map<String, dynamic> json) {
  //   return json['user'];
  // }

  Future<Token> login(
      BuildContext context, String username, String password) async {
    final url = "${this.apiUrl}/rest-auth/login/";
    Map<String, String> body = {
      'username': username,
      'password': password,
    };
    print(url);
    final response = await http.post(url, body: body).catchError((error){
      print(error.toString());
    });
    print(response.body);
    if (response.statusCode == 200) {
      final responseBody = utf8.decode(response.bodyBytes);
      final responseJson = json.decode(responseBody);
      var token = new Token.fromJson(responseJson);
      await saveCurrentLogin(responseJson);
//      Navigator.of(context).pushReplacementNamed('/login');
      return token;
    } else {
      final responseJson = json.decode(response.body);
      print(responseJson);
      await saveCurrentLogin(responseJson);
      return null;
    }
  }

//  Future<Token> refreshToken() async {
//    final url = "${this.apiUrl}/token/refresh/";
//    Map<String, String> body = {
//      'refresh': await getRefreshToken(),
//    };
//    final response = await http.post(url, body: body);
//
//    if (response.statusCode == 200) {
//      final responseJson = json.decode(response.body);
//      var token = new Token.fromJson(responseJson);
//      saveCurrentLogin(responseJson);
////      Navigator.of(context).pushReplacementNamed('/login');
//      return token;
//    } else {
//      final responseJson = json.decode(response.body);
//
//      saveCurrentLogin(responseJson);
//      return null;
//    }
//  }

  Future<User> getUser(BuildContext context) async {
    String username = 'admin';
    String password = 'adminadmin';
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userId = prefs.getString('userId');
    final url = "${this.apiUrl}/user/$userId/";
    var token = await getToken();
    final response = await http.get(
      url,
      headers: <String, String>{'authorization': basicAuth},
      // headers: {HttpHeaders.authorizationHeader: "JWT $token"},
    );

    if (response.statusCode == 200) {
      final responseJson = json.decode(utf8.decode(response.bodyBytes));
      var user = new User.fromJson(responseJson);
      saveCurrentUser(responseJson);
      return user;
    } else {
      return null;
    }
  }
}
