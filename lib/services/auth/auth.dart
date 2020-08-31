import 'dart:convert';
import 'dart:io';
import 'package:golden_app/common/function/get_token.dart';
import 'package:golden_app/common/function/save_current_login.dart';
import 'package:golden_app/common/function/save_logout.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/widgets.dart';
import 'package:golden_app/models/login.dart';
import 'package:golden_app/models/token.dart';
import 'package:golden_app/models/user.dart';

class AuthService {
  final apiUrl = 'http://85.143.175.111:1909/api/v1';

  Future<LoginModel> signout(BuildContext context) async {
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

  Future<Token> login(
      BuildContext context, String username, String password) async {
    final url = "${this.apiUrl}/rest-auth/login/";
    Map<String, String> body = {
      'username': username,
      'password': password,
    };
    print(url);
    final response = await http.post(url, body: body);
    print(response.statusCode);
    if (response.statusCode == 200) {
      var responseBody = utf8.decode(response.bodyBytes);
      final responseJson = json.decode(responseBody);
      var token = new Token.fromJson(responseJson);
      await saveCurrentLogin(responseJson);
//      Navigator.of(context).pushReplacementNamed('/login');
      return token;
    } else {
      // final responseJson = json.decode(response.body);

//      await saveCurrentLogin(responseJson);
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
    final url = "${this.apiUrl}/user/";
    var token = await getToken();
    final response = await http
        .get(url, headers: {HttpHeaders.authorizationHeader: "JWT $token"});

    if (response.statusCode == 200) {
      final responseJson = json.decode(response.body);
      var user = new User.fromJson(responseJson);
      saveCurrentUser(responseJson);
      return user;
    } else {
      return null;
    }
  }
}
