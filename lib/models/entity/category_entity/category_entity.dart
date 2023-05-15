// ignore_for_file: prefer_if_null_operators

import 'dart:convert';

class CategoryEntity {
  CategoryEntity({
    this.companyId,
    this.id,
    this.name,
    this.icon,
    this.sequence,
    this.isSendData,
  });

  int companyId;
  int id;
  String name;
  String icon;
  int sequence;
  String isSendData;

  factory CategoryEntity.fromJson(String str) =>
      CategoryEntity.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CategoryEntity.fromMap(Map<String, dynamic> json) => CategoryEntity(
        companyId: json["company_id"] == null ? null : json["company_id"],
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        icon: json["icon"] == null ? null : json["icon"],
        sequence: json["sequence"] == null ? null : json["sequence"],
        isSendData: json["is_send_data"] == null ? null : json["is_send_data"],
      );

  Map<String, dynamic> toMap() => {
        "company_id": companyId == null ? null : companyId,
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "icon": icon == null ? null : icon,
        "sequence": sequence == null ? null : sequence,
        "is_send_data": isSendData == null ? null : isSendData,
      };
}
