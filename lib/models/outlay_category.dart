// To parse this JSON data, do
//
//     final outlayCategoryResponse = outlayCategoryResponseFromJson(jsonString);

import 'dart:convert';

OutlayCategoryResponse outlayCategoryResponseFromJson(String str) => OutlayCategoryResponse.fromJson(json.decode(str));

String outlayCategoryResponseToJson(OutlayCategoryResponse data) => json.encode(data.toJson());

class OutlayCategoryResponse {
  OutlayCategoryResponse({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  int count;
  dynamic next;
  dynamic previous;
  List<OutlayCategory> results;

  OutlayCategoryResponse copyWith({
    int count,
    dynamic next,
    dynamic previous,
    List<OutlayCategory> results,
  }) =>
      OutlayCategoryResponse(
        count: count ?? this.count,
        next: next ?? this.next,
        previous: previous ?? this.previous,
        results: results ?? this.results,
      );

  factory OutlayCategoryResponse.fromJson(Map<String, dynamic> json) => OutlayCategoryResponse(
    count: json["count"],
    next: json["next"],
    previous: json["previous"],
    results: List<OutlayCategory>.from(json["results"].map((x) => OutlayCategory.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "count": count,
    "next": next,
    "previous": previous,
    "results": List<dynamic>.from(results.map((x) => x.toJson())),
  };
}

class OutlayCategory {
  OutlayCategory({
    this.id,
    this.title,
  });

  int id;
  String title;

  OutlayCategory copyWith({
    int id,
    String title,
  }) =>
      OutlayCategory(
        id: id ?? this.id,
        title: title ?? this.title,
      );

  factory OutlayCategory.fromJson(Map<String, dynamic> json) => OutlayCategory(
    id: json["id"],
    title: json["title"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
  };
}
