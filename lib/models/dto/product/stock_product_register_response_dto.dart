// To parse this JSON data, do
//
//     final stockProductRegisterResponseDto = stockProductRegisterResponseDtoFromJson(jsonString);

// ignore_for_file: constant_identifier_names, prefer_null_aware_operators

import 'dart:convert';

class StockProductRegisterResponseDto {
  StockProductRegisterResponseDto({
    this.count,
    this.results,
  });

  int count;
  List<ProductResult> results;

  factory StockProductRegisterResponseDto.fromRawJson(String str) =>
      StockProductRegisterResponseDto.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory StockProductRegisterResponseDto.fromJson(Map<String, dynamic> json) =>
      StockProductRegisterResponseDto(
        count: json["count"],
        results: json["results"] == null
            ? null
            : List<ProductResult>.from(
                json["results"].map((x) => ProductResult.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "results": results == null
            ? null
            : List<dynamic>.from(results.map((x) => x.toJson())),
      };
}

class ProductResult {
  ProductResult({
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
    this.image128,
  });

  int id;
  int responsibleId;
  String name;
  String barcode;
  int categId;
  String defaultCode;
  double listPrice;
  Type type;
  double weight;
  double volume;
  int uomId;
  int companyId;
  String image128;

  factory ProductResult.fromRawJson(String str) =>
      ProductResult.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProductResult.fromJson(Map<String, dynamic> json) => ProductResult(
        id: json["id"],
        responsibleId: json["responsible_id"],
        name: json["name"],
        barcode: json["barcode"],
        categId: json["categ_id"],
        defaultCode: json["default_code"],
        listPrice: json["list_price"],
        type: json["type"] == null ? null : typeValues.map[json["type"]],
        weight: json["weight"] == null ? null : json["weight"].toDouble(),
        volume: json["volume"],
        uomId: json["uom_id"],
        companyId: json["company_id"],
        image128: json["image_128"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "responsible_id": responsibleId,
        "name": name,
        "barcode": barcode,
        "categ_id": categId,
        "default_code": defaultCode,
        "list_price": listPrice,
        "type": type == null ? null : typeValues.reverse[type],
        "weight": weight,
        "volume": volume,
        "uom_id": uomId,
        "company_id": companyId,
        "image_128": image128,
      };
}

enum Type { PRODUCT, CONSU, SERVICE }

final typeValues = EnumValues(
    {"consu": Type.CONSU, "product": Type.PRODUCT, "service": Type.SERVICE});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap ??= map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
