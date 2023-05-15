import 'dart:convert';

class CompanyEntity {
  CompanyEntity({
    this.id,
    this.name,
  });

  int id;
  String name;

  factory CompanyEntity.fromJson(String str) =>
      CompanyEntity.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CompanyEntity.fromMap(Map<String, dynamic> json) => CompanyEntity(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
      };
}
