// To parse this JSON data, do
//
//     final stockInventoryLineResponseDto = stockInventoryLineResponseDtoFromJson(jsonString);

// ignore_for_file: prefer_null_aware_operators

import 'dart:convert';

class StockInventoryLineResponseDto {
  StockInventoryLineResponseDto({
    this.count,
    this.results,
  });

  int count;
  List<StockInventoryLineResult> results;

  factory StockInventoryLineResponseDto.fromRawJson(String str) =>
      StockInventoryLineResponseDto.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory StockInventoryLineResponseDto.fromJson(Map<String, dynamic> json) =>
      StockInventoryLineResponseDto(
        count: json["count"],
        results: json["results"] == null
            ? null
            : List<StockInventoryLineResult>.from(json["results"]
                .map((x) => StockInventoryLineResult.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "results": results == null
            ? null
            : List<dynamic>.from(results.map((x) => x.toJson())),
      };
}

class StockInventoryLineResult {
  StockInventoryLineResult(
      {this.id,
      this.theoreticalQty,
      this.productQty,
      this.packQty,
      this.barcode,
      this.productName});

  int id;

  double theoreticalQty;
  double productQty;
  double packQty;
  String barcode;
  String productName;

  factory StockInventoryLineResult.fromRawJson(String str) =>
      StockInventoryLineResult.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory StockInventoryLineResult.fromJson(Map<String, dynamic> json) =>
      StockInventoryLineResult(
        id: json["id"],
        theoreticalQty: json["theoretical_qty"],
        productQty: json["product_qty"],
        barcode: json["barcode"],
        productName: json["product_name"],
        packQty: json["pack_qty"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "theoretical_qty": theoreticalQty,
        "product_qty": productQty,
        "barcode": barcode,
        "product_name": productName,
        "pack_qty": packQty,
      };
}
