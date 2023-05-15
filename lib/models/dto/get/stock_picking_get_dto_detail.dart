// To parse this JSON data, do
//
//     final stockPickingGetResult = stockPickingGetResultFromJson(jsonString);

import 'dart:convert';

class StockPickingGetResult {
  StockPickingGetResult({
    this.checkUser,
  });

  bool checkUser;

  factory StockPickingGetResult.fromRawJson(String str) =>
      StockPickingGetResult.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory StockPickingGetResult.fromJson(Map<String, dynamic> json) =>
      StockPickingGetResult(
        checkUser: json["check_user"],
      );

  Map<String, dynamic> toJson() => {
        "check_user": checkUser,
      };
}
