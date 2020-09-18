// To parse this JSON data, do
//
//     final estimateItemResponse = estimateItemResponseFromJson(jsonString);

import 'dart:convert';

EstimateItemResponse estimateItemResponseFromJson(String str) =>
    EstimateItemResponse.fromJson(json.decode(str));

String estimateItemResponseToJson(EstimateItemResponse data) =>
    json.encode(data.toJson());

class EstimateItemResponse {
  EstimateItemResponse({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  int count;
  dynamic next;
  dynamic previous;
  List<EstimateItem> results;

  EstimateItemResponse copyWith({
    int count,
    dynamic next,
    dynamic previous,
    List<EstimateItem> results,
  }) =>
      EstimateItemResponse(
        count: count ?? this.count,
        next: next ?? this.next,
        previous: previous ?? this.previous,
        results: results ?? this.results,
      );

  factory EstimateItemResponse.fromJson(Map<String, dynamic> json) =>
      EstimateItemResponse(
        count: json["count"],
        next: json["next"],
        previous: json["previous"],
        results: List<EstimateItem>.from(
            json["results"].map((x) => EstimateItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "next": next,
        "previous": previous,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
      };
}

class EstimateItem {
  EstimateItem({
    this.id,
    this.count,
    this.countOld,
    this.price,
    this.priceOld,
    this.amount,
    this.status,
    this.priceUsd,
    this.rate,
    this.company,
    this.estimate,
    this.outlayItem,
    this.provider,
  });

  int id;
  int count;
  int countOld;
  int price;
  int priceOld;
  int amount;
  int status;
  double priceUsd;
  int rate;
  int company;
  int estimate;
  int outlayItem;
  int provider;

  EstimateItem copyWith({
    int id,
    int count,
    int countOld,
    int price,
    int priceOld,
    int amount,
    int status,
    int company,
    int estimate,
    int outlayItem,
    int provider,
  }) =>
      EstimateItem(
        id: id ?? this.id,
        count: count ?? this.count,
        countOld: countOld ?? this.countOld,
        price: price ?? this.price,
        priceOld: priceOld ?? this.priceOld,
        amount: amount ?? this.amount,
        status: status ?? this.status,
        priceUsd: priceUsd ?? this.priceUsd,
        rate: rate ?? this.rate,
        company: company ?? this.company,
        estimate: estimate ?? this.estimate,
        outlayItem: outlayItem ?? this.outlayItem,
        provider: provider ?? this.provider,
      );

  factory EstimateItem.fromJson(Map<String, dynamic> json) => EstimateItem(
        id: json["id"],
        count: json["count"],
        countOld: json["count_old"],
        price: json["price"],
        priceOld: json["price_old"],
        amount: json["amount"],
        status: json["status"],
        priceUsd: json["price_usd"],
        rate: json["rate"],
        company: json["company"],
        estimate: json["estimate"],
        outlayItem: json["outlay_item"],
        provider: json["provider"] == null ? null : json["provider"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "count": count,
        "count_old": countOld,
        "price": price,
        "price_old": priceOld,
        "amount": amount,
        "status": status,
        "price_usd": priceUsd,
        "rate": rate,
        "company": company,
        "estimate": estimate,
        "outlay_item": outlayItem,
        "provider": provider == null ? null : provider,
      };
}
