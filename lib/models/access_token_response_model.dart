// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class AccessTokenResponseModel {
  final String accessToken;
  final String tokenType;
  final String tokenLastUpdated;
  final String refreshToken;
  final String scope;

  AccessTokenResponseModel(
      {required this.accessToken,
      required this.tokenType,
      required this.tokenLastUpdated,
      required this.refreshToken,
      required this.scope});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'access_token': accessToken,
      'token_type': tokenType,
      'token_last_updated': tokenLastUpdated,
      'refresh_token': refreshToken,
      'scope': scope,
    };
  }

  factory AccessTokenResponseModel.fromMap(Map<String, dynamic> map) {
    return AccessTokenResponseModel(
      accessToken: map['access_token'] as String,
      tokenType: map['token_type'] as String,
      tokenLastUpdated: map['token_last_updated'] as String,
      refreshToken: map['refresh_token'] as String,
      scope: map['scope'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  // factory AccessTokenResponseModel.fromJson(String source) {
  //   final map = jsonDecode(source) as Map<String, dynamic>;
  //   map['token_last_updated'] = DateTime.now().toString();
  //   log(map.toString());
  //   return AccessTokenResponseModel.fromMap(map);
  // }

  AccessTokenResponseModel copyWith({AccessTokenResponseModel? data}) {
    return AccessTokenResponseModel(
      accessToken: data?.accessToken ?? this.accessToken,
      tokenType: data?.tokenType ?? this.tokenType,
      tokenLastUpdated: data?.tokenLastUpdated ?? this.tokenLastUpdated,
      refreshToken: data?.refreshToken ?? this.refreshToken,
      scope: data?.scope ?? this.scope,
    );
  }

  @override
  String toString() {
    return 'AccessTokenResponseModel(accessToken: $accessToken, tokenType: $tokenType, tokenLastUpdated: $tokenLastUpdated, refreshToken: $refreshToken, scope: $scope)';
  }
}
