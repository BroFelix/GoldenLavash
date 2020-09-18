// To parse this JSON data, do
//
//     final productResponse = productResponseFromJson(jsonString);

import 'dart:convert';

ProductResponse productResponseFromJson(String str) => ProductResponse.fromJson(json.decode(str));

String productResponseToJson(ProductResponse data) => json.encode(data.toJson());

class ProductResponse {
  ProductResponse({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  int count;
  dynamic next;
  dynamic previous;
  List<Product> results;

  ProductResponse copyWith({
    int count,
    dynamic next,
    dynamic previous,
    List<Product> results,
  }) =>
      ProductResponse(
        count: count ?? this.count,
        next: next ?? this.next,
        previous: previous ?? this.previous,
        results: results ?? this.results,
      );

  factory ProductResponse.fromJson(Map<String, dynamic> json) => ProductResponse(
    count: json["count"],
    next: json["next"],
    previous: json["previous"],
    results: List<Product>.from(json["results"].map((x) => Product.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "count": count,
    "next": next,
    "previous": previous,
    "results": List<dynamic>.from(results.map((x) => x.toJson())),
  };
}

class Product {
  Product({
    this.id,
    this.title,
    this.code,
    this.price,
    this.boxCount,
    this.company,
  });

  int id;
  String title;
  String code;
  int price;
  int boxCount;
  int company;

  Product copyWith({
    int id,
    String title,
    String code,
    int price,
    int boxCount,
    int company,
  }) =>
      Product(
        id: id ?? this.id,
        title: title ?? this.title,
        code: code ?? this.code,
        price: price ?? this.price,
        boxCount: boxCount ?? this.boxCount,
        company: company ?? this.company,
      );

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["id"],
    title: json["title"],
    code: json["code"],
    price: json["price"],
    boxCount: json["box_count"],
    company: json["company"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "code": code,
    "price": price,
    "box_count": boxCount,
    "company": company,
  };
}
