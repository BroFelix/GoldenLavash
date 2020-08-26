class Token {
  final String token;

  Token(this.token);

  Token.fromJson(Map<String, dynamic> json) : token = json['key'];

  Map<String, dynamic> toJson() => {
        'key': token,
      };
}
