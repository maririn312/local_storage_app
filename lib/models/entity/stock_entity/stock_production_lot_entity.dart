// To parse this JSON data, do
//
//     final stockProductionLotResponseDto = stockProductionLotResponseDtoFromJson(jsonString);

// ignore_for_file: prefer_if_null_operators

import 'dart:convert';

class StockProductionLotEntity {
  StockProductionLotEntity({
    this.id,
    this.name,
    this.removalDate,
    this.productId,
    this.productQty,
    this.companyId,
    this.isSendData,
  });

  int id;
  String name;
  String removalDate;
  int productId;
  double productQty;
  int companyId;
  String isSendData;

  factory StockProductionLotEntity.fromJson(String str) =>
      StockProductionLotEntity.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory StockProductionLotEntity.fromMap(Map<String, dynamic> json) =>
      StockProductionLotEntity(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        removalDate: json["removal_date"],
        productId: json["product_id"] == null ? null : json["product_id"],
        productQty: json["product_qty"] == null ? null : json["product_qty"],
        companyId: json["company_id"],
        isSendData: json["is_send_data"] == null ? null : json["is_send_data"],
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "removal_date": removalDate,
        "product_id": productId == null ? null : productId,
        "product_qty": productQty == null ? null : productQty,
        "company_id": companyId,
        "is_send_data": isSendData == null ? null : isSendData,
      };
}
