// To parse this JSON data, do
//
//     final warehouseRequestResponse = warehouseRequestResponseFromJson(jsonString);

import 'dart:convert';

WarehouseRequestResponse warehouseRequestResponseFromJson(String str) => WarehouseRequestResponse.fromJson(json.decode(str));

String warehouseRequestResponseToJson(WarehouseRequestResponse data) => json.encode(data.toJson());

class WarehouseRequestResponse {
  WarehouseRequestResponse({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  int count;
  dynamic next;
  dynamic previous;
  List<WarehouseRequest> results;

  WarehouseRequestResponse copyWith({
    int count,
    dynamic next,
    dynamic previous,
    List<WarehouseRequest> results,
  }) =>
      WarehouseRequestResponse(
        count: count ?? this.count,
        next: next ?? this.next,
        previous: previous ?? this.previous,
        results: results ?? this.results,
      );

  factory WarehouseRequestResponse.fromJson(Map<String, dynamic> json) => WarehouseRequestResponse(
    count: json["count"],
    next: json["next"],
    previous: json["previous"],
    results: List<WarehouseRequest>.from(json["results"].map((x) => WarehouseRequest.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "count": count,
    "next": next,
    "previous": previous,
    "results": List<dynamic>.from(results.map((x) => x.toJson())),
  };
}

class WarehouseRequest {
  WarehouseRequest({
    this.id,
    this.count,
    this.price,
    this.status,
    this.resource,
    this.warehouse,
    this.buyer,
    this.accepted,
  });

  int id;
  int count;
  int price;
  bool status;
  int resource;
  dynamic warehouse;
  int buyer;
  dynamic accepted;

  WarehouseRequest copyWith({
    int id,
    int count,
    int price,
    bool status,
    int resource,
    dynamic warehouse,
    int buyer,
    dynamic accepted,
  }) =>
      WarehouseRequest(
        id: id ?? this.id,
        count: count ?? this.count,
        price: price ?? this.price,
        status: status ?? this.status,
        resource: resource ?? this.resource,
        warehouse: warehouse ?? this.warehouse,
        buyer: buyer ?? this.buyer,
        accepted: accepted ?? this.accepted,
      );

  factory WarehouseRequest.fromJson(Map<String, dynamic> json) => WarehouseRequest(
    id: json["id"],
    count: json["count"],
    price: json["price"],
    status: json["status"],
    resource: json["resource"],
    warehouse: json["warehouse"],
    buyer: json["buyer"],
    accepted: json["accepted"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "count": count,
    "price": price,
    "status": status,
    "resource": resource,
    "warehouse": warehouse,
    "buyer": buyer,
    "accepted": accepted,
  };
}
