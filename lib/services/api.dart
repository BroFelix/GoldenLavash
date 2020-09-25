import 'dart:convert';
import 'dart:core';
import 'dart:io';
import 'dart:async';

import 'package:golden_app/common/function/get_token.dart';
import 'package:golden_app/common/function/get_user.dart';
import 'package:golden_app/model/company.dart';
import 'package:golden_app/model/estimate.dart';
import 'package:golden_app/model/estimate_item.dart';
import 'package:golden_app/model/estimate_resource.dart';
import 'package:golden_app/model/outlay_category.dart';
import 'package:golden_app/model/outlay_item.dart';
import 'package:golden_app/model/product.dart';
import 'package:golden_app/model/provider.dart';
import 'package:golden_app/model/qr_response.dart';
import 'package:golden_app/model/resource.dart';
import 'package:golden_app/model/user.dart';
import 'package:http/http.dart' as http;

class ApiService {
  final apiUrl = 'http://192.168.0.115:8001/api/v1';
  final apiUrl1 = 'http://85.143.175.111:1909/api/v1';

  ApiService._();

  static ApiService _instance;

  static ApiService getInstance() {
    if (_instance == null) {
      _instance = ApiService._();
    }
    return _instance;
  }

  Future<QrResponse> getQRInfo(String id) async {
    var token = await getToken();
    var url = '$apiUrl/manufacturer_qr/get_qr/';
    final response = await http.post(url,
        headers: {'content-type': 'application/json'},
        body: utf8.encode(json.encode(<String, String>{'qr': id})));
    final responseBody = utf8.decode(response.bodyBytes);
    final responseObj = json.decode(responseBody);
    return QrResponse.fromJson(responseObj);
  }

  Future confirmEstimate(int estimateId, int directorUser) async {
    var token = await getToken();
    var url = '$apiUrl/estimate/$estimateId/director_accept/';
    final response = await http.post(
      url,
      headers: {'content-type': 'application/json'},
      body: utf8.encode(json
          .encode(<String, String>{'director_user': directorUser.toString()})),
    );
    return response;
  }

  Future cancelEstimateResource(EstimateResource resource) async {
    var token = await getToken();
    var url = '$apiUrl/estimate-resource/${resource.id}/';
    final response = await http.put(url,
        headers: {'content-type': 'application/json'},
        body: json.encode(resource.toJson()));
    return response;
  }

  Future cancelEstimateItem(EstimateItem item) async {
    var token = await getToken();
    var url = '$apiUrl/estimate-resource/${item.id}/';
    final response = await http.put(url,
        headers: {'content-type': 'application/json'},
        body: json.encode(item.toJson()));
    return response;
  }

  Future sendWarehouse(EstimateResource resource, User user) async {
    var token = await getToken();
    var url = '$apiUrl/estimate-resource/${resource.id}/income_warehouse/';
    final response = await http.post(
      url,
      headers: {'content-type': 'application/json'},
      body: utf8.encode(json.encode(<String, String>{
        'count': resource.count.toString(),
        'price': resource.price.toString(),
        'user': user.id.toString(),
        'company': resource.company.toString(),
      })),
    );
    // print(response.body);
    return response;
  }

  Future insertOutlayItem(OutlayItem item) async {
    var token = await getToken();
    var url = '$apiUrl/outlay-item/${item.id}/';
    final response = await http.put(url,
        headers: {'content-type': 'application/json'},
        body: utf8.encode(
          json.encode(item.toJson()),
        ));
    return response;
  }

  Future sendOutlayCategoryById({OutlayCategory category, int id}) async {
    var token = await getToken();
    var url = '$apiUrl/outlay-categories/$id/';
    final response = await http.put(url,
        headers: {'content-type': 'application/json'},
        body: utf8.encode(json.encode(category.toJson())));
    return response;
  }

  Future sendOutlayCategory(OutlayCategory category) async {
    var token = await getToken();
    var url = '$apiUrl/outlay-categories/';
    final response = await http.post(url,
        headers: {'content-type': 'application/json'},
        body: utf8.encode(json.encode(category.toJson())));
    return response;
  }

  Future sendOutlayItem(OutlayItem item) async {
    var token = await getToken();
    var url = '$apiUrl/outlay-items/';
    final response = await http.post(url,
        headers: {'content-type': 'application/json'},
        body: utf8.encode(json.encode(item.toJson())));
    return response;
  }

  Future sendEstimate(Estimate estimate) async {
    var token = await getToken();
    var url = '$apiUrl/estimate/';
    // print(url);
    final response = await http.post(
      url,
      headers: {'content-type': 'application/json'},
      body: utf8.encode(json.encode(estimate.toJson())),
    );
    return response;
  }

