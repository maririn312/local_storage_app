// To parse this JSON data, do
//
//     final stockLocationResponseDto = stockLocationResponseDtoFromJson(jsonString);

// ignore_for_file: prefer_if_null_operators

import 'dart:convert';

class StockLocationEntity {
  StockLocationEntity({
    this.id,
    this.name,
    this.locationId,
    this.usage,
    this.completeName,
    this.companyId,
  });

  int id;
  String name;
  int locationId;
  String usage;
  String completeName;
  int companyId;

  factory StockLocationEntity.fromJson(String str) =>
      StockLocationEntity.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory StockLocationEntity.fromMap(Map<String, dynamic> json) =>
      StockLocationEntity(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        locationId: json["location_id"],
        usage: json["usage"] == null ? null : json["usage"],
        completeName:
            json["complete_name"] == null ? null : json["complete_name"],
        companyId: json["company_id"],
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "location_id": locationId,
        "usage": usage == null ? null : usage,
        "complete_name": completeName == null ? null : completeName,
        "company_id": companyId,
      };

  // static fromMap(Map<String, Object> stockItem) {}
}
