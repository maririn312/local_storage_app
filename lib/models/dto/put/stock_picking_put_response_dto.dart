// To parse this JSON data, do
//
//     final stockPickingPutResponseDto = stockPickingPutResponseDtoFromJson(jsonString);

// ignore_for_file: prefer_null_aware_operators

import 'dart:convert';

class StockPickingPutResponseDto {
  StockPickingPutResponseDto({
    this.id,
    this.name,
    this.partnerId,
    this.pickingTypeId,
    this.locationId,
    this.scheduledDate,
    this.origin,
    this.checkUserId,
    this.isChecked,
    this.state,
  });

  int id;
  String name;
  int partnerId;
  int pickingTypeId;
  int locationId;
  DateTime scheduledDate;
  String origin;
  int checkUserId;
  String isChecked;
  String state;

  factory StockPickingPutResponseDto.fromRawJson(String str) =>
      StockPickingPutResponseDto.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory StockPickingPutResponseDto.fromJson(Map<String, dynamic> json) =>
      StockPickingPutResponseDto(
        id: json["id"],
        name: json["name"],
        partnerId: json["partner_id"],
        pickingTypeId: json["picking_type_id"],
        locationId: json["location_id"],
        scheduledDate: json["scheduled_date"] == null
            ? null
            : DateTime.parse(json["scheduled_date"]),
        origin: json["origin"],
        checkUserId: json["check_user_id"],
        isChecked: json["is_checked"],
        state: json["state"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "partner_id": partnerId,
        "picking_type_id": pickingTypeId,
        "location_id": locationId,
        "scheduled_date":
            scheduledDate == null ? null : scheduledDate.toIso8601String(),
        "origin": origin,
        "check_user_id": checkUserId,
        "is_checked": isChecked,
        "state": state,
      };
}