  Future sendEstimateResource(EstimateResource resource) async {
    var token = await getToken();
    var url = "$apiUrl/estimate-resource/";
    final response = await http.post(url,
        headers: {'Content-Type': 'application/json'},
        body: utf8.encode(json.encode(resource.toJson())));
    return response;
  }

  Future insertEstimateResource(EstimateResource resource) async {
    var token = await getToken();
    var url = "$apiUrl/estimate-resource/${resource.id}/";
    final response = await http.put(url,
        headers: {'Content-Type': 'application/json'},
        body: utf8.encode(json.encode(resource.toJson())));
    return response;
  }

  Future insertEstimateItem(EstimateItem item) async {
    var token = await getToken();
    var url = '$apiUrl/estimate-item/${item.id}/';
    final response = await http.put(url,
        headers: {'content-type': 'application/json'},
        body: utf8.encode(json.encode(item.toJson())));
    return response;
  }

  Future sendEstimateItem(EstimateItem item) async {
    var token = await getToken();
    var url = '$apiUrl/estimate-item/';
    final response = await http.post(url,
        headers: {'content-type': 'application/json'},
        body: utf8.encode(json.encode(item.toJson())));
    return response;
  }

  Future sendResourceById({Resource resource, int id}) async {
    var token = await getToken();
    var url = '$apiUrl/resources/$id/';
    final response = await http.put(url,
        headers: {'content-type': 'application/json'},
        body: utf8.encode(json.encode(resource.toJson())));
    return response;
  }

  Future sendResource(Resource resource) async {
    var token = await getToken();
    var url = '$apiUrl/resources/';
    final response = await http.post(url,
        headers: {'content-type': 'application/json'},
        body: utf8.encode(json.encode(resource.toJson())));
    return response;
  }

  Future sendProviderById({Provider provider, int id}) async {
    var url = '$apiUrl/providers/$id/';
    final response = await http.put(url,
        headers: {'content-type': 'application/json'},
        body: utf8.encode(json.encode(provider.toJson())));
    print('provider response ${response.body}');
    return response;
  }

  Future sendProvider(Provider provider) async {
    var token = await getToken();
    var url = '$apiUrl/providers/';
    final response = await http.post(url,
        headers: {'content-type': 'application/json'},
        body: utf8.encode(json.encode(provider.toJson())));
    // print(json.encode(utf8.encode(response.bodyBytes.toString())));
    return response;
  }

  Future sendProduct(Product product) async {
    var token = await getToken();
    var url = '$apiUrl/';
    final response = await http.post(url,
        headers: {'Content-Type': 'application/json'},
        body: utf8.encode(json.encode(product.toJson())));
    return response;
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

  Future<ProviderResponse> getProvider({String pageUrl}) async {
    var token = await getToken();
    var url = '$apiUrl/providers/';
    final response = await http
        .get(url, headers: {HttpHeaders.authorizationHeader: 'JWT $token'});
    final responseBody = utf8.decode(response.bodyBytes);
    final responseObj = json.decode(responseBody);
    return ProviderResponse.fromJson(responseObj);
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

  Future<List<EstimateResource>> getEstimateResourcesById(int id) async {
    var token = await getToken();
    var url = "$apiUrl/estimate-resource/";
    final response = await http
        .get(url, headers: {HttpHeaders.authorizationHeader: 'JWT $token'});
    final responseBody = utf8.decode(response.bodyBytes);
    final responseObj = json.decode(responseBody);
    var tmp = EstimateResourceResponse.fromJson(responseObj);
    tmp.results.removeWhere((element) => element.estimate != id);
    return tmp.results;
  }

  Future<List<EstimateItem>> getEstimateItemById(int id) async {
    var token = await getToken();
    var url = "$apiUrl/estimate-item/";
    final response = await http
        .get(url, headers: {HttpHeaders.authorizationHeader: 'JWT $token'});
    final responseBody = utf8.decode(response.bodyBytes);
    final responseObj = json.decode(responseBody);
    var tmp = EstimateItemResponse.fromJson(responseObj);
    tmp.results.removeWhere((element) => element.estimate != id);
    return tmp.results;
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

  Future<EstimateItemResponse> getEstimateItem() async {
    var token = await getToken();
    var url = "$apiUrl/estimate-item/";
    final response = await http
        .get(url, headers: {HttpHeaders.authorizationHeader: 'JWT $token'});
    final responseBody = utf8.decode(response.bodyBytes);
    final responseObj = json.decode(responseBody);
    return EstimateItemResponse.fromJson(responseObj);
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

  Future deleteOutlayItem(int id) async {
    var token = await getToken();
    var url = '$apiUrl/outlay-items/$id/';
    final response = await http.delete(url);
    print(response.body);
    return response;
  }
}
