import 'package:floor/floor.dart';

@Entity(tableName: 'Product')
class Product {
  Product({
    this.id,
    this.title,
    this.code,
    this.price,
    this.boxCount,
    this.company,
  });

  @primaryKey
  int id;
  String title;
  String code;
  int price;
  int boxCount;
  int company;

  Product copyWith({
    int id,
    String title,
    String code,
    int price,
    int boxCount,
    int company,
  }) =>
      Product(
        id: id ?? this.id,
        title: title ?? this.title,
        code: code ?? this.code,
        price: price ?? this.price,
        boxCount: boxCount ?? this.boxCount,
        company: company ?? this.company,
      );

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["id"],
    title: json["title"],
    code: json["code"],
    price: json["price"],
    boxCount: json["box_count"],
    company: json["company"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "code": code,
    "price": price,
    "box_count": boxCount,
    "company": company,
  };
}
