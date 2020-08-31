// To parse this JSON data, do
//
//     final manufactureResponse = manufactureResponseFromJson(jsonString);

import 'dart:convert';

ManufactureResponse manufactureResponseFromJson(String str) => ManufactureResponse.fromJson(json.decode(str));

String manufactureResponseToJson(ManufactureResponse data) => json.encode(data.toJson());

class ManufactureResponse {
  ManufactureResponse({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  int count;
  dynamic next;
  dynamic previous;
  List<Manufacture> results;

  ManufactureResponse copyWith({
    int count,
    dynamic next,
    dynamic previous,
    List<Manufacture> results,
  }) =>
      ManufactureResponse(
        count: count ?? this.count,
        next: next ?? this.next,
        previous: previous ?? this.previous,
        results: results ?? this.results,
      );

  factory ManufactureResponse.fromJson(Map<String, dynamic> json) => ManufactureResponse(
    count: json["count"],
    next: json["next"],
    previous: json["previous"],
    results: List<Manufacture>.from(json["results"].map((x) => Manufacture.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "count": count,
    "next": next,
    "previous": previous,
    "results": List<dynamic>.from(results.map((x) => x.toJson())),
  };
}

class Manufacture {
  Manufacture({
    this.id,
    this.resource,
    this.count,
    this.selfPrice,
    this.productTitle,
  });

  int id;
  int resource;
  int count;
  int selfPrice;
  String productTitle;

  Manufacture copyWith({
    int id,
    int resource,
    int count,
    int selfPrice,
    String productTitle,
  }) =>
      Manufacture(
        id: id ?? this.id,
        resource: resource ?? this.resource,
        count: count ?? this.count,
        selfPrice: selfPrice ?? this.selfPrice,
        productTitle: productTitle ?? this.productTitle,
      );

  factory Manufacture.fromJson(Map<String, dynamic> json) => Manufacture(
    id: json["id"],
    resource: json["resource"],
    count: json["count"],
    selfPrice: json["self_price"],
    productTitle: json["product_title"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "resource": resource,
    "count": count,
    "self_price": selfPrice,
    "product_title": productTitle,
  };
}
