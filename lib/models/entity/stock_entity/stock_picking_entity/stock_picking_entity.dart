// To parse this JSON data, do
//
//     final stockLocationResponseDto = stockLocationResponseDtoFromJson(jsonString);

// ignore_for_file: prefer_if_null_operators

import 'dart:convert';

class StockPickingEntity {
  StockPickingEntity({
    this.id,
    this.name,
    this.partnerId,
    this.pickingTypeId,
    this.locationId,
    this.scheduledDate,
    this.origin,
    this.state,
    this.isChecked,
  });

  int id;
  String name;
  int partnerId;
  int pickingTypeId;
  int locationId;
  DateTime scheduledDate;
  String origin;
  String state;
  String isChecked;

  factory StockPickingEntity.fromJson(String str) =>
      StockPickingEntity.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory StockPickingEntity.fromMap(Map<String, dynamic> json) =>
      StockPickingEntity(
        id: json["id"],
        name: json["name"] == null ? null : json["name"],
        partnerId: json["partner_id"],
        pickingTypeId: json["picking_type_id"],
        locationId: json["location_id"],
        scheduledDate: json["scheduled_date"] == null
            ? null
            : DateTime.parse(json["scheduled_date"]),
        origin: json["origin"],
        state: json["state"],
        isChecked: json["is_checked"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name == null ? null : name,
        "partner_id": partnerId,
        "picking_type_id": pickingTypeId,
        "location_id": locationId,
        "scheduled_date":
            // ignore: prefer_null_aware_operators
            scheduledDate == null ? null : scheduledDate.toIso8601String(),
        "origin": origin,
        "state": state,
        "is_checked": isChecked,
      };

  // static fromMap(Map<String, Object> stockItem) {}
}
