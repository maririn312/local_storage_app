// To parse this JSON data, do
//
//     final subCategoryResponseDto = subCategoryResponseDtoFromJson(jsonString);

// ignore_for_file: prefer_if_null_operators

import 'dart:convert';

class SubCategoryEntity {
  SubCategoryEntity({
    this.companyId,
    this.id,
    this.name,
    this.icon,
    this.className,
    this.parentId,
    this.sequence,
    this.isSendData,
  });

  int companyId;
  int id;
  String name;
  String icon;
  int parentId;
  String className;
  int sequence;
  String isSendData;

  factory SubCategoryEntity.fromJson(String str) =>
      SubCategoryEntity.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SubCategoryEntity.fromMap(Map<String, dynamic> json) =>
      SubCategoryEntity(
        companyId: json["company_id"] == null ? null : json["company_id"],
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        icon: json["icon"] == null ? null : json["icon"],
        parentId: json["parent_id"],
        className: json["class_name"] == null ? null : json["class_name"],
        sequence: json["sequence"] == null ? null : json["sequence"],
        isSendData: json["is_send_data"] == null ? null : json["is_send_data"],
      );

  Map<String, dynamic> toMap() => {
        "company_id": companyId == null ? null : companyId,
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "icon": icon == null ? null : icon,
        "parent_id": parentId,
        "class_name": className == null ? null : className,
        "sequence": sequence == null ? null : sequence,
        "is_send_data": isSendData == null ? null : isSendData,
      };
}
