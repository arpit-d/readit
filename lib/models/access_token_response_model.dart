// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class AccessTokenResponseModel {
  final String accessToken;
  final String tokenType;
  final DateTime expiresIn;
  final String refreshToken;
  final String scope;

  AccessTokenResponseModel(
      {required this.accessToken,
      required this.tokenType,
      required this.expiresIn,
      required this.refreshToken,
      required this.scope});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'access_token': accessToken,
      'token_type': tokenType,
      'expires_in': expiresIn.millisecondsSinceEpoch,
      'refresh_token': refreshToken,
      'scope': scope,
    };
  }

  factory AccessTokenResponseModel.fromMap(Map<String, dynamic> map) {
    return AccessTokenResponseModel(
      accessToken: map['access_token'] as String,
      tokenType: map['token_type'] as String,
      expiresIn: DateTime.fromMillisecondsSinceEpoch(map['expires_in'] as int),
      refreshToken: map['refresh_token'] as String,
      scope: map['scope'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory AccessTokenResponseModel.fromJson(String source) =>
      AccessTokenResponseModel.fromMap(
          jsonDecode(source) as Map<String, dynamic>);
}
