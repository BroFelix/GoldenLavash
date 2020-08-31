import 'package:floor/floor.dart';
import 'package:golden_app/data/db/model/company.dart';

@Entity(tableName: 'Estimate', foreignKeys: [
  ForeignKey(childColumns: ['company'], parentColumns: ['id'], entity: Company),
])
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

  @primaryKey
  int id;

  String created;
  int weekNumb;
  String docNumb;
  String docDateStart;
  String docDateEnd;
  int status;
  int directorStatus;
  String directorStatusDate;
  int counterStatus;
  String counterStatusDate;
  int user;

  @ColumnInfo(name: 'company')
  int company;

  int directorUser;
  int counterUser;

  Estimate copyWith({
    int id,
    String created,
    int weekNumb,
    String docNumb,
    String docDateStart,
    String docDateEnd,
    int status,
    int directorStatus,
    String directorStatusDate,
    int counterStatus,
    String counterStatusDate,
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
        created: json["created"] != null ? json["created"] : "",
        weekNumb: json["week_numb"] ?? json["week_numb"],
        docNumb: json["doc_numb"],
        docDateStart: (json["doc_date_start"]),
        docDateEnd: (json["doc_date_end"]),
        status: json["status"],
        directorStatus: json["director_status"],
        directorStatusDate: json["director_status_date"] == null
            ? 'null'
            : (json["director_status_date"]),
        counterStatus: json["counter_status"],
        counterStatusDate: json["counter_status_date"] == null
            ? 'null'
            : (json["counter_status_date"]),
        user: json["user"],
        company: json["company"],
        directorUser: json["director_user"] == null ? 0 : json["director_user"],
        counterUser: json["counter_user"] == null ? 0 : json["counter_user"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "created": created,
        "week_numb": weekNumb,
        "doc_numb": docNumb,
        "doc_date_start": docDateStart,
        "doc_date_end": docDateEnd,
        "status": status,
        "director_status": directorStatus,
        "director_status_date":
            directorStatusDate == null ? 0 : directorStatusDate,
        "counter_status": counterStatus,
        "counter_status_date":
            counterStatusDate == null ? null : counterStatusDate,
        "user": user,
        "company": company,
        "director_user": directorUser == null ? null : directorUser,
        "counter_user": counterUser == null ? null : counterUser,
      };
}
