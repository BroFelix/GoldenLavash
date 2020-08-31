// To parse this JSON data, do
//
//     final recipeResponse = recipeResponseFromJson(jsonString);

import 'dart:convert';

RecipeResponse recipeResponseFromJson(String str) =>
    RecipeResponse.fromJson(json.decode(str));

String recipeResponseToJson(RecipeResponse data) => json.encode(data.toJson());

class RecipeResponse {
  RecipeResponse({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  int count;
  dynamic next;
  dynamic previous;
  List<Recipe> results;

  RecipeResponse copyWith({
    int count,
    dynamic next,
    dynamic previous,
    List<Recipe> results,
  }) =>
      RecipeResponse(
        count: count ?? this.count,
        next: next ?? this.next,
        previous: previous ?? this.previous,
        results: results ?? this.results,
      );

  factory RecipeResponse.fromJson(Map<String, dynamic> json) => RecipeResponse(
        count: json["count"],
        next: json["next"],
        previous: json["previous"],
        results:
            List<Recipe>.from(json["results"].map((x) => Recipe.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "next": next,
        "previous": previous,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
      };
}

class Recipe {
  Recipe({
    this.id,
    this.count,
    this.resource,
    this.product,
  });

  int id;
  double count;
  int resource;
  int product;

  Recipe copyWith({
    int id,
    double count,
    int resource,
    int product,
  }) =>
      Recipe(
        id: id ?? this.id,
        count: count ?? this.count,
        resource: resource ?? this.resource,
        product: product ?? this.product,
      );

  factory Recipe.fromJson(Map<String, dynamic> json) => Recipe(
        id: json["id"],
        count: json["count"].toDouble(),
        resource: json["resource"],
        product: json["product"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "count": count,
        "resource": resource,
        "product": product,
      };
}
