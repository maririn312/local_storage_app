import 'dart:convert';

class PartnerEntity {
  PartnerEntity(
      {this.id,
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
      this.function});

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
  List<int> categoryId;
  String mobile;
  String function;
  factory PartnerEntity.fromJson(String str) =>
      PartnerEntity.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PartnerEntity.fromMap(Map<String, dynamic> json) => PartnerEntity(
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
        categoryId: json["category_id"] == null
            ? null
            : List<int>.from(json["category_id"].map((x) => x)),
        mobile: json["mobile"],
        function: json["function"],
      );

  Map<String, dynamic> toMap() => {
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
        "company_type": companyType,
        "category_id": categoryId == null
            ? null
            : List<dynamic>.from(categoryId.map((x) => x)),
        "mobile": mobile,
        "function": function,
      };
}
