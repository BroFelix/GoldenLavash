// To parse this JSON data, do
//
//     final shiftResponse = shiftResponseFromJson(jsonString);

import 'dart:convert';

ShiftResponse shiftResponseFromJson(String str) =>
    ShiftResponse.fromJson(json.decode(str));

String shiftResponseToJson(ShiftResponse data) => json.encode(data.toJson());

class ShiftResponse {
  ShiftResponse({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  int count;
  dynamic next;
  dynamic previous;
  List<Shift> results;

  ShiftResponse copyWith({
    int count,
    dynamic next,
    dynamic previous,
    List<Shift> results,
  }) =>
      ShiftResponse(
        count: count ?? this.count,
        next: next ?? this.next,
        previous: previous ?? this.previous,
        results: results ?? this.results,
      );

  factory ShiftResponse.fromJson(Map<String, dynamic> json) => ShiftResponse(
        count: json["count"],
        next: json["next"],
        previous: json["previous"],
        results:
            List<Shift>.from(json["results"].map((x) => Shift.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "next": next,
        "previous": previous,
        "results": List<Shift>.from(results.map((x) => x.toJson())),
      };
}

class Shift {
  Shift({this.title, this.startTime, this.endTime});

  String title;
  DateTime startTime;
  DateTime endTime;

  Shift copyWith({
    String title,
    DateTime startTime,
    DateTime endTime,
  }) =>
      Shift(
        title: title ?? this.title,
        startTime: startTime ?? this.startTime,
        endTime: endTime ?? this.endTime,
      );

  factory Shift.fromJson(Map<String, dynamic> json) => Shift(
        title: json['title'],
        startTime: json['startTime'],
        endTime: json['endTime'],
      );

  Map<String, dynamic> toJson() => {
        "title": this.title,
        "startTime": this.startTime,
        "endTime": this.endTime,
      };
}
