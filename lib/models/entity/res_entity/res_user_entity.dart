// ignore_for_file: prefer_if_null_operators

import 'dart:convert';

class ResUserEntity {
  ResUserEntity({
    this.id,
    this.name,
  });

  int id;
  String name;

  factory ResUserEntity.fromJson(String str) =>
      ResUserEntity.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ResUserEntity.fromMap(Map<String, dynamic> json) => ResUserEntity(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
      };
}
