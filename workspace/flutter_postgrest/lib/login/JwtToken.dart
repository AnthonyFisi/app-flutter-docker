class JwtToken {
  final String token;

  JwtToken({this.token});

  factory JwtToken.fromJson(Map<String, dynamic> json) {
    return JwtToken(token: json['token'] as String);
  }
}
