class Token {
  final String token;
  final int expiration;

  Token({
    required this.token,
    required this.expiration,
  });

  factory Token.fromJson(Map<String, dynamic> json) {
    return Token(
      token: json['token'],
      expiration: json['expiration'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'token': token,
      'expiration': expiration,
    };
  }

  bool isExpired() {
    return DateTime.now().millisecondsSinceEpoch > expiration;
  }
}