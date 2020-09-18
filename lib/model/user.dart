// To parse this JSON data, do
//
//     final userResponse = userResponseFromJson(jsonString);

import 'dart:convert';

UserResponse userResponseFromJson(String str) => UserResponse.fromJson(json.decode(str));

String userResponseToJson(UserResponse data) => json.encode(data.toJson());

class UserResponse {
  UserResponse({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  int count;
  dynamic next;
  dynamic previous;
  List<User> results;

  UserResponse copyWith({
    int count,
    dynamic next,
    dynamic previous,
    List<User> results,
  }) =>
      UserResponse(
        count: count ?? this.count,
        next: next ?? this.next,
        previous: previous ?? this.previous,
        results: results ?? this.results,
      );

  factory UserResponse.fromJson(Map<String, dynamic> json) => UserResponse(
    count: json["count"],
    next: json["next"],
    previous: json["previous"],
    results: List<User>.from(json["results"].map((x) => User.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "count": count,
    "next": next,
    "previous": previous,
    "results": List<dynamic>.from(results.map((x) => x.toJson())),
  };
}

class User {
  User({
    this.id,
    this.password,
    this.firstName,
    this.lastName,
    this.email,
    this.username,
    this.isActive,
    this.userType,
    this.phone,
    this.company,
  });

  int id;
  String password;
  dynamic firstName;
  dynamic lastName;
  dynamic email;
  String username;
  bool isActive;
  String userType;
  String phone;
  int company;

  User copyWith({
    int id,
    String password,
    dynamic firstName,
    dynamic lastName,
    dynamic email,
    String username,
    bool isActive,
    String userType,
    String phone,
    int company,
  }) =>
      User(
        id: id ?? this.id,
        password: password ?? this.password,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        email: email ?? this.email,
        username: username ?? this.username,
        isActive: isActive ?? this.isActive,
        userType: userType ?? this.userType,
        phone: phone ?? this.phone,
        company: company?? this.company,
      );

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    password: json["password"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    email: json["email"],
    username: json["username"],
    isActive: json["is_active"],
    userType: json["user_type"],
    phone: json["phone"],
    company: json['company'],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "password": password,
    "first_name": firstName,
    "last_name": lastName,
    "email": email,
    "username": username,
    "is_active": isActive,
    "user_type": userType,
    "phone": phone,
    "company": company,
  };
}
