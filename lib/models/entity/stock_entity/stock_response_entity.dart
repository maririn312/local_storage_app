import 'dart:convert';

class StockEntity {
  StockEntity({
    this.id,
    this.name,
    this.code,
    this.companyId,
    this.isSendData,
  });

  int id;
  String name;
  String code;
  int companyId;
  String isSendData;

  factory StockEntity.fromJson(String str) =>
      StockEntity.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory StockEntity.fromMap(Map<String, dynamic> json) => StockEntity(
        id: json["id"],
        name: json["name"],
        code: json["code"],
        companyId: json["company_id"],
        isSendData: json["is_send_data"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "code": code,
        "company_id": companyId,
        "is_send_data": isSendData,
      };
}
