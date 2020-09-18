// To parse this JSON data, do
//
//     final warehouseResponse = warehouseResponseFromJson(jsonString);

import 'dart:convert';

WarehouseResponse warehouseResponseFromJson(String str) => WarehouseResponse.fromJson(json.decode(str));

String warehouseResponseToJson(WarehouseResponse data) => json.encode(data.toJson());

class WarehouseResponse {
  WarehouseResponse({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  int count;
  dynamic next;
  dynamic previous;
  List<Warehouse> results;

  WarehouseResponse copyWith({
    int count,
    dynamic next,
    dynamic previous,
    List<Warehouse> results,
  }) =>
      WarehouseResponse(
        count: count ?? this.count,
        next: next ?? this.next,
        previous: previous ?? this.previous,
        results: results ?? this.results,
      );

  factory WarehouseResponse.fromJson(Map<String, dynamic> json) => WarehouseResponse(
    count: json["count"],
    next: json["next"],
    previous: json["previous"],
    results: List<Warehouse>.from(json["results"].map((x) => Warehouse.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "count": count,
    "next": next,
    "previous": previous,
    "results": List<dynamic>.from(results.map((x) => x.toJson())),
  };
}

class Warehouse {
  Warehouse({
    this.id,
    this.created,
    this.uniqueCode,
    this.qrCode,
    this.type,
    this.title,
    this.company,
  });

  int id;
  DateTime created;
  String uniqueCode;
  String qrCode;
  int type;
  String title;
  int company;

  Warehouse copyWith({
    int id,
    DateTime created,
    String uniqueCode,
    String qrCode,
    int type,
    String title,
    int company,
  }) =>
      Warehouse(
        id: id ?? this.id,
        created: created ?? this.created,
        uniqueCode: uniqueCode ?? this.uniqueCode,
        qrCode: qrCode ?? this.qrCode,
        type: type ?? this.type,
        title: title ?? this.title,
        company: company ?? this.company,
      );

  factory Warehouse.fromJson(Map<String, dynamic> json) => Warehouse(
    id: json["id"],
    created: DateTime.parse(json["created"]),
    uniqueCode: json["unique_code"],
    qrCode: json["qr_code"],
    type: json["type"],
    title: json["title"],
    company: json["company"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "created": "${created.year.toString().padLeft(4, '0')}-${created.month.toString().padLeft(2, '0')}-${created.day.toString().padLeft(2, '0')}",
    "unique_code": uniqueCode,
    "qr_code": qrCode,
    "type": type,
    "title": title,
    "company": company,
  };
}
