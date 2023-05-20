// To parse this JSON data, do
//
//     final categoryResponseDto = categoryResponseDtoFromJson(jsonString);

import 'dart:convert';

class CategoryResponseDto {
  int count;
  List<CategoryResult> results;

  CategoryResponseDto({
    this.count,
    this.results,
  });

  factory CategoryResponseDto.fromRawJson(String str) =>
      CategoryResponseDto.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CategoryResponseDto.fromJson(Map<String, dynamic> json) =>
      CategoryResponseDto(
        count: json["count"],
        results: List<CategoryResult>.from(
            json["results"].map((x) => CategoryResult.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
      };
}

class CategoryResult {
  int companyId;
  String name;
  int id;
  int parentId;
  String className;
  String icon;
  int sequence;
  String isSendData;
  bool active;
  bool isSale;
  bool isWarehouse;

  CategoryResult({
    this.companyId,
    this.name,
    this.id,
    this.parentId,
    this.className,
    this.icon,
    this.sequence,
    this.isSendData,
    this.active,
    this.isSale,
    this.isWarehouse,
  });

  factory CategoryResult.fromRawJson(String str) =>
      CategoryResult.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CategoryResult.fromJson(Map<String, dynamic> json) => CategoryResult(
        companyId: json["company_id"],
        name: json["name"],
        id: json["id"],
        parentId: json["parent_id"],
        className: json["class_name"],
        icon: json["icon"],
        sequence: json["sequence"],
        isSendData: json["is_send_data"],
        active: json["active"],
        isSale: json["is_sale"],
        isWarehouse: json["is_warehouse"],
      );

  Map<String, dynamic> toJson() => {
        "company_id": companyId,
        "name": name,
        "id": id,
        "parent_id": parentId,
        "class_name": className,
        "icon": icon,
        "sequence": sequence,
        "is_send_data": isSendData,
        "active": active,
        "is_sale": isSale,
        "is_warehouse": isWarehouse,
      };
}
