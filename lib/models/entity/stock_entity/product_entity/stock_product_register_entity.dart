// To parse this JSON data, do
//
//     final stockProductRegisterResponseDto = stockProductRegisterResponseDtoFromJson(jsonString);

// ignore_for_file: prefer_if_null_operators, prefer_null_aware_operators

import 'dart:convert';

class StockProductRegisterEntity {
  StockProductRegisterEntity({
    this.id,
    this.responsibleId,
    this.name,
    this.barcode,
    this.categId,
    this.defaultCode,
    this.listPrice,
    this.type,
    this.weight,
    this.volume,
    this.uomId,
    this.companyId,
    this.isSendData,
    this.image128,
  });

  int id;
  int responsibleId;
  String name;
  String barcode;
  int categId;
  String defaultCode;
  double listPrice;
  String type;
  double weight;
  double volume;
  int uomId;
  int companyId;
  String isSendData;
  String image128;

  factory StockProductRegisterEntity.fromJson(String str) =>
      StockProductRegisterEntity.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory StockProductRegisterEntity.fromMap(Map<String, dynamic> json) =>
      StockProductRegisterEntity(
        id: json["id"] == null ? null : json["id"],
        responsibleId:
            json["responsible_id"] == null ? null : json["responsible_id"],
        name: json["name"] == null ? null : json["name"],
        barcode: json["barcode"],
        categId: json["categ_id"] == null ? null : json["categ_id"],
        defaultCode: json["default_code"],
        listPrice: json["list_price"] == null ? null : json["list_price"],
        type: json["type"] == null ? null : json["type"],
        weight: json["weight"] == null ? null : json["weight"].toDouble(),
        volume: json["volume"] == null ? null : json["volume"],
        uomId: json["uom_id"] == null ? null : json["uom_id"],
        companyId: json["company_id"] == null ? null : json["company_id"],
        isSendData: json["is_send_data"] == null ? null : json["is_send_data"],
        image128: json["image_128"],
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "responsible_id": responsibleId == null ? null : responsibleId,
        "name": name == null ? null : name,
        "barcode": barcode,
        "categ_id": categId == null ? null : categId,
        "default_code": defaultCode,
        "list_price": listPrice == null ? null : listPrice,
        "type": type == null ? null : type,
        "weight": weight == null ? null : weight,
        "volume": volume == null ? null : volume,
        "uom_id": uomId == null ? null : uomId,
        "company_id": companyId == null ? null : companyId,
        "is_send_data": isSendData == null ? null : isSendData,
        "image_128": image128,
      };
}
