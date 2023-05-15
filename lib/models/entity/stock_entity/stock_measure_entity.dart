// To parse this JSON data, do
//
//     final stockMeasureResponseDto = stockMeasureResponseDtoFromJson(jsonString);

// ignore_for_file: prefer_if_null_operators, prefer_null_aware_operators

import 'dart:convert';

class StockMeasureEntity {
  StockMeasureEntity({
    this.rounding,
    this.id,
    this.name,
  });

  double rounding;
  int id;
  String name;

  factory StockMeasureEntity.fromJson(String str) =>
      StockMeasureEntity.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory StockMeasureEntity.fromMap(Map<String, dynamic> json) =>
      StockMeasureEntity(
        rounding: json["rounding"] == null ? null : json["rounding"].toDouble(),
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
      );

  Map<String, dynamic> toMap() => {
        "rounding": rounding == null ? null : rounding,
        "id": id == null ? null : id,
        "name": name == null ? null : name,
      };
}
