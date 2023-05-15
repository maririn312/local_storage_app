// To parse this JSON data, do
//
//     final subCategoryResponseDto = subCategoryResponseDtoFromJson(jsonString);

import 'dart:convert';

class SubCategoryResponseDto {
  SubCategoryResponseDto({
    this.count,
    this.results,
  });

  int count;
  List<SubCategoryResult> results;

  factory SubCategoryResponseDto.fromRawJson(String str) =>
      SubCategoryResponseDto.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SubCategoryResponseDto.fromJson(Map<String, dynamic> json) =>
      SubCategoryResponseDto(
        count: json["count"],
        results: json["results"] == null
            ? null
            : List<SubCategoryResult>.from(
                json["results"].map((x) => SubCategoryResult.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "results": results == null
            ? null
            : List<dynamic>.from(results.map((x) => x.toJson())),
      };
}

class SubCategoryResult {
  SubCategoryResult({
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

  factory SubCategoryResult.fromRawJson(String str) =>
      SubCategoryResult.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SubCategoryResult.fromJson(Map<String, dynamic> json) =>
      SubCategoryResult(
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
