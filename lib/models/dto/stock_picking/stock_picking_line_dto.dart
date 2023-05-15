// To parse this JSON data, do
//
//     final stockPickingLineResponseDto = stockPickingLineResponseDtoFromJson(jsonString);

import 'dart:convert';

class StockPickingLineResponseDto {
  StockPickingLineResponseDto({
    this.count,
    this.results,
  });

  int count;
  List<StockPickingLineResult> results;

  factory StockPickingLineResponseDto.fromRawJson(String str) =>
      StockPickingLineResponseDto.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory StockPickingLineResponseDto.fromJson(Map<String, dynamic> json) =>
      StockPickingLineResponseDto(
        count: json["count"],
        results: json["results"] == null
            ? null
            : List<StockPickingLineResult>.from(
                json["results"].map((x) => StockPickingLineResult.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "results": results == null
            ? null
            : List<dynamic>.from(results.map((x) => x.toJson())),
      };
}

class StockPickingLineResult {
  StockPickingLineResult({
    this.id,
    this.moveId,
    this.productId,
    this.locationId,
    this.locationDestId,
    this.lotId,
    this.qtyDone,
    this.productUomId,
  });

  int id;
  int moveId;
  int productId;
  int locationId;
  int locationDestId;
  dynamic lotId;
  double qtyDone;
  int productUomId;

  factory StockPickingLineResult.fromRawJson(String str) =>
      StockPickingLineResult.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory StockPickingLineResult.fromJson(Map<String, dynamic> json) =>
      StockPickingLineResult(
        id: json["id"],
        moveId: json["move_id"],
        productId: json["product_id"],
        locationId: json["location_id"],
        locationDestId: json["location_dest_id"],
        lotId: json["lot_id"],
        qtyDone: json["qty_done"],
        productUomId: json["product_uom_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "move_id": moveId,
        "product_id": productId,
        "location_id": locationId,
        "location_dest_id": locationDestId,
        "lot_id": lotId,
        "qty_done": qtyDone,
        "product_uom_id": productUomId,
      };
}
