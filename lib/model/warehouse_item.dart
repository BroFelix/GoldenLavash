// To parse this JSON data, do
//
//     final warehouseItemResponse = warehouseItemResponseFromJson(jsonString);

import 'dart:convert';

WarehouseItemResponse warehouseItemResponseFromJson(String str) => WarehouseItemResponse.fromJson(json.decode(str));

String warehouseItemResponseToJson(WarehouseItemResponse data) => json.encode(data.toJson());

class WarehouseItemResponse {
  WarehouseItemResponse({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  int count;
  dynamic next;
  dynamic previous;
  List<WarehouseItem> results;

  WarehouseItemResponse copyWith({
    int count,
    dynamic next,
    dynamic previous,
    List<WarehouseItem> results,
  }) =>
      WarehouseItemResponse(
        count: count ?? this.count,
        next: next ?? this.next,
        previous: previous ?? this.previous,
        results: results ?? this.results,
      );

  factory WarehouseItemResponse.fromJson(Map<String, dynamic> json) => WarehouseItemResponse(
    count: json["count"],
    next: json["next"],
    previous: json["previous"],
    results: List<WarehouseItem>.from(json["results"].map((x) => WarehouseItem.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "count": count,
    "next": next,
    "previous": previous,
    "results": List<dynamic>.from(results.map((x) => x.toJson())),
  };
}

class WarehouseItem {
  WarehouseItem({
    this.id,
    this.count,
    this.selfPrice,
    this.resource,
    this.warehouse,
  });

  int id;
  int count;
  int selfPrice;
  int resource;
  int warehouse;

  WarehouseItem copyWith({
    int id,
    int count,
    int selfPrice,
    int resource,
    int warehouse,
  }) =>
      WarehouseItem(
        id: id ?? this.id,
        count: count ?? this.count,
        selfPrice: selfPrice ?? this.selfPrice,
        resource: resource ?? this.resource,
        warehouse: warehouse ?? this.warehouse,
      );

  factory WarehouseItem.fromJson(Map<String, dynamic> json) => WarehouseItem(
    id: json["id"],
    count: json["count"],
    selfPrice: json["self_price"],
    resource: json["resource"],
    warehouse: json["warehouse"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "count": count,
    "self_price": selfPrice,
    "resource": resource,
    "warehouse": warehouse,
  };
}
