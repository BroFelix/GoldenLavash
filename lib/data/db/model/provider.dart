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
  });

  @primaryKey
  int id;
  String name;
  String contacts;
  String registerDate;
  bool status;
  int registerUser;

  Provider copyWith({
    int id,
    String name,
    String contacts,
    DateTime registerDate,
    bool status,
    int registerUser,
  }) =>
      Provider(
        id: id ?? this.id,
        name: name ?? this.name,
        contacts: contacts ?? this.contacts,
        registerDate: registerDate ?? this.registerDate,
        status: status ?? this.status,
        registerUser: registerUser ?? this.registerUser,
      );

  factory Provider.fromJson(Map<String, dynamic> json) => Provider(
        id: json["id"],
        name: json["name"],
        contacts: json["contacts"],
        registerDate: json["register_date"],
        status: json["status"],
        registerUser: json["register_user"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "contacts": contacts,
        "register_date": registerDate,
        "status": status,
        "register_user": registerUser,
      };
}
