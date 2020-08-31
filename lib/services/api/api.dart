import 'dart:convert';
import 'dart:core';
import 'dart:io';

import 'package:golden_app/common/function/get_token.dart';
import 'package:golden_app/models/company.dart';
import 'package:golden_app/models/estimate.dart';
import 'package:golden_app/models/estimate_item.dart';
import 'package:golden_app/models/estimate_resource.dart';
import 'package:golden_app/models/manufacture.dart';
import 'package:golden_app/models/outlay_category.dart';
import 'package:golden_app/models/outlay_item.dart';
import 'package:golden_app/models/product.dart';
import 'package:golden_app/models/provider.dart';
import 'package:golden_app/models/resource.dart';
import 'package:golden_app/models/user.dart';
import 'package:http/http.dart' as http;

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

  Future sendWarehouse(EstimateResource resource) async {
    var token = await getToken();
    var url = '$apiUrl/estimate-resource/${resource.id}/income_warehouse/';
    await http.post(url,
        headers: {HttpHeaders.authorizationHeader: 'JWT $token'},
        body: jsonEncode(<String, String>{
          'count': resource.countOld.toString(),
          'price': resource.price.toString(),
          'estimate': resource.estimate.toString(),
        }));
  }

  void addResource(EstimateResource resource) async {
    var token = await getToken();
    var url = "$apiUrl";
    await http.post(url,
        headers: {HttpHeaders.authorizationHeader: 'JWT $token'},
        body: resource.toJson());
  }

  Future<CompanyResponse> getCompany() async {
    var token = await getToken();
    var url = '$apiUrl/companies/';
    final response = await http
        .get(url, headers: {HttpHeaders.authorizationHeader: 'JWT $token'});
    final responseBody = utf8.decode(response.bodyBytes);
    final responseObj = json.decode(responseBody);
    return CompanyResponse.fromJson(responseObj);
  }

  Future<ProviderResponse> getProvider() async {
    var token = await getToken();
    var url = '$apiUrl/providers/';
    final response = await http
        .get(url, headers: {HttpHeaders.authorizationHeader: 'JWT $token'});
    final responseBody = utf8.decode(response.bodyBytes);
    final responseObj = json.decode(responseBody);
    return ProviderResponse.fromJson(responseObj);
  }

  Future<UserResponse> getUser() async {
    String username = 'admin';
    String password = 'adminadmin';
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));
    print(basicAuth);
    var url = "$apiUrl/user/";
    final response = await http
        .get(url, headers: <String, String>{'authorization': basicAuth});
    final responseBody = utf8.decode(response.bodyBytes);
    final responseObj = json.decode(responseBody);
    return UserResponse.fromJson(responseObj);
  }

  Future<ManufactureResponse> getManufacture() async {
    var token = await getToken();
    var url = "$apiUrl/manufacturer_warehouse/";
    final response = await http
        .get(url, headers: {HttpHeaders.authorizationHeader: 'JWT $token'});
    final responseBody = utf8.decode(response.bodyBytes);
    final responseObj = json.decode(responseBody);
    return ManufactureResponse.fromJson(responseObj);
  }

  Future<ProductResponse> getProducts() async {
    var token = await getToken();
    var url = "$apiUrl/products/";
    final response = await http
        .get(url, headers: {HttpHeaders.authorizationHeader: 'JWT $token'});
    final responseBody = utf8.decode(response.bodyBytes);
    final responseObj = json.decode(responseBody);
    return ProductResponse.fromJson(responseObj);
  }

  Future<EstimateItemResponse> getEstimateItem() async {
    var token = await getToken();
    var url = "$apiUrl/estimate-item/";
    final response = await http
        .get(url, headers: {HttpHeaders.authorizationHeader: 'JWT $token'});
    final responseBody = utf8.decode(response.bodyBytes);
    final responseObj = json.decode(responseBody);
    return EstimateItemResponse.fromJson(responseObj);
  }

  Future<OutlayCategoryResponse> getOutlayCategory() async {
    var token = await getToken();
    var url = "$apiUrl/outlay-categories/";
    final response = await http
        .get(url, headers: {HttpHeaders.authorizationHeader: 'JWT $token'});
    final responseBody = utf8.decode(response.bodyBytes);
    final responseObj = json.decode(responseBody);
    return OutlayCategoryResponse.fromJson(responseObj);
  }

  Future<OutlayItemResponse> getOutlayItem() async {
    var token = await getToken();
    var url = "$apiUrl/outlay-items/";
    final response = await http
        .get(url, headers: {HttpHeaders.authorizationHeader: 'JWT $token'});
    final responseBody = utf8.decode(response.bodyBytes);
    final responseObj = json.decode(responseBody);
    return OutlayItemResponse.fromJson(responseObj);
  }

  Future<EstimateResourceResponse> getEstimateResources() async {
    var token = await getToken();
    var url = "$apiUrl/estimate-resource/";
    final response = await http
        .get(url, headers: {HttpHeaders.authorizationHeader: 'JWT $token'});
    final responseBody = utf8.decode(response.bodyBytes);
    final responseObj = json.decode(responseBody);
    return EstimateResourceResponse.fromJson(responseObj);
  }

  Future<ResourceResponse> getResource() async {
    var token = await getToken();
    var url = "$apiUrl/resources/";
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
