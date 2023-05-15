// To parse this JSON data, do
//
//     final stockInventoryResponseDto = stockInventoryResponseDtoFromJson(jsonString);

import 'dart:convert';

class StockInventoryResponseDto {
  StockInventoryResponseDto({
    this.count,
    this.results,
  });

  int count;
  List<StockInventoryResult> results;

  factory StockInventoryResponseDto.fromRawJson(String str) =>
      StockInventoryResponseDto.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory StockInventoryResponseDto.fromJson(Map<String, dynamic> json) =>
      StockInventoryResponseDto(
        count: json["count"],
        results: json["results"] == null
            ? null
            : List<StockInventoryResult>.from(
                json["results"].map((x) => StockInventoryResult.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "results": results == null
            ? null
            : List<dynamic>.from(results.map((x) => x.toJson())),
      };
}

class StockInventoryResult {
  StockInventoryResult({
    this.id,
    this.name,
    this.locationIds,
    this.accountingDate,
    this.state,
  });

  int id;
  String name;
  List<int> locationIds;
  DateTime accountingDate;
  String state;

  factory StockInventoryResult.fromRawJson(String str) =>
      StockInventoryResult.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory StockInventoryResult.fromJson(Map<String, dynamic> json) =>
      StockInventoryResult(
        id: json["id"],
        name: json["name"],
        locationIds: json["location_ids"] == null
            ? null
            : List<int>.from(json["location_ids"].map((x) => x)),
        accountingDate: json["accounting_date"] == null
            ? null
            : DateTime.parse(json["accounting_date"]),
        state: json["state"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "location_ids": locationIds == null
            ? null
            : List<dynamic>.from(locationIds.map((x) => x)),
        "accounting_date": accountingDate == null
            ? null
            : "${accountingDate.year.toString().padLeft(4, '0')}-${accountingDate.month.toString().padLeft(2, '0')}-${accountingDate.day.toString().padLeft(2, '0')}",
        "state": state,
      };
}
