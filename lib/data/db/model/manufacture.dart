import 'package:floor/floor.dart';
import 'package:golden_app/data/db/model/resource.dart';

@Entity(tableName: 'Manufacture', foreignKeys: [
  ForeignKey(
      childColumns: ['resource'], parentColumns: ['id'], entity: Resource)
])
class Manufacture {
  Manufacture({
    this.id,
    this.resource,
    this.count,
    this.selfPrice,
    this.productTitle,
  });

  @primaryKey
  int id;

  @ColumnInfo(name: 'resource')
  int resource;

  int count;
  int selfPrice;
  String productTitle;

  Manufacture copyWith({
    int id,
    int resource,
    int count,
    int selfPrice,
    String productTitle,
  }) =>
      Manufacture(
        id: id ?? this.id,
        resource: resource ?? this.resource,
        count: count ?? this.count,
        selfPrice: selfPrice ?? this.selfPrice,
        productTitle: productTitle ?? this.productTitle,
      );

  factory Manufacture.fromJson(Map<String, dynamic> json) => Manufacture(
        id: json["id"],
        resource: json["resource"],
        count: json["count"],
        selfPrice: json["self_price"],
        productTitle: json["product_title"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "resource": resource,
        "count": count,
        "self_price": selfPrice,
        "product_title": productTitle,
      };
}
