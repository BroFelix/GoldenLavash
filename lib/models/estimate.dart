// To parse this JSON data, do
//
//     final estimateResponse = estimateResponseFromJson(jsonString);

import 'dart:convert';

EstimateResponse estimateResponseFromJson(String str) =>
    EstimateResponse.fromJson(json.decode(str));

String estimateResponseToJson(EstimateResponse data) =>
    json.encode(data.toJson());

class EstimateResponse {
  EstimateResponse({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  int count;
  dynamic next;
  dynamic previous;
  List<Estimate> results;

  EstimateResponse copyWith({
    int count,
    dynamic next,
    dynamic previous,
    List<Estimate> results,
  }) =>
      EstimateResponse(
        count: count ?? this.count,
        next: next ?? this.next,
        previous: previous ?? this.previous,
        results: results ?? this.results,
      );

  factory EstimateResponse.fromJson(Map<String, dynamic> json) =>
      EstimateResponse(
        count: json["count"],
        next: json["next"],
        previous: json["previous"],
        results: List<Estimate>.from(
            json["results"].map((x) => Estimate.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "next": next,
        "previous": previous,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
      };
}

class Estimate {
  Estimate({
    this.id,
    this.created,
    this.weekNumb,
    this.docNumb,
    this.docDateStart,
    this.docDateEnd,
    this.status,
    this.directorStatus,
    this.directorStatusDate,
    this.counterStatus,
    this.counterStatusDate,
    this.user,
    this.company,
    this.directorUser,
    this.counterUser,
  });

  int id;
  DateTime created;
  int weekNumb;
  String docNumb;
  DateTime docDateStart;
  DateTime docDateEnd;
  int status;
  int directorStatus;
  DateTime directorStatusDate;
  int counterStatus;
  DateTime counterStatusDate;
  int user;
  int company;
  int directorUser;
  int counterUser;

  Estimate copyWith({
    int id,
    DateTime created,
    int weekNumb,
    String docNumb,
    DateTime docDateStart,
    DateTime docDateEnd,
    int status,
    int directorStatus,
    DateTime directorStatusDate,
    int counterStatus,
    DateTime counterStatusDate,
    int user,
    int company,
    int directorUser,
    int counterUser,
  }) =>
      Estimate(
        id: id ?? this.id,
        created: created ?? this.created,
        weekNumb: weekNumb ?? this.weekNumb,
        docNumb: docNumb ?? this.docNumb,
        docDateStart: docDateStart ?? this.docDateStart,
        docDateEnd: docDateEnd ?? this.docDateEnd,
        status: status ?? this.status,
        directorStatus: directorStatus ?? this.directorStatus,
        directorStatusDate: directorStatusDate ?? this.directorStatusDate,
        counterStatus: counterStatus ?? this.counterStatus,
        counterStatusDate: counterStatusDate ?? this.counterStatusDate,
        user: user ?? this.user,
        company: company ?? this.company,
        directorUser: directorUser ?? this.directorUser,
        counterUser: counterUser ?? this.counterUser,
      );

  factory Estimate.fromJson(Map<String, dynamic> json) => Estimate(
        id: json["id"],
        created: DateTime.parse(json["created"]),
        weekNumb: json["week_numb"],
        docNumb: json["doc_numb"],
        docDateStart: DateTime.parse(json["doc_date_start"]),
        docDateEnd: DateTime.parse(json["doc_date_end"]),
        status: json["status"],
        directorStatus: json["director_status"],
        directorStatusDate: json["director_status_date"] == null
            ? null
            : DateTime.parse(json["director_status_date"]),
        counterStatus: json["counter_status"],
        counterStatusDate: json["counter_status_date"] == null
            ? null
            : DateTime.parse(json["counter_status_date"]),
        user: json["user"],
        company: json["company"],
        directorUser:
            json["director_user"] == null ? null : json["director_user"],
        counterUser: json["counter_user"] == null ? null : json["counter_user"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "created": created.toIso8601String(),
        "week_numb": weekNumb,
        "doc_numb": docNumb,
        "doc_date_start": docDateStart.toIso8601String(),
        "doc_date_end": docDateEnd.toIso8601String(),
        "status": status,
        "director_status": directorStatus,
        "director_status_date": directorStatusDate == null
            ? null
            : directorStatusDate.toIso8601String(),
        "counter_status": counterStatus,
        "counter_status_date": counterStatusDate == null
            ? null
            : counterStatusDate.toIso8601String(),
        "user": user,
        "company": company,
        "director_user": directorUser == null ? null : directorUser,
        "counter_user": counterUser == null ? null : counterUser,
      };
}
