// To parse this JSON data, do
//
//     final stockInventoryLineResult = stockInventoryLineResultFromJson(jsonString);

import 'dart:convert';

class StockInventoryLineResponseDto {
  final int count;
  final List<StockInventoryLineResult> results;

  StockInventoryLineResponseDto({
    this.count,
    this.results,
  });

  factory StockInventoryLineResponseDto.fromRawJson(String str) =>
      StockInventoryLineResponseDto.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory StockInventoryLineResponseDto.fromJson(Map<String, dynamic> json) =>
      StockInventoryLineResponseDto(
        count: json["count"],
        results: List<StockInventoryLineResult>.from(
            json["results"].map((x) => StockInventoryLineResult.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
      };
}

class StockInventoryLineResult {
  final int id;
  final int inventoryId;
  final int productId;
  final String productName;
  final double theoreticalQty;
  final double productQty;
  final double packQty;
  final String barcode;

  StockInventoryLineResult({
    this.id,
    this.inventoryId,
    this.productId,
    this.productName,
    this.theoreticalQty,
    this.productQty,
    this.packQty,
    this.barcode,
  });

  factory StockInventoryLineResult.fromRawJson(String str) =>
      StockInventoryLineResult.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory StockInventoryLineResult.fromJson(Map<String, dynamic> json) =>
      StockInventoryLineResult(
        id: json["id"],
        inventoryId: json["inventory_id"],
        productId: json["product_id"],
        productName: json["product_name"],
        theoreticalQty: json["theoretical_qty"]?.toDouble(),
        productQty: json["product_qty"]?.toDouble(),
        packQty: json["pack_qty"],
        barcode: json["barcode"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "inventory_id": inventoryId,
        "product_id": productId,
        "product_name": productName,
        "theoretical_qty": theoreticalQty,
        "product_qty": productQty,
        "pack_qty": packQty,
        "barcode": barcode,
      };
}
