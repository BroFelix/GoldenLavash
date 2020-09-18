import 'package:floor/floor.dart';
import 'package:golden_app/data/db/model/outlay_category.dart';

@Entity(tableName: 'OutlayItem', foreignKeys: [
  ForeignKey(
      childColumns: ['outlayCategory'],
      parentColumns: ['id'],
      entity: OutlayCategory),
])
class OutlayItem {
  OutlayItem({
    this.id,
    this.title,
    this.outlayCategory,
  });

  @primaryKey
  int id;

  String title;

  @ColumnInfo(name: 'outlayCategory', nullable: false)
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
