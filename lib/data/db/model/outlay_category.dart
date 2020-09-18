import 'package:floor/floor.dart';

@Entity(tableName: 'OutlayCategory')
class OutlayCategory {
  OutlayCategory({
    this.id,
    this.title,
  });

  @primaryKey
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
