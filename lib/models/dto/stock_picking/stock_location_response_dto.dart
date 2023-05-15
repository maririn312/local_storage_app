// To parse this JSON data, do
//
//     final stockLocationResponseDto = stockLocationResponseDtoFromJson(jsonString);

import 'dart:convert';

class StockLocationResponseDto {
  StockLocationResponseDto({
    this.count,
    this.results,
  });

  int count;
  List<StockLocationResult> results;

  factory StockLocationResponseDto.fromRawJson(String str) =>
      StockLocationResponseDto.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory StockLocationResponseDto.fromJson(Map<String, dynamic> json) =>
      StockLocationResponseDto(
        count: json["count"],
        results: json["results"] == null
            ? null
            : List<StockLocationResult>.from(
                json["results"].map((x) => StockLocationResult.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "results": results == null
            ? null
            : List<dynamic>.from(results.map((x) => x.toJson())),
      };
}

class StockLocationResult {
  StockLocationResult({
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

  factory StockLocationResult.fromRawJson(String str) =>
      StockLocationResult.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory StockLocationResult.fromJson(Map<String, dynamic> json) =>
      StockLocationResult(
        id: json["id"],
        name: json["name"],
        locationId: json["location_id"],
        usage: json["usage"],
        completeName: json["complete_name"],
        companyId: json["company_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "location_id": locationId,
        "usage": usage,
        "complete_name": completeName,
        "company_id": companyId,
      };
}
