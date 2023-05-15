import 'dart:convert';

class StockInventoryLineEntity {
  StockInventoryLineEntity(
      {this.id,
      this.theoreticalQty,
      this.productQty,
      this.barcode,
      this.productName});

  int id;
  double theoreticalQty;
  double productQty;
  String barcode;
  String productName;

  factory StockInventoryLineEntity.fromJson(String str) =>
      StockInventoryLineEntity.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory StockInventoryLineEntity.fromMap(Map<String, dynamic> json) =>
      StockInventoryLineEntity(
          id: json["id"],
          theoreticalQty: json["theoretical_qty"],
          productQty: json["product_qty"],
          barcode: json["barcode"],
          productName: json["product_name"]);

  Map<String, dynamic> toMap() => {
        "id": id,
        "theoretical_qty": theoreticalQty,
        "product_qty": productQty,
        "barcode": barcode,
        "product_name": productName,
      };
}
