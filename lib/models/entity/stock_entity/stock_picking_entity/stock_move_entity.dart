// To parse this JSON data, do
//
//     final stockLocationResponseDto = stockLocationResponseDtoFromJson(jsonString);

// ignore_for_file: prefer_if_null_operators, prefer_null_aware_operators

import 'dart:convert';

class StockMoveLineEntity {
  StockMoveLineEntity({
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

  factory StockMoveLineEntity.fromJson(String str) =>
      StockMoveLineEntity.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory StockMoveLineEntity.fromMap(Map<String, dynamic> json) =>
      StockMoveLineEntity(
        id: json["id"],
        productId: json["product_id"],
        descriptionPicking: json["description_picking"],
        dateExpected: json["date_expected"] == null
            ? null
            : DateTime.parse(json["date_expected"]),
        quantityDone: json["quantity_done"],
        productUom: json["product_uom"],
        productUomQty:
            json["product_uom_qty"] == null ? null : json["product_uom_qty"],
        pickingId: json["picking_id"],
        checkQty: json["check_qty"],
        diffQty: json["diff_qty"],
        barcode: json["barcode"],
        productName: json["product_name"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "product_id": productId,
        "description_picking": descriptionPicking,
        "date_expected":
            dateExpected == null ? null : dateExpected.toIso8601String(),
        "quantity_done": quantityDone,
        "product_uom": productUom,
        "product_uom_qty": productUomQty == null ? null : productUomQty,
        "picking_id": pickingId,
        "check_qty": checkQty,
        "diff_qty": diffQty,
        "barcode": barcode,
        "product_name": productName,
      };
}
