// To parse this JSON data, do
//
//     final stockLocationResponseDto = stockLocationResponseDtoFromJson(jsonString);

// ignore_for_file: prefer_if_null_operators, prefer_null_aware_operators

import 'dart:convert';

class StockPickingTypeEntity {
  StockPickingTypeEntity({
    this.id,
    this.name,
    this.code,
  });

  int id;

  String name;

  String code;

  factory StockPickingTypeEntity.fromJson(String str) =>
      StockPickingTypeEntity.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory StockPickingTypeEntity.fromMap(Map<String, dynamic> json) =>
      StockPickingTypeEntity(
        id: json["id"],
        name: json["name"],
        code: json["code"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "code": code,
      };
}
