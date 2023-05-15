// To parse this JSON data, do
//
//     final messageResponseDto = messageResponseDtoFromJson(jsonString);

// ignore_for_file: prefer_null_aware_operators

import 'dart:convert';

class MessageResponseDto {
  MessageResponseDto({
    this.id,
    this.employeeId,
    this.checkIn,
  });

  int id;
  int employeeId;
  DateTime checkIn;

  factory MessageResponseDto.fromRawJson(String str) =>
      MessageResponseDto.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MessageResponseDto.fromJson(Map<String, dynamic> json) =>
      MessageResponseDto(
        id: json["id"],
        employeeId: json["employee_id"],
        checkIn:
            json["check_in"] == null ? null : DateTime.parse(json["check_in"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "employee_id": employeeId,
        "check_in": checkIn == null ? null : checkIn.toIso8601String(),
      };
}
