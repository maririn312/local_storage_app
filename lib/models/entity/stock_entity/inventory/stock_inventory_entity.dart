// To parse this JSON data, do
//
//     final stockInventoryResponseDto = stockInventoryResponseDtoFromJson(jsonString);

// ignore_for_file: prefer_if_null_operators

import 'dart:convert';

class StockInventoryEntity {
  StockInventoryEntity({
    this.id,
    this.name,
    this.locationIds,
    this.accountingDate,
    this.state,
  });

  int id;
  String name;
  List<int> locationIds;
  String accountingDate;
  int companyId;
  String isSendData;
  String state;
  List<int> productIds;
  factory StockInventoryEntity.fromJson(String str) =>
      StockInventoryEntity.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory StockInventoryEntity.fromMap(Map<String, dynamic> json) =>
      StockInventoryEntity(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        locationIds: json["location_ids"] == null
            ? null
            : List<int>.from(json["location_ids"].map((x) => x)),
        accountingDate: json["accounting_date"],
        state: json["state"] == null ? null : json["state"],
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "location_ids": locationIds == null
            ? null
            : List<dynamic>.from(locationIds.map((x) => x)),
        "accounting_date": accountingDate,
        "state": state == null ? null : state,
      };
}
