// To parse this JSON data, do
//
//     final resourceResponse = resourceResponseFromJson(jsonString);

import 'dart:convert';

ResourceResponse resourceResponseFromJson(String str) => ResourceResponse.fromJson(json.decode(str));

String resourceResponseToJson(ResourceResponse data) => json.encode(data.toJson());

class ResourceResponse {
  ResourceResponse({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  int count;
  dynamic next;
  dynamic previous;
  List<Resource> results;

  ResourceResponse copyWith({
    int count,
    dynamic next,
    dynamic previous,
    List<Resource> results,
  }) =>
      ResourceResponse(
        count: count ?? this.count,
        next: next ?? this.next,
        previous: previous ?? this.previous,
        results: results ?? this.results,
      );

  factory ResourceResponse.fromJson(Map<String, dynamic> json) => ResourceResponse(
    count: json["count"],
    next: json["next"],
    previous: json["previous"],
    results: List<Resource>.from(json["results"].map((x) => Resource.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "count": count,
    "next": next,
    "previous": previous,
    "results": List<dynamic>.from(results.map((x) => x.toJson())),
  };
}

class Resource {
  Resource({
    this.id,
    this.title,
    this.editType,
    this.resourceType,
  });

  int id;
  String title;
  int editType;
  String resourceType;

  Resource copyWith({
    int id,
    String title,
    int editType,
    String resourceType,
  }) =>
      Resource(
        id: id ?? this.id,
        title: title ?? this.title,
        editType: editType ?? this.editType,
        resourceType: resourceType ?? this.resourceType,
      );

  factory Resource.fromJson(Map<String, dynamic> json) => Resource(
    id: json["id"],
    title: json["title"],
    editType: json["edit_type"],
    resourceType: json["resource_type"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "edit_type": editType,
    "resource_type": resourceType,
  };
}
