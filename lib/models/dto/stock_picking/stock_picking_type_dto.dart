// To parse this JSON data, do
//
//     final stockPickingResponseDto = stockPickingResponseDtoFromJson(jsonString);

import 'dart:convert';

class StockPickingTypeResponseDto {
  StockPickingTypeResponseDto({
    this.count,
    this.results,
  });

  int count;
  List<StockPickingTypeResult> results;

  factory StockPickingTypeResponseDto.fromRawJson(String str) =>
      StockPickingTypeResponseDto.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory StockPickingTypeResponseDto.fromJson(Map<String, dynamic> json) =>
      StockPickingTypeResponseDto(
        count: json["count"],
        results: json["results"] == null
            ? null
            : List<StockPickingTypeResult>.from(
                json["results"].map((x) => StockPickingTypeResult.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "results": results == null
            ? null
            : List<dynamic>.from(results.map((x) => x.toJson())),
      };
}

class StockPickingTypeResult {
  StockPickingTypeResult({
    this.id,
    this.name,
    this.code,
  });

  int id;
  String name;
  String code;

  factory StockPickingTypeResult.fromRawJson(String str) =>
      StockPickingTypeResult.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory StockPickingTypeResult.fromJson(Map<String, dynamic> json) =>
      StockPickingTypeResult(
        id: json["id"],
        name: json["name"],
        code: json["code"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "code": code,
      };
}
