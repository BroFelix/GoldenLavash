// To parse this JSON data, do
//
//     final providerResponse = providerResponseFromJson(jsonString);

import 'dart:convert';

ProviderResponse providerResponseFromJson(String str) =>
    ProviderResponse.fromJson(json.decode(str));

String providerResponseToJson(ProviderResponse data) =>
    json.encode(data.toJson());

class ProviderResponse {
  ProviderResponse({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  int count;
  dynamic next;
  dynamic previous;
  List<Provider> results;

  ProviderResponse copyWith({
    int count,
    dynamic next,
    dynamic previous,
    List<Provider> results,
  }) =>
      ProviderResponse(
        count: count ?? this.count,
        next: next ?? this.next,
        previous: previous ?? this.previous,
        results: results ?? this.results,
      );

  factory ProviderResponse.fromJson(Map<String, dynamic> json) =>
      ProviderResponse(
        count: json["count"],
        next: json["next"],
        previous: json["previous"],
        results: List<Provider>.from(
            json["results"].map((x) => Provider.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "next": next,
        "previous": previous,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
      };
}

class Provider {
  Provider({
    this.id,
    this.name,
    this.contacts,
    this.registerDate,
    this.status,
    this.registerUser,
    this.itn,
    this.address,
    this.latitude,
    this.longitude,
  });

  int id;
  String name;
  String contacts;
  DateTime registerDate;
  bool status;
  int registerUser;
  String itn;
  String address;
  String latitude;
  String longitude;

  Provider copyWith({
    int id,
    String name,
    String contacts,
    DateTime registerDate,
    bool status,
    int registerUser,
    String itn,
    String address,
    String latitude,
    String longitude,
  }) =>
      Provider(
        id: id ?? this.id,
        name: name ?? this.name,
        contacts: contacts ?? this.contacts,
        registerDate: registerDate ?? this.registerDate,
        status: status ?? this.status,
        registerUser: registerUser ?? this.registerUser,
        itn: itn ?? this.itn,
        address: address ?? this.address,
        latitude: latitude ?? this.latitude,
        longitude: longitude ?? this.longitude,
      );

  factory Provider.fromJson(Map<String, dynamic> json) => Provider(
        id: json["id"],
        name: json["name"],
        contacts: json["contacts"],
        registerDate: DateTime.parse(json["register_date"]),
        status: json["status"],
        registerUser: json["register_user"],
        itn: json["itn"],
        address: json["address"],
        latitude: json["latitude"],
        longitude: json["longitude"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "contacts": contacts,
        "register_date": registerDate.toIso8601String(),
        "status": status,
        "register_user": registerUser,
        "itn": itn,
        "address": address,
        "latitude": latitude,
        "longitude": longitude,
      };
}
