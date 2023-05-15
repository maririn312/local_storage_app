// ignore_for_file: unnecessary_null_comparison, prefer_if_null_operators, non_constant_identifier_names

import 'dart:convert';

class UserDetailEntity {
  UserDetailEntity({this.id, this.username, this.password, this.ip});

  int id;
  String username;
  String password;
  String ip;

  factory UserDetailEntity.fromJson(String str) =>
      UserDetailEntity.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UserDetailEntity.fromMap(Map<String, dynamic> json) =>
      UserDetailEntity(
        id: json["id"] == null ? null : json["id"],
        username: json["username"] == null ? null : json["username"],
        password: json["password"] == null ? null : json["password"],
        ip: json["ip"] == null ? null : json["ip"],
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "username": username == null ? null : username,
        "password": password == null ? null : password,
        "ip": ip == null ? null : ip,
      };
}
