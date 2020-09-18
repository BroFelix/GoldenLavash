// To parse this JSON data, do
//
//     final qrResponse = qrResponseFromJson(jsonString);

import 'dart:convert';

QrResponse qrResponseFromJson(String str) =>
    QrResponse.fromJson(json.decode(str));

String qrResponseToJson(QrResponse data) => json.encode(data.toJson());

class QrResponse {
  QrResponse({
    this.created,
    this.resources,
    this.workers,
    this.shift,
    this.workshop,
    this.product,
    this.deliverUser,
    this.company,
  });

  DateTime created;
  List<String> resources;
  List<String> workers;
  String shift;
  String workshop;
  String product;
  String deliverUser;
  String company;

  QrResponse copyWith({
    DateTime created,
    List<String> resources,
    dynamic workers,
    String shift,
    String workshop,
    String product,
    String deliverUser,
    String company,
  }) =>
      QrResponse(
        created: created ?? this.created,
        resources: resources ?? this.resources,
        workers: workers ?? this.workers,
        shift: shift ?? this.shift,
        workshop: workshop ?? this.workshop,
        product: product ?? this.product,
        deliverUser: deliverUser ?? this.deliverUser,
        company: company ?? this.company,
      );

  factory QrResponse.fromJson(Map<String, dynamic> json) => QrResponse(
      created: DateTime.parse(json["created"]),
      resources: List<String>.from(json["resources"].map((x) => x)),
      workers: List<String>.from(json["workers"].map((x) => x)),
      shift: json["shift"],
      workshop: json["workshop"],
      product: json["product"],
      deliverUser: json["deliver_user"],
      company: json["company"]);

  Map<String, dynamic> toJson() => {
        "created": created.toIso8601String(),
        "resources": List<dynamic>.from(resources.map((x) => x)),
        "workers": List<dynamic>.from(workers.map((x) => x)),
        "shift": shift,
        "workshop": workshop,
        "product": product,
        "deliver_user": deliverUser,
        "company": company,
      };
}
