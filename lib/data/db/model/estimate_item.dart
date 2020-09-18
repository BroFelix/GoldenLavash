import 'package:floor/floor.dart';
import 'package:golden_app/data/db/model/company.dart';
import 'package:golden_app/data/db/model/estimate.dart';
import 'package:golden_app/data/db/model/outlay_item.dart';
import 'package:golden_app/data/db/model/provider.dart';

@Entity(tableName: 'EstimateItem', foreignKeys: [
  ForeignKey(childColumns: ['company'], parentColumns: ['id'], entity: Company),
  ForeignKey(
      childColumns: ['estimate'], parentColumns: ['id'], entity: Estimate),
  ForeignKey(
      childColumns: ['outlayItem'], parentColumns: ['id'], entity: OutlayItem),
  ForeignKey(
    childColumns: ['provider'],
    parentColumns: ['id'],
    entity: Provider,
  ),
])
class EstimateItem {
  EstimateItem({
    this.id,
    this.count,
    this.countOld,
    this.price,
    this.priceOld,
    this.amount,
    this.status,
    this.priceUsd,
    this.rate,
    this.company,
    this.estimate,
    this.outlayItem,
    this.provider,
  });

  @primaryKey
  int id;

  int count;
  int countOld;
  int price;
  int priceOld;
  int amount;
  int status;
  double priceUsd;
  int rate;

  @ColumnInfo(name: 'company')
  int company;

  @ColumnInfo(name: 'estimate')
  int estimate;

  @ColumnInfo(name: 'outlayItem')
  int outlayItem;

  @ColumnInfo(name: 'provider')
  int provider;

  EstimateItem copyWith({
    int id,
    int count,
    int countOld,
    int price,
    int priceOld,
    int amount,
    int status,
    double priceUsd,
    int rate,
    int company,
    int estimate,
    int outlayItem,
    int provider,
  }) =>
      EstimateItem(
        id: id ?? this.id,
        count: count ?? this.count,
        countOld: countOld ?? this.countOld,
        price: price ?? this.price,
        priceOld: priceOld ?? this.priceOld,
        amount: amount ?? this.amount,
        status: status ?? this.status,
        priceUsd: priceUsd ?? this.priceUsd,
        rate: rate ?? this.rate,
        company: company ?? this.company,
        estimate: estimate ?? this.estimate,
        outlayItem: outlayItem ?? this.outlayItem,
        provider: provider ?? this.provider,
      );

  factory EstimateItem.fromJson(Map<String, dynamic> json) => EstimateItem(
        id: json["id"],
        count: json["count"],
        countOld: json["count_old"],
        price: json["price"],
        priceOld: json["price_old"],
        amount: json["amount"],
        status: json["status"],
        priceUsd: json["price_usd"],
        rate: json["rate"],
        company: json["company"],
        estimate: json["estimate"],
        outlayItem: json["outlay_item"],
        provider: json["provider"] == null ? null : json["provider"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "count": count,
        "count_old": countOld,
        "price": price,
        "price_old": priceOld,
        "amount": amount,
        "status": status,
        "price_usd": priceUsd,
        "rate": rate,
        "company": company,
        "estimate": estimate,
        "outlay_item": outlayItem,
        "provider": provider == null ? null : provider,
      };
}
