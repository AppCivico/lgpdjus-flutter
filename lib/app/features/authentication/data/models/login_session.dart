class LoginSession {
  LoginSession({
    required this.url,
    required this.token,
  });

  String url;
  String token;

  factory LoginSession.fromJson(Map<String, dynamic> json) => LoginSession(
        url: json['link'],
        token: json['tmp_session'],
      );
}
