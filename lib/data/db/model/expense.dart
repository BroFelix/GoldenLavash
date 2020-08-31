import 'package:floor/floor.dart';
import 'package:golden_app/data/db/model/company.dart';
import 'package:golden_app/data/db/model/estimate.dart';
import 'package:golden_app/data/db/model/provider.dart';
import 'package:golden_app/data/db/model/resource.dart';


@Entity(tableName: 'Expense', foreignKeys: [
  ForeignKey(childColumns: ['company'], parentColumns: ['id'], entity: Company),
  ForeignKey(
      childColumns: ['estimate'], parentColumns: ['id'], entity: Estimate),
  ForeignKey(
      childColumns: ['resource'], parentColumns: ['id'], entity: Resource),
  ForeignKey(
      childColumns: ['provider'], parentColumns: ['id'], entity: Provider),
])
class Expense {
  Expense({
    this.id,
    this.count,
    this.countOld,
    this.price,
    this.amount,
    this.status,
    this.sendWarehouse,
    this.acceptedWarehouse,
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

  @ColumnInfo(name: 'company')
  int company;

  @ColumnInfo(name: 'estimate')
  int estimate;

  @ColumnInfo(name: 'resource')
  int resource;

  @ColumnInfo(name: 'provider')
  int provider;

  Expense copyWith({
    int id,
    int count,
    int countOld,
    int price,
    int amount,
    int status,
    bool sendWarehouse,
    bool acceptedWarehouse,
    int company,
    int estimate,
    int resource,
    int provider,
  }) =>
      Expense(
        id: id ?? this.id,
        count: count ?? this.count,
        countOld: countOld ?? this.countOld,
        price: price ?? this.price,
        amount: amount ?? this.amount,
        status: status ?? this.status,
        sendWarehouse: sendWarehouse ?? this.sendWarehouse,
        acceptedWarehouse: acceptedWarehouse ?? this.acceptedWarehouse,
        company: company ?? this.company,
        estimate: estimate ?? this.estimate,
        resource: resource ?? this.resource,
        provider: provider ?? this.provider,
      );

  factory Expense.fromJson(Map<String, dynamic> json) => Expense(
        id: json["id"],
        count: json["count"],
        countOld: json["count_old"],
        price: json["price"],
        amount: json["amount"],
        status: json["status"],
        sendWarehouse: json["send_warehouse"],
        acceptedWarehouse: json["accepted_warehouse"],
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
        "company": company,
        "estimate": estimate,
        "resource": resource,
        "provider": provider,
      };
}
