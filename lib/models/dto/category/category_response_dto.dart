// To parse this JSON data, do
//
//     final categoryResponseDto = categoryResponseDtoFromJson(jsonString);

import 'dart:convert';

class CategoryResponseDto {
  CategoryResponseDto({
    this.count,
    this.results,
  });

  int count;
  List<CategoryResult> results;

  factory CategoryResponseDto.fromRawJson(String str) =>
      CategoryResponseDto.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CategoryResponseDto.fromJson(Map<String, dynamic> json) =>
      CategoryResponseDto(
        count: json["count"],
        results: json["results"] == null
            ? null
            : List<CategoryResult>.from(
                json["results"].map((x) => CategoryResult.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "results": results == null
            ? null
            : List<dynamic>.from(results.map((x) => x.toJson())),
      };
}

class CategoryResult {
  CategoryResult({
    this.companyId,
    this.name,
    this.id,
    this.parentId,
    this.className,
    this.icon,
    this.sequence,
    this.isSendData,
  });

  int companyId;
  String name;
  int id;
  int parentId;
  String className;
  String icon;
  int sequence;
  String isSendData;

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
      };
}
