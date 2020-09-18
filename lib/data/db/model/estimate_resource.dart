import 'package:floor/floor.dart';
import 'package:golden_app/data/db/model/company.dart';
import 'package:golden_app/data/db/model/estimate.dart';
import 'package:golden_app/data/db/model/provider.dart';
import 'package:golden_app/data/db/model/resource.dart';

@Entity(tableName: 'EstimateResource', foreignKeys: [
  ForeignKey(childColumns: ['company'], parentColumns: ['id'], entity: Company),
  ForeignKey(
      childColumns: ['estimate'], parentColumns: ['id'], entity: Estimate),
  ForeignKey(
      childColumns: ['provider'], parentColumns: ['id'], entity: Provider),
  ForeignKey(
      childColumns: ['resource'], parentColumns: ['id'], entity: Resource),
])
class EstimateResource {
  EstimateResource({
    this.id,
    this.count,
    this.countOld,
    this.price,
    this.amount,
    this.status,
    this.sendWarehouse,
    this.acceptedWarehouse,
    this.priceUsd,
    this.rate,
    this.company,
    this.estimate,
    this.resource,
    this.provider,
  });

  @primaryKey
  int id;
  int count;
  int countOld;
  int price;
  int amount;
  int status;
  bool sendWarehouse;
  bool acceptedWarehouse;
  double priceUsd;
  int rate;

  @ColumnInfo(name: 'company')
  int company;

  @ColumnInfo(name: 'estimate')
  int estimate;

  @ColumnInfo(name: 'resource')
  int resource;

  @ColumnInfo(name: 'provider')
  int provider;

  EstimateResource copyWith({
    int id,
    int count,
    int countOld,
    int price,
    int amount,
    int status,
    bool sendWarehouse,
    bool acceptedWarehouse,
    double priceUsd,
    int rate,
    int company,
    int estimate,
    int resource,
    int provider,
  }) =>
      EstimateResource(
        id: id ?? this.id,
        count: count ?? this.count,
        countOld: countOld ?? this.countOld,
        price: price ?? this.price,
        amount: amount ?? this.amount,
        status: status ?? this.status,
        sendWarehouse: sendWarehouse ?? this.sendWarehouse,
        acceptedWarehouse: acceptedWarehouse ?? this.acceptedWarehouse,
        priceUsd: priceUsd ?? this.priceUsd,
        rate: rate ?? this.rate,
        company: company ?? this.company,
        estimate: estimate ?? this.estimate,
        resource: resource ?? this.resource,
        provider: provider ?? this.provider,
      );

  factory EstimateResource.fromJson(Map<String, dynamic> json) =>
      EstimateResource(
        id: json["id"],
        count: json["count"],
        countOld: json["count_old"],
        price: json["price"],
        amount: json["amount"],
        status: json["status"],
        sendWarehouse: json["send_warehouse"],
        acceptedWarehouse: json["accepted_warehouse"],
        priceUsd: json["price_usd"],
        rate: json["rate"],
        company: json["company"],
        estimate: json["estimate"],
        resource: json["resource"],
        provider: json["provider"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "count": count,
        "count_old": countOld,
        "price": price,
        "amount": amount,
        "status": status,
        "send_warehouse": sendWarehouse,
        "accepted_warehouse": acceptedWarehouse,
        "price_usd": priceUsd,
        "rate": rate,
        "company": company,
        "estimate": estimate,
        "resource": resource,
        "provider": provider,
      };
}
