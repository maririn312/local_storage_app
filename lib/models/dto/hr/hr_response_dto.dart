// To parse this JSON data, do
//
//     final hrResponseDto = hrResponseDtoFromJson(jsonString);

import 'dart:convert';

class HrResponseDto {
  HrResponseDto({
    this.count,
    this.results,
  });

  int count;
  List<HrResult> results;

  factory HrResponseDto.fromRawJson(String str) =>
      HrResponseDto.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory HrResponseDto.fromJson(Map<String, dynamic> json) => HrResponseDto(
        count: json["count"],
        results: json["results"] == null
            ? null
            : List<HrResult>.from(
                json["results"].map((x) => HrResult.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "results": results == null
            ? null
            : List<dynamic>.from(results.map((x) => x.toJson())),
      };
}

class HrResult {
  HrResult({
    this.id,
    this.name,
    this.userId,
    this.jobTitle,
    this.mobilePhone,
    this.workEmail,
    this.companyId,
    this.image1920,
    this.workLocation,
  });

  int id;
  String name;
  int userId;
  String jobTitle;
  String mobilePhone;
  String workEmail;
  int companyId;
  String image1920;
  String workLocation;

  factory HrResult.fromRawJson(String str) =>
      HrResult.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory HrResult.fromJson(Map<String, dynamic> json) => HrResult(
        id: json["id"],
        name: json["name"],
        userId: json["user_id"],
        jobTitle: json["job_title"],
        mobilePhone: json["mobile_phone"],
        workEmail: json["work_email"],
        companyId: json["company_id"],
        image1920: json["image_1920"],
        workLocation: json["work_location"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "user_id": userId,
        "job_title": jobTitle,
        "mobile_phone": mobilePhone,
        "work_email": workEmail,
        "company_id": companyId,
        "image_1920": image1920,
        "work_location": workLocation,
      };
}
