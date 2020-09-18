// To parse this JSON data, do
//
//     final companyResponse = companyResponseFromJson(jsonString);

import 'dart:convert';

CompanyResponse companyResponseFromJson(String str) => CompanyResponse.fromJson(json.decode(str));

String companyResponseToJson(CompanyResponse data) => json.encode(data.toJson());

class CompanyResponse {
  CompanyResponse({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  int count;
  dynamic next;
  dynamic previous;
  List<Company> results;

  CompanyResponse copyWith({
    int count,
    dynamic next,
    dynamic previous,
    List<Company> results,
  }) =>
      CompanyResponse(
        count: count ?? this.count,
        next: next ?? this.next,
        previous: previous ?? this.previous,
        results: results ?? this.results,
      );

  factory CompanyResponse.fromJson(Map<String, dynamic> json) => CompanyResponse(
    count: json["count"],
    next: json["next"],
    previous: json["previous"],
    results: List<Company>.from(json["results"].map((x) => Company.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "count": count,
    "next": next,
    "previous": previous,
    "results": List<dynamic>.from(results.map((x) => x.toJson())),
  };
}

class Company {
  Company({
    this.id,
    this.title,
    this.address,
    this.directorName,
    this.country,
    this.city,
  });

  int id;
  String title;
  String address;
  String directorName;
  int country;
  int city;

  Company copyWith({
    int id,
    String title,
    String address,
    String directorName,
    int country,
    int city,
  }) =>
      Company(
        id: id ?? this.id,
        title: title ?? this.title,
        address: address ?? this.address,
        directorName: directorName ?? this.directorName,
        country: country ?? this.country,
        city: city ?? this.city,
      );

  factory Company.fromJson(Map<String, dynamic> json) => Company(
    id: json["id"],
    title: json["title"],
    address: json["address"],
    directorName: json["director_name"],
    country: json["country"],
    city: json["city"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "address": address,
    "director_name": directorName,
    "country": country,
    "city": city,
  };
}
