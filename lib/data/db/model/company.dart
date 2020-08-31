import 'package:floor/floor.dart';

@Entity(tableName: 'Company')
class Company {
  Company({
    this.id,
    this.title,
    this.address,
    this.directorName,
    this.country,
    this.city,
  });

  @primaryKey
  int id;
  String title;
  String address;
  String directorName;
  int country;
  int city;

  Company copyWith({
    int id,
    String title,
    String address,
    String directorName,
    int country,
    int city,
  }) =>
      Company(
        id: id ?? this.id,
        title: title ?? this.title,
        address: address ?? this.address,
        directorName: directorName ?? this.directorName,
        country: country ?? this.country,
        city: city ?? this.city,
      );

  factory Company.fromJson(Map<String, dynamic> json) => Company(
        id: json["id"],
        title: json["title"],
        address: json["address"],
        directorName: json["director_name"],
        country: json["country"],
        city: json["city"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "address": address,
        "director_name": directorName,
        "country": country,
        "city": city,
      };
}
