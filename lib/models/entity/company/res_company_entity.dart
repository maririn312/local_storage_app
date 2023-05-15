// To parse this JSON data, do
//
//     final stockLocationResponseDto = stockLocationResponseDtoFromJson(jsonString);

// ignore_for_file: prefer_if_null_operators

import 'dart:convert';

class ResCompanyEntity {
  ResCompanyEntity({
    this.id,
    this.name,
  });

  int id;
  String name;

  factory ResCompanyEntity.fromJson(String str) =>
      ResCompanyEntity.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ResCompanyEntity.fromMap(Map<String, dynamic> json) =>
      ResCompanyEntity(
        id: json["id"],
        name: json["name"] == null ? null : json["name"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name == null ? null : name,
      };

  // static fromMap(Map<String, Object> stockItem) {}
}
