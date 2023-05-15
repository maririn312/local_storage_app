// To parse this JSON data, do
//
//     final stockPickingResponseDto = stockPickingResponseDtoFromJson(jsonString);

import 'dart:convert';

class StockPickingResponseDto {
  StockPickingResponseDto({
    this.count,
    this.results,
  });

  int count;
  List<StockPickingResult> results;

  factory StockPickingResponseDto.fromRawJson(String str) =>
      StockPickingResponseDto.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory StockPickingResponseDto.fromJson(Map<String, dynamic> json) =>
      StockPickingResponseDto(
        count: json["count"],
        results: json["results"] == null
            ? null
            : List<StockPickingResult>.from(
                json["results"].map((x) => StockPickingResult.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "results": results == null
            ? null
            : List<dynamic>.from(results.map((x) => x.toJson())),
      };
}

class StockPickingResult {
  StockPickingResult({
    this.id,
    this.name,
    this.partnerId,
    this.pickingTypeId,
    this.locationId,
    this.scheduledDate,
    this.origin,
    this.checkUserId,
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
  int checkUserId;
  String state;
  String isChecked;

  factory StockPickingResult.fromRawJson(String str) =>
      StockPickingResult.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory StockPickingResult.fromJson(Map<String, dynamic> json) =>
      StockPickingResult(
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
        state: json["state"],
        isChecked: json["is_checked"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "partner_id": partnerId,
        "picking_type_id": pickingTypeId,
        "location_id": locationId,
        "scheduled_date":
            // ignore: prefer_null_aware_operators
            scheduledDate == null ? null : scheduledDate.toIso8601String(),
        "origin": origin,
        "check_user_id": checkUserId,
        "state": state,
        "is_checked": isChecked,
      };
}
