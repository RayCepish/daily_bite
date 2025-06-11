class TokenModel {
  final String refreshToken;
  final String accessToken;

  TokenModel({
    required this.refreshToken,
    required this.accessToken,
  });

  factory TokenModel.fromJson(Map<String, dynamic> json) {
    return TokenModel(
      refreshToken: json['refresh'] as String,
      accessToken: json['access'] as String,
    );
  }
}
