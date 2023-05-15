// To parse this JSON data, do
//
//     final stockMoveLineResponseDto = stockMoveLineResponseDtoFromJson(jsonString);

// ignore_for_file: prefer_null_aware_operators

import 'dart:convert';

class StockMoveLineResponseDto {
  StockMoveLineResponseDto({
    this.count,
    this.results,
  });

  int count;
  List<StockMoveLineResult> results;

  factory StockMoveLineResponseDto.fromRawJson(String str) =>
      StockMoveLineResponseDto.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory StockMoveLineResponseDto.fromJson(Map<String, dynamic> json) =>
      StockMoveLineResponseDto(
        count: json["count"],
        results: json["results"] == null
            ? null
            : List<StockMoveLineResult>.from(
                json["results"].map((x) => StockMoveLineResult.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "results": results == null
            ? null
            : List<dynamic>.from(results.map((x) => x.toJson())),
      };
}

class StockMoveLineResult {
  StockMoveLineResult({
    this.id,
    this.productId,
    this.descriptionPicking,
    this.dateExpected,
    this.quantityDone,
    this.productUom,
    this.productUomQty,
    this.pickingId,
    this.checkQty,
    this.diffQty,
    this.barcode,
    this.productName,
  });

  int id;
  int productId;
  String descriptionPicking;
  DateTime dateExpected;
  double quantityDone;
  int productUom;
  double productUomQty;
  int pickingId;
  double checkQty;
  double diffQty;
  String barcode;
  String productName;

  factory StockMoveLineResult.fromRawJson(String str) =>
      StockMoveLineResult.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory StockMoveLineResult.fromJson(Map<String, dynamic> json) =>
      StockMoveLineResult(
        id: json["id"],
        productId: json["product_id"],
        descriptionPicking: json["description_picking"],
        dateExpected: json["date_expected"] == null
            ? null
            : DateTime.parse(json["date_expected"]),
        quantityDone: json["quantity_done"],
        productUom: json["product_uom"],
        productUomQty: json["product_uom_qty"],
        pickingId: json["picking_id"],
        checkQty: json["check_qty"],
        diffQty: json["diff_qty"],
        barcode: json["barcode"],
        productName: json["product_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "product_id": productId,
        "description_picking": descriptionPicking,
        "date_expected":
            dateExpected == null ? null : dateExpected.toIso8601String(),
        "quantity_done": quantityDone,
        "product_uom": productUom,
        "product_uom_qty": productUomQty,
        "picking_id": pickingId,
        "check_qty": checkQty,
        "diff_qty": diffQty,
        "barcode": barcode,
        "product_name": productName,
      };
}
