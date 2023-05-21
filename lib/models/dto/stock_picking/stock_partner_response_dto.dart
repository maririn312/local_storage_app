// To parse this JSON data, do
//
//     final stockPartnerResponseDto = stockPartnerResponseDtoFromJson(jsonString);

import 'dart:convert';

class StockPartnerResponseDto {
  int count;
  List<StockPartnerResult> results;

  StockPartnerResponseDto({
    this.count,
    this.results,
  });

  factory StockPartnerResponseDto.fromRawJson(String str) =>
      StockPartnerResponseDto.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory StockPartnerResponseDto.fromJson(Map<String, dynamic> json) =>
      StockPartnerResponseDto(
        count: json["count"],
        results: List<StockPartnerResult>.from(
            json["results"].map((x) => StockPartnerResult.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
      };
}

class StockPartnerResult {
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
  double partnerCredit;
  double partnerDebit;
  double creditLimit;
  int partnerGroupId;

  StockPartnerResult({
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
    this.partnerCredit,
    this.partnerDebit,
    this.creditLimit,
    this.partnerGroupId,
  });

  factory StockPartnerResult.fromRawJson(String str) =>
      StockPartnerResult.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory StockPartnerResult.fromJson(Map<String, dynamic> json) =>
      StockPartnerResult(
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
        partnerCredit: json["partner_credit"].toDouble(),
        partnerDebit: json["partner_debit"].toDouble(),
        creditLimit: json["credit_limit"],
        partnerGroupId: json["partner_group_id"],
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
        "partner_credit": partnerCredit,
        "partner_debit": partnerDebit,
        "credit_limit": creditLimit,
        "partner_group_id": partnerGroupId,
      };
}
