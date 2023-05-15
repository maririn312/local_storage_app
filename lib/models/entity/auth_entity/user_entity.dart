// ignore_for_file: unnecessary_null_comparison, prefer_if_null_operators, non_constant_identifier_names

import 'dart:convert';

class UserEntity {
  UserEntity(
      {this.id, this.uid, this.access_token, this.refresh_token, this.ip});

  int id;
  int uid;
  String access_token;
  String refresh_token;
  String ip;

  factory UserEntity.fromJson(String str) =>
      UserEntity.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UserEntity.fromMap(Map<String, dynamic> json) => UserEntity(
        id: json["id"] == null ? null : json["id"],
        access_token:
            json["access_token"] == null ? null : json["access_token"],
        refresh_token:
            json["refresh_token"] == null ? null : json["refresh_token"],
        uid: json["uid"] == null ? null : json["uid"],
        ip: json["ip"] == null ? null : json["ip"],
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "access_token": access_token == null ? null : access_token,
        "refresh_token": refresh_token == null ? null : refresh_token,
        "uid": uid == null ? null : uid,
        "ip": ip == null ? null : ip,
      };
}
