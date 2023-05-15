// To parse this JSON data, do
//
//     final resUserResponseDto = resUserResponseDtoFromJson(jsonString);

// ignore_for_file: prefer_null_aware_operators

import 'dart:convert';

class ResUserResponseDto {
  ResUserResponseDto({
    this.count,
    this.results,
  });

  int count;
  List<ResUserResult> results;

  factory ResUserResponseDto.fromRawJson(String str) =>
      ResUserResponseDto.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ResUserResponseDto.fromJson(Map<String, dynamic> json) =>
      ResUserResponseDto(
        count: json["count"],
        results: json["results"] == null
            ? null
            : List<ResUserResult>.from(
                json["results"].map((x) => ResUserResult.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "results": results == null
            ? null
            : List<dynamic>.from(results.map((x) => x.toJson())),
      };
}

class ResUserResult {
  ResUserResult({
    this.id,
    this.name,
    this.login,
    this.email,
    this.longitude,
    this.latitude,
  });

  int id;
  String name;
  String login;
  String email;
  double longitude;
  double latitude;

  factory ResUserResult.fromRawJson(String str) =>
      ResUserResult.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ResUserResult.fromJson(Map<String, dynamic> json) => ResUserResult(
        id: json["id"],
        name: json["name"],
        login: json["login"],
        email: json["email"],
        longitude:
            json["longitude"] == null ? null : json["longitude"].toDouble(),
        latitude: json["latitude"] == null ? null : json["latitude"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "login": login,
        "email": email,
        "longitude": longitude,
        "latitude": latitude,
      };
}
