// To parse this JSON data, do
//
//     final outlayItemResponse = outlayItemResponseFromJson(jsonString);

import 'dart:convert';

OutlayItemResponse outlayItemResponseFromJson(String str) => OutlayItemResponse.fromJson(json.decode(str));

String outlayItemResponseToJson(OutlayItemResponse data) => json.encode(data.toJson());

class OutlayItemResponse {
  OutlayItemResponse({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  int count;
  dynamic next;
  dynamic previous;
  List<OutlayItem> results;

  OutlayItemResponse copyWith({
    int count,
    dynamic next,
    dynamic previous,
    List<OutlayItem> results,
  }) =>
      OutlayItemResponse(
        count: count ?? this.count,
        next: next ?? this.next,
        previous: previous ?? this.previous,
        results: results ?? this.results,
      );

  factory OutlayItemResponse.fromJson(Map<String, dynamic> json) => OutlayItemResponse(
    count: json["count"],
    next: json["next"],
    previous: json["previous"],
    results: List<OutlayItem>.from(json["results"].map((x) => OutlayItem.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "count": count,
    "next": next,
    "previous": previous,
    "results": List<dynamic>.from(results.map((x) => x.toJson())),
  };
}

class OutlayItem {
  OutlayItem({
    this.id,
    this.title,
    this.outlayCategory,
  });

  int id;
  String title;
  int outlayCategory;

  OutlayItem copyWith({
    int id,
    String title,
    int outlayCategory,
  }) =>
      OutlayItem(
        id: id ?? this.id,
        title: title ?? this.title,
        outlayCategory: outlayCategory ?? this.outlayCategory,
      );

  factory OutlayItem.fromJson(Map<String, dynamic> json) => OutlayItem(
    id: json["id"],
    title: json["title"],
    outlayCategory: json["outlay_category"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "outlay_category": outlayCategory,
  };
}
