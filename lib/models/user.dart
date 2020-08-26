class User {
  int count;
  dynamic next;
  dynamic previous;
  List<Results> results;

  User({this.count, this.next, this.previous, this.results});

  User.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    next = json['next'];
    previous = json['previous'];
    if (json['results'] != null) {
      results = new List<Results>();
      json['results'].forEach((v) {
        results.add(new Results.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    data['next'] = this.next;
    data['previous'] = this.previous;
    if (this.results != null) {
      data['results'] = this.results.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Results {
  int id;
  String password;
  Null firstName;
  Null lastName;
  Null email;
  String username;
  bool isActive;
  String userType;
  String phone;

  Results(
      {this.id,
        this.password,
        this.firstName,
        this.lastName,
        this.email,
        this.username,
        this.isActive,
        this.userType,
        this.phone});

  Results.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    password = json['password'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    username = json['username'];
    isActive = json['is_active'];
    userType = json['user_type'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['password'] = this.password;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['email'] = this.email;
    data['username'] = this.username;
    data['is_active'] = this.isActive;
    data['user_type'] = this.userType;
    data['phone'] = this.phone;
    return data;
  }
}