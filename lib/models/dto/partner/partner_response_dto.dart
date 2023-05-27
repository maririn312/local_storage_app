// To parse this JSON data, do
//
//     final partnerResponseDto = partnerResponseDtoFromJson(jsonString);

import 'dart:convert';

class PartnerResponseDto {
  PartnerResponseDto({
    this.count,
    this.results,
  });

  int count;
  List<PartnerResult> results;

  factory PartnerResponseDto.fromRawJson(String str) =>
      PartnerResponseDto.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PartnerResponseDto.fromJson(Map<String, dynamic> json) =>
      PartnerResponseDto(
        count: json["count"],
        results: json["results"] == null
            ? null
            : List<PartnerResult>.from(
                json["results"].map((x) => PartnerResult.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "results": results == null
            ? null
            : List<dynamic>.from(results.map((x) => x.toJson())),
      };
}

class PartnerResult {
  PartnerResult({
    this.id,
    this.name,
    this.vat,
    this.companyId,
    this.email,
    this.phone,
    this.street,
    this.website,
    this.userId,
    this.propertyProductPricelist,
    this.propertyPaymentTermId,
    this.companyType,
    this.categoryId,
    this.mobile,
  });

  int id;
  String name;
  String vat;
  int companyId;
  String email;
  String phone;
  String street;
  String website;
  int userId;
  int propertyProductPricelist;
  int propertyPaymentTermId;
  String companyType;
  int categoryId;
  String mobile;

  factory PartnerResult.fromRawJson(String str) =>
      PartnerResult.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PartnerResult.fromJson(Map<String, dynamic> json) => PartnerResult(
        id: json["id"],
        name: json["name"],
        vat: json["vat"],
        companyId: json["company_id"],
        email: json["email"],
        phone: json["phone"],
        street: json["street"],
        website: json["website"],
        userId: json["user_id"],
        propertyProductPricelist: json["property_product_pricelist"],
        propertyPaymentTermId: json["property_payment_term_id"],
        companyType: json["company_type"],
        categoryId: json["category_id"],
        mobile: json["mobile"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "vat": vat,
        "company_id": companyId,
        "email": email,
        "phone": phone,
        "street": street,
        "website": website,
        "user_id": userId,
        "property_product_pricelist": propertyProductPricelist,
        "property_payment_term_id": propertyPaymentTermId,
        "company_type":
            companyType == null ? null : companyTypeValues.reverse[companyType],
        "category_id": categoryId,
        "mobile": mobile,
      };
}

// ignore: constant_identifier_names
enum CompanyType { PERSON, COMPANY }

final companyTypeValues =
    EnumValues({"company": CompanyType.COMPANY, "person": CompanyType.PERSON});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap ??= map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
