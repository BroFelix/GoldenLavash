import 'dart:convert';
import 'dart:core';
import 'dart:io';
import 'package:golden_app/common/function/get_token.dart';
import 'package:golden_app/models/expense.dart';
import 'package:golden_app/models/resource.dart';
import 'package:http/http.dart' as http;
import 'package:golden_app/models/estimate.dart';

class ApiService {
  final apiUrl = 'http://85.143.175.111:1909/api/v1';

  ApiService._();

  static ApiService _instance;

  static ApiService getInstance() {
    if (_instance == null) {
      _instance = ApiService._();
    }
    return _instance;
  }

  Future<ExpenseResponse> getExpenses() async {
    var token = await getToken();
    var url = "$apiUrl/estimate-item/";
    final response = await http
        .get(url, headers: {HttpHeaders.authorizationHeader: 'JWT $token'});
    final responseBody = utf8.decode(response.bodyBytes);
    final responseObj = json.decode(responseBody);
    return ExpenseResponse.fromJson(responseObj);
  }

  Future<ResourceResponse> getResources() async {
    var token = await getToken();
    var url = "$apiUrl/estimate-resource/";
    final response = await http
        .get(url, headers: {HttpHeaders.authorizationHeader: 'JWT $token'});
    final responseBody = utf8.decode(response.bodyBytes);
    final responseObj = json.decode(responseBody);
    return ResourceResponse.fromJson(responseObj);
  }

  Future<EstimateResponse> getEstimates() async {
    var token = await getToken();
    var url = "$apiUrl/estimate/";
    final response = await http
        .get(url, headers: {HttpHeaders.authorizationHeader: 'JWT $token'});
    final responseBody = utf8.decode(response.bodyBytes);
    final responseObj = json.decode(responseBody);
    return EstimateResponse.fromJson(responseObj);
  }
}
