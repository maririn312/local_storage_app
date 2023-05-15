String tableProduct = 'product';

class ProductField {
  static final List<String> values = [
    /// Add all fields
    id, responsibleId, name, barcode, categId, defaultCode,
    listPrice, type, weight, volume, uomId, companyId, taxesId, image1920,
  ];

  static String id = '_id';
  static String responsibleId = 'responsibleId';
  static String name = 'name';
  static String barcode = 'barcode';
  static String categId = 'categId';
  static String defaultCode = 'defaultCode';
  static String listPrice = 'listPrice';
  static String type = 'type';
  static String weight = 'weight';
  static String volume = 'volume';
  static String uomId = 'uomId';
  static String companyId = 'companyId';
  static String taxesId = 'taxesId';
  static String image1920 = 'image1920';
}

class Product {
  final int id;
  final int responsibleId;
  final String name;
  final String barcode;
  final int categId;
  final String defaultCode;
  final double listPrice;
  final Type type;
  final double weight;
  final double volume;
  final int uomId;
  final int companyId;
  final int taxesId;
  final String image1920;

  const Product({
    this.id,
    this.responsibleId,
    this.name,
    this.barcode,
    this.categId,
    this.defaultCode,
    this.listPrice,
    this.type,
    this.weight,
    this.volume,
    this.uomId,
    this.companyId,
    this.taxesId,
    this.image1920,
  });

  Product copy({
    int id,
    int responsibleId,
    String name,
    String barcode,
    int categId,
    String defaultCode,
    double listPrice,
    Type type,
    double weight,
    double volume,
    int uomId,
    int companyId,
    int taxesId,
    String image1920,
  }) =>
      Product(
        id: id ?? this.id,
        responsibleId: responsibleId ?? this.responsibleId,
        name: name ?? this.name,
        barcode: barcode ?? this.barcode,
        categId: categId ?? this.categId,
        defaultCode: defaultCode ?? this.defaultCode,
        listPrice: listPrice ?? this.listPrice,
        type: type ?? this.type,
        weight: weight ?? this.weight,
        volume: volume ?? this.volume,
        uomId: uomId ?? this.uomId,
        companyId: companyId ?? this.companyId,
        taxesId: taxesId ?? this.taxesId,
        image1920: image1920 ?? this.image1920,
      );

  static Product fromJson(Map<String, Object> json) => Product(
        id: json[ProductField.id] as int,
        responsibleId: json[ProductField.responsibleId] as int,
        name: json[ProductField.name] as String,
        barcode: json[ProductField.barcode] as String,
        categId: json[ProductField.categId] as int,
        defaultCode: json[ProductField.defaultCode] as String,
        listPrice: json[ProductField.listPrice] as double,
        weight: json[ProductField.weight] as double,
        volume: json[ProductField.volume] as double,
        uomId: json[ProductField.uomId] as int,
        companyId: json[ProductField.companyId] as int,
        taxesId: json[ProductField.taxesId] as int,
        image1920: json[ProductField.image1920] as String,
      );

  Map<String, Object> toJson() => {
        ProductField.id: id,
        ProductField.responsibleId: responsibleId,
        ProductField.name: name,
        ProductField.barcode: barcode,
        ProductField.categId: categId,
        ProductField.defaultCode: defaultCode,
        ProductField.listPrice: listPrice,
        ProductField.type: type,
        ProductField.weight: weight,
        ProductField.volume: volume,
        ProductField.uomId: uomId,
        ProductField.companyId: companyId,
        ProductField.taxesId: taxesId,
        ProductField.image1920: image1920,
      };
}
