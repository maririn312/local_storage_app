// To parse this JSON data, do
//
//     final authResponseDto = authResponseDtoFromJson(jsonString);

// ignore_for_file: prefer_if_null_operators, prefer_null_aware_operators

import 'dart:convert';

class AuthResponseDto {
  AuthResponseDto({
    this.uid,
    this.userContext,
    this.companyId,
    this.accessToken,
    this.expiresIn,
    this.refreshToken,
    this.refreshExpiresIn,
  });

  final int uid;
  final UserContext userContext;
  final int companyId;
  final String accessToken;
  final int expiresIn;
  final String refreshToken;
  final int refreshExpiresIn;

  factory AuthResponseDto.fromRawJson(String str) =>
      AuthResponseDto.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AuthResponseDto.fromJson(Map<String, dynamic> json) =>
      AuthResponseDto(
        uid: json["uid"] == null ? null : json["uid"],
        userContext: json["user_context"] == null
            ? null
            : UserContext.fromJson(json["user_context"]),
        companyId: json["company_id"] == null ? null : json["company_id"],
        accessToken: json["access_token"] == null ? null : json["access_token"],
        expiresIn: json["expires_in"] == null ? null : json["expires_in"],
        refreshToken:
            json["refresh_token"] == null ? null : json["refresh_token"],
        refreshExpiresIn: json["refresh_expires_in"] == null
            ? null
            : json["refresh_expires_in"],
      );

  Map<String, dynamic> toJson() => {
        "uid": uid == null ? null : uid,
        "user_context": userContext == null ? null : userContext.toJson(),
        "company_id": companyId == null ? null : companyId,
        "access_token": accessToken == null ? null : accessToken,
        "expires_in": expiresIn == null ? null : expiresIn,
        "refresh_token": refreshToken == null ? null : refreshToken,
        "refresh_expires_in":
            refreshExpiresIn == null ? null : refreshExpiresIn,
      };
}

class UserContext {
  UserContext({
    this.lang,
    this.tz,
    this.uid,
  });

  final String lang;
  final String tz;
  final int uid;

  factory UserContext.fromRawJson(String str) =>
      UserContext.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserContext.fromJson(Map<String, dynamic> json) => UserContext(
        lang: json["lang"] == null ? null : json["lang"],
        tz: json["tz"] == null ? null : json["tz"],
        uid: json["uid"] == null ? null : json["uid"],
      );

  Map<String, dynamic> toJson() => {
        "lang": lang == null ? null : lang,
        "tz": tz == null ? null : tz,
        "uid": uid == null ? null : uid,
      };
}
