// To parse this JSON data, do
//
//     final stockMeasureResponseDto = stockMeasureResponseDtoFromJson(jsonString);

// ignore_for_file: prefer_null_aware_operators

import 'dart:convert';

class StockMeasureResponseDto {
  StockMeasureResponseDto({
    this.count,
    this.results,
  });

  int count;
  List<StockMeasureResult> results;

  factory StockMeasureResponseDto.fromRawJson(String str) =>
      StockMeasureResponseDto.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory StockMeasureResponseDto.fromJson(Map<String, dynamic> json) =>
      StockMeasureResponseDto(
        count: json["count"],
        results: json["results"] == null
            ? null
            : List<StockMeasureResult>.from(
                json["results"].map((x) => StockMeasureResult.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "results": results == null
            ? null
            : List<dynamic>.from(results.map((x) => x.toJson())),
      };
}

class StockMeasureResult {
  StockMeasureResult({
    this.id,
    this.name,
    this.rounding,
  });

  int id;
  String name;
  double rounding;

  factory StockMeasureResult.fromRawJson(String str) =>
      StockMeasureResult.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory StockMeasureResult.fromJson(Map<String, dynamic> json) =>
      StockMeasureResult(
        id: json["id"],
        name: json["name"],
        rounding: json["rounding"] == null ? null : json["rounding"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "rounding": rounding,
      };
}
