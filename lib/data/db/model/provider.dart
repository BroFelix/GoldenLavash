import 'package:floor/floor.dart';

@Entity(tableName: 'Provider')
class Provider {
  Provider({
    this.id,
    this.name,
    this.contacts,
    this.registerDate,
    this.status,
    this.registerUser,
    this.itn,
    this.address,
    this.latitude,
    this.longitude,
  });

  @primaryKey
  int id;
  String name;
  String contacts;
  String registerDate;
  bool status;
  int registerUser;
  String itn;
  String address;
  String latitude;
  String longitude;

  Provider copyWith({
    int id,
    String name,
    String contacts,
    DateTime registerDate,
    bool status,
    int registerUser,
    String latitude,
    String longitude,
  }) =>
      Provider(
        id: id ?? this.id,
        name: name ?? this.name,
        contacts: contacts ?? this.contacts,
        registerDate: registerDate ?? this.registerDate,
        status: status ?? this.status,
        registerUser: registerUser ?? this.registerUser,
        itn: itn ?? this.itn,
        address: address ?? this.address,
        latitude: latitude ?? this.latitude,
        longitude: longitude ?? this.longitude,
      );

  factory Provider.fromJson(Map<String, dynamic> json) => Provider(
        id: json["id"],
        name: json["name"],
        contacts: json["contacts"],
        registerDate: json["register_date"],
        status: json["status"],
        registerUser: json["register_user"],
        itn: json["itn"],
        address: json["address"],
        latitude: json["latitude"],
        longitude: json["longitude"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "contacts": contacts,
        "register_date": registerDate,
        "status": status,
        "register_user": registerUser,
        "itn": itn,
        "address": address,
        "latitude": latitude,
        "longitude": longitude,
      };
}
