// To parse this JSON data, do
//
//     final resCompanyResult = resCompanyResultFromJson(jsonString);

import 'dart:convert';

class ResCompanyResponseDto {
  ResCompanyResponseDto({
    this.count,
    this.results,
  });

  int count;
  List<Result> results;

  factory ResCompanyResponseDto.fromRawJson(String str) =>
      ResCompanyResponseDto.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ResCompanyResponseDto.fromJson(Map<String, dynamic> json) =>
      ResCompanyResponseDto(
        count: json["count"],
        results: json["results"] == null
            ? null
            : List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "results": results == null
            ? null
            : List<dynamic>.from(results.map((x) => x.toJson())),
      };
}

class Result {
  Result({
    this.id,
    this.name,
  });

  int id;
  String name;

  factory Result.fromRawJson(String str) => Result.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
