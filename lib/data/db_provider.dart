// ignore_for_file: unnecessary_brace_in_string_interps, avoid_print,, depend_on_referenced_packages

import 'dart:io';

import 'package:abico_warehouse/models/entity/auth_entity/user_detail_entity.dart';
import 'package:abico_warehouse/models/entity/auth_entity/user_entity.dart';
import 'package:abico_warehouse/models/entity/category_entity/category_entity.dart';
import 'package:abico_warehouse/models/entity/company_entity/company_entity.dart';
import 'package:abico_warehouse/models/entity/partner_entity/partner_entity.dart';
import 'package:abico_warehouse/models/entity/res_entity/res_user_entity.dart';
import 'package:abico_warehouse/models/entity/stock_entity/inventory/stock_inventory_entity.dart';
import 'package:abico_warehouse/models/entity/stock_entity/inventory/stock_inventory_line_entity.dart';
import 'package:abico_warehouse/models/entity/stock_entity/product_entity/stock_product_register_entity.dart';
import 'package:abico_warehouse/models/entity/stock_entity/stock_location_entity.dart';
import 'package:abico_warehouse/models/entity/stock_entity/stock_picking_entity/stock_move_entity.dart';
import 'package:abico_warehouse/models/entity/stock_entity/stock_picking_entity/stock_picking_entity.dart';
import 'package:abico_warehouse/models/entity/stock_entity/stock_picking_entity/stock_picking_type_entity.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../models/entity/category_entity/sub_category_entity.dart';
import '../models/entity/stock_entity/stock_measure_entity.dart';

class DBProvider {
  DBProvider._();
  static final DBProvider _databaseService = DBProvider._init();
  factory DBProvider() => _databaseService;
  DBProvider._init();

  static DBProvider db = DBProvider._();

  Database _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database;
    }

    _database = await initDB(false);
    return _database;
  }

  initDB(bool hasInit) async {
    Directory documentsDir = await getApplicationDocumentsDirectory();
    String path = join(documentsDir.path, 'tenger.db');
    return await openDatabase(path, version: 1, readOnly: false,
        onOpen: (db) async {
      await syncExistingTables(db, hasInit);
    }, onCreate: (
      Database db,
      int version,
    ) async {
      await createTables(db);
    });
  }

  /// ========================= CREATE TABLE ========================== ///
  Future<void> createTables(Database db) async {
    await createUserTable(db);
    await createUserDetailTable(db);
    await createCategoryTable(db);
    await createSubCategoryTable(db);
    await createPartnerTable(db);
    await createProductRegiterTable(db);
    await createStockLocationTable(db);
    await createStockMeasureTable(db);
    await createResCompanyTable(db);
    await createResUserTable(db);
    await createStockPickingTable(db);
    await createStockMoveLineTable(db);
    await createStockPickingTypeTable(db);
    await createInventoryTable(db);
    await createInventoryLineTable(db);
    // await _createDBProduct(db);
  }

  Future<void> createUserTable(Database db) async {
    await db.execute('''
        CREATE TABLE tenger_user (id INTEGER PRIMARY KEY, db TEXT, ip TEXT , username TEXT, password TEXT, access_token TEXT, refresh_token TEXT,  uid INTEGER)
    ''');
  }

  Future<void> createUserDetailTable(Database db) async {
    await db.execute('''
        CREATE TABLE tenger_user_detail (id INTEGER PRIMARY KEY, db TEXT, username TEXT, password TEXT, ip TEXT)
    ''');
  }

////torliig n sain medehgu bga
  Future<void> createCategoryTable(Database db) async {
    await db.execute('''
        CREATE TABLE tenger_category (id INTEGER PRIMARY KEY, name TEXT,  icon BLOB, sequence INTEGER, is_send_data TEXT, company_id INTEGER)
    ''');
  }

  Future<void> createSubCategoryTable(Database db) async {
    await db.execute('''
        CREATE TABLE tenger_subcategory (id INTEGER PRIMARY KEY, name TEXT, parent_id INTEGER, class_name TEXT, icon BLOB, sequence INTEGER, is_send_data TEXT, company_id INTEGER)
    ''');
  }

  Future<void> createPartnerTable(Database db) async {
    await db.execute('''
        CREATE TABLE tenger_partner (id INTEGER PRIMARY KEY, name TEXT,company_id INTEGER, vat TEXT,email TEXT,phone TEXT, street TEXT, mobile TEXT,website TEXT,user_id INTEGER, property_product_pricelist INTEGER,property_payment_term_id INTEGER,company_type TEXT,function TEXT,category_id INTEGER)
    ''');
  }

  Future<void> createProductRegiterTable(Database db) async {
    await db.execute('''
        CREATE TABLE tenger_product_register (id INTEGER PRIMARY KEY, responsible_id INTEGER, name TEXT, barcode TEXT, categ_id INEGER, default_code TEXT, list_price REAL, type TEXT, weight REAL, volume REAL, uom_id INTEGER, company_id INTEGER, is_send_data TEXT, image_128 TEXT)
    ''');
  }

  Future<void> createStockLocationTable(Database db) async {
    await db.execute('''
        CREATE TABLE tenger_stock_location (id INTEGER PRIMARY KEY, name TEXT, location_id INTEGER, usage TEXT, company_id INTEGER, complete_name TEXT)
    ''');
  }

  Future<void> createStockMeasureTable(Database db) async {
    await db.execute('''
        CREATE TABLE tenger_stock_measure (id INTEGER PRIMARY KEY, rounding REAL, name TEXT)
    ''');
  }

  Future<void> createResCompanyTable(Database db) async {
    await db.execute('''
        CREATE TABLE tenger_company (id INTEGER PRIMARY KEY, name TEXT)
    ''');
  }

  Future<void> createResUserTable(Database db) async {
    await db.execute('''
        CREATE TABLE tenger_res_user (id INTEGER PRIMARY KEY, name TEXT)
    ''');
  }

  Future<void> createStockPickingTable(Database db) async {
    await db.execute('''
        CREATE TABLE tenger_stock_picking (id INTEGER PRIMARY KEY ,name TEXT, partner_id INTEGER, picking_type_id INTEGER, location_id INTEGER, scheduled_date TEXT, origin TEXT, state TEXT,is_checked TEXT)
    ''');
  }

  Future<void> createStockMoveLineTable(Database db) async {
    await db.execute('''
        CREATE TABLE tenger_stock_move_line (id INTEGER PRIMARY KEY , product_id INTEGER, description_picking TEXT,date_expected TEXT, quantity_done REAL, product_uom INTEGER, picking_id INTEGER, check_qty REAL, diff_qty REAL,product_uom_qty REAL, barcode TEXT,product_name TEXT)
    ''');
  }

  Future<void> createStockPickingTypeTable(Database db) async {
    await db.execute('''
        CREATE TABLE tenger_stock_picking_type (id INTEGER PRIMARY KEY , name TEXT, code TEXT)
    ''');
  }

  Future<void> createInventoryTable(Database db) async {
    await db.execute('''
        CREATE TABLE tenger_inventory (id INTEGER , name TEXT,accounting_date TEXT, company_id INTEGER, is_send_data TEXT,location_ids INTEGER,state TEXT,product_ids TEXT)
    ''');
  }

  Future<void> createInventoryLineTable(Database db) async {
    await db.execute('''
        CREATE TABLE tenger_inventory_line (id INTEGER PRIMARY KEY, theoretical_qty REAL, product_qty REAL, barcode TEXT, product_name TEXT)
    ''');
  }

  Future<void> reloadTables(Database db, UserEntity userEntity) async {
    await db.execute('DROP TABLE IF EXISTS tenger_user');
    await db.execute('DROP TABLE IF EXISTS tenger_category');
    await db.execute('DROP TABLE IF EXISTS tenger_subcategory');
    await db.execute('DROP TABLE IF EXISTS tenger_partner');
    await db.execute('DROP TABLE IF EXISTS tenger_product_register');
    await db.execute('DROP TABLE IF EXISTS tenger_stock_location');
    await db.execute('DROP TABLE IF EXISTS tenger_stock_measure');
    await db.execute('DROP TABLE IF EXISTS tenger_company');
    await db.execute('DROP TABLE IF EXISTS tenger_res_user');
    await db.execute('DROP TABLE IF EXISTS tenger_stock_picking');
    await db.execute('DROP TABLE IF EXISTS tenger_stock_move_line');
    await db.execute('DROP TABLE IF EXISTS tenger_stock_picking_type');
    await db.execute('DROP TABLE IF EXISTS tenger_user_detail');
    await db.execute('DROP TABLE IF EXISTS tenger_inventory');
    await db.execute('DROP TABLE IF EXISTS tenger_inventory_line');

    // await db.execute('DROP TABLE IF EXISTS $tableProduct');
    await db.insert('tenger_app', userEntity.toMap());
    print('TABLES ARE RELOADED');
  }

  // ====================== APP =========================
  deleteApp() async {
    final db = await database;
    db.delete('tenger_app');
  }

  // ====================== USER =========================

  Future<UserEntity> getUser() async {
    final db = await database;
    var res = await db.query('tenger_user');
    print('${res}');
    List<UserEntity> users = res.isNotEmpty
        ? res.map((user) => UserEntity.fromMap(user)).toList()
        : [];
    if (users.isNotEmpty) {
      print('end res iig hevlene ${res}');
      return users.first;
    }
    return null;
  }

  newUser(UserEntity user) async {
    final db = await database;
    var res = await db.insert('tenger_user', user.toMap());
    return res;
  }

  updateUser(UserEntity user) async {
    final db = await database;
    var res = await db.update('tenger_user', user.toMap(),
        where: 'id = ?', whereArgs: [user.id]);
    return res;
  }

  deleteUsers() async {
    final db = await database;
    db.delete('tenger_user');
  }

  // ====================== USER DETAIL  =========================

  Future<UserDetailEntity> getUserDetail() async {
    final db = await database;
    var res = await db.query('tenger_user_detail');
    print('${res}');
    List<UserDetailEntity> users = res.isNotEmpty
        ? res.map((user) => UserDetailEntity.fromMap(user)).toList()
        : [];
    if (users.isNotEmpty) {
      return users.first;
    }
    return null;
  }

  newUserDetail(UserDetailEntity user) async {
    final db = await database;
    var res = await db.insert('tenger_user_detail', user.toMap());
    return res;
  }

  updateUserDetail(UserDetailEntity user) async {
    final db = await database;
    var res = await db.update('tenger_user_detail', user.toMap(),
        where: 'id = ?', whereArgs: [user.id]);
    return res;
  }

  deleteUsersDetail() async {
    final db = await database;
    db.delete('tenger_user_detail');
  }

  // ====================== CATEGORY =========================

  Future<List<CategoryEntity>> getCategories() async {
    final db = await database;
    var res = await db.query('tenger_category', orderBy: "name ASC");
    List<CategoryEntity> items = res.isNotEmpty
        ? res
            .map((categoryItem) => CategoryEntity.fromMap(categoryItem))
            .toList()
        : [];
    var batch = db.batch();
    // batch.rawInsert('tenger_category');
    await batch.commit(noResult: true);
    // return null;
    return items;
  }

  newCategory(CategoryEntity category) async {
    final db = await database;
    var res = await db.insert('tenger_category', category.toMap());
    var batch = db.batch();
    await batch.commit(noResult: true);
    return res;
  }

  updateCategory(CategoryEntity category) async {
    final db = await database;
    var res = await db.update('tenger_category', category.toMap(),
        where: 'id = ?', whereArgs: [category.id]);
    return res;
  }

  deleteCategories() async {
    final db = await database;
    db.delete('tenger_category');
  }

  // ====================== SUB CATEGORY =========================

  Future<List<SubCategoryEntity>> getSubCategories() async {
    final db = await database;
    var res = await db.query('tenger_subcategory', orderBy: "name ASC");
    List<SubCategoryEntity> subItem = res.isNotEmpty
        ? res
            .map((subCategoryitems) =>
                SubCategoryEntity.fromMap(subCategoryitems))
            .toList()
        : [];
    var batch = db.batch();
    await batch.commit(noResult: true);
    // return null;
    return subItem;
  }

  newSubCategory(SubCategoryEntity subCategory) async {
    final db = await database;
    var res = await db.insert('tenger_subcategory', subCategory.toMap());
    var batch = db.batch();
    await batch.commit(noResult: true);
    return res;
  }

  updateSubCategory(SubCategoryEntity subCategoryEntity) async {
    final db = await database;
    var res = await db.update('tenger_subcategory', subCategoryEntity.toMap(),
        where: 'id = ?', whereArgs: [subCategoryEntity.id]);
    return res;
  }

  deleteSubCategories() async {
    final db = await database;
    db.delete('tenger_subcategory');
  }

  // ====================== PARTNER  =========================

  Future<List<PartnerEntity>> getPartner() async {
    final db = await database;
    var res = await db.query('tenger_partner', orderBy: "name ASC");
    List<PartnerEntity> partnerItem = res.isNotEmpty
        ? res
            .map((partneritems) => PartnerEntity.fromMap(partneritems))
            .toList()
        : [];
    var batch = db.batch();
    await batch.commit(noResult: true);
    // return null;
    return partnerItem;
  }

  newPartner(PartnerEntity partner) async {
    final db = await database;
    var res = await db.insert('tenger_partner', partner.toMap());
    var batch = db.batch();
    await batch.commit(noResult: true);
    return res;
  }

  updatePartner(PartnerEntity partnerEntity) async {
    final db = await database;
    var res = await db.update('tenger_partner', partnerEntity.toMap(),
        where: 'id = ?', whereArgs: [partnerEntity.id]);
    return res;
  }

  deletePartner() async {
    final db = await database;
    db.delete('tenger_partner');
  }

  // ====================== PRODUCT REGISTER =========================

  Future<List<StockProductRegisterEntity>> getProductRegister() async {
    final db = await database;
    var res = await db.query('tenger_product_register', orderBy: "name ASC");
    List<StockProductRegisterEntity> productRegisterItems = res.isNotEmpty
        ? res
            .map((productRegisterItem) =>
                StockProductRegisterEntity.fromMap(productRegisterItem))
            .toList()
        : [];
    var batch = db.batch();
    await batch.commit(noResult: true);
    print('resiig hevlej bn ${productRegisterItems}');
    return productRegisterItems;
    // return null;
  }

  newProductRegister(StockProductRegisterEntity productRegisterEntity) async {
    final db = await database;
    var res = await db.insert(
        'tenger_product_register', productRegisterEntity.toMap());
    var batch = db.batch();
    await batch.commit(noResult: true);
    return res;
  }

  updateProductRegister(
      StockProductRegisterEntity productRegisterEntity) async {
    final db = await database;
    var res = await db.update(
        'tenger_product_register', productRegisterEntity.toMap(),
        where: 'id = ?', whereArgs: [productRegisterEntity.id]);
    return res;
  }

  deleteProductRegister() async {
    final db = await database;
    db.delete('tenger_product_register');
  }

  // ====================== STOCK LOCATION =========================

  Future<List<StockLocationEntity>> getStockLocation() async {
    final db = await database;
    var res = await db.query('tenger_stock_location', orderBy: "name ASC");
    List<StockLocationEntity> stockLocationItems = res.isNotEmpty
        ? res
            .map((stockLocationItem) =>
                StockLocationEntity.fromMap(stockLocationItem))
            .toList()
        : [];
    var batch = db.batch();
    await batch.commit(noResult: true);
    // return null;
    return stockLocationItems;
  }

  newStockLocation(StockLocationEntity stockLocationEntity) async {
    final db = await database;
    var res =
        await db.insert('tenger_stock_location', stockLocationEntity.toMap());
    var batch = db.batch();
    await batch.commit(noResult: true);
    return res;
  }

  updateStockLocation(StockLocationEntity stockLocationEntity) async {
    final db = await database;
    var res = await db.update(
        'tenger_stock_location', stockLocationEntity.toMap(),
        where: 'id = ?', whereArgs: [stockLocationEntity.id]);
    return res;
  }

  deleteStockLocation() async {
    final db = await database;
    db.delete('tenger_stock_location');
  }

  // ====================== STOCK MEASURE =========================

  Future<List<StockMeasureEntity>> getStockMeasure() async {
    final db = await database;
    var res = await db.query('tenger_stock_measure', orderBy: "name ASC");
    List<StockMeasureEntity> stockMeasureItems = res.isNotEmpty
        ? res
            .map((stockMeasureItem) =>
                StockMeasureEntity.fromMap(stockMeasureItem))
            .toList()
        : [];
    var batch = db.batch();
    await batch.commit(noResult: true);
    // return null;
    return stockMeasureItems;
  }

  newStockMeasure(StockMeasureEntity stockMeasureEntity) async {
    final db = await database;
    var res =
        await db.insert('tenger_stock_measure', stockMeasureEntity.toMap());
    var batch = db.batch();
    await batch.commit(noResult: true);
    return res;
  }

  updateStockMeasure(StockMeasureEntity stockMeasureEntity) async {
    final db = await database;
    var res = await db.update(
        'tenger_stock_measure', stockMeasureEntity.toMap(),
        where: 'id = ?', whereArgs: [stockMeasureEntity.id]);
    return res;
  }

  deleteStockMeasure() async {
    final db = await database;
    db.delete('tenger_stock_measure');
  }

  // ====================== COMPANY  =========================
  Future<List<CompanyEntity>> getCompany() async {
    final db = await database;
    var res = await db.query('tenger_company', orderBy: "name ASC");
    List<CompanyEntity> companyItems = res.isNotEmpty
        ? res
            .map((companyListItem) => CompanyEntity.fromMap(companyListItem))
            .toList()
        : [];
    var batch = db.batch();
    await batch.commit(noResult: true);
    // return null;
    return companyItems;
  }

  newCompany(CompanyEntity companyEntity) async {
    final db = await database;
    var res = await db.insert('tenger_company', companyEntity.toMap());
    var batch = db.batch();
    await batch.commit(noResult: true);
    return res;
  }

  updateCompany(CompanyEntity companyEntity) async {
    final db = await database;
    var res = await db.update('tenger_company', companyEntity.toMap(),
        where: 'id = ?', whereArgs: [companyEntity.id]);
    return res;
  }

  deleteCompany() async {
    final db = await database;
    db.delete('tenger_company');
  }

  // ====================== RES USER  =========================
  Future<List<ResUserEntity>> getResUser() async {
    final db = await database;
    var res = await db.query('tenger_res_user');
    List<ResUserEntity> resUserItems = res.isNotEmpty
        ? res
            .map((resUserListItem) => ResUserEntity.fromMap(resUserListItem))
            .toList()
        : [];
    var batch = db.batch();
    await batch.commit(noResult: true);
    // return null;
    return resUserItems;
  }

  newResUser(ResUserEntity resUserEntity) async {
    final db = await database;
    var res = await db.insert('tenger_res_user', resUserEntity.toMap());
    var batch = db.batch();
    await batch.commit(noResult: true);
    return res;
  }

  updateResUser(ResUserEntity resUserEntity) async {
    final db = await database;
    var res = await db.update('tenger_res_user', resUserEntity.toMap(),
        where: 'id = ?', whereArgs: [resUserEntity.id]);
    return res;
  }

  deleteResUser() async {
    final db = await database;
    db.delete('tenger_res_user');
  }

  deleteAccountPaymentTerm() async {
    final db = await database;
    db.delete('tenger_res_user');
  }

  // ====================== STOCK PICKING  =========================

  Future<List<StockPickingEntity>> getStockPicking() async {
    final db = await database;
    var res =
        await db.query('tenger_stock_picking', orderBy: "scheduled_date DESC");
    List<StockPickingEntity> stockMeasureItems = res.isNotEmpty
        ? res
            .map((stockMeasureItem) =>
                StockPickingEntity.fromMap(stockMeasureItem))
            .toList()
        : [];
    var batch = db.batch();
    await batch.commit(noResult: true);
    print('end picking hevlene  ${res}');
    return stockMeasureItems;
    // return null;
  }

  newStockPicking(StockPickingEntity stockPickingEntity) async {
    final db = await database;
    var res =
        await db.insert('tenger_stock_picking', stockPickingEntity.toMap());
    var batch = db.batch();
    await batch.commit(noResult: true);
    return res;
  }

  updateStockPicking(StockPickingEntity stockPickingEntity) async {
    final db = await database;
    var res = await db.update(
        'tenger_stock_picking', stockPickingEntity.toMap(),
        where: 'id = ?', whereArgs: [stockPickingEntity.id]);
    return res;
  }

  deliteStockPicking(StockPickingEntity stockPickingEntity) async {
    final db = await database;
    var res = await db.delete('tenger_stock_picking',
        where: 'id = ?', whereArgs: [stockPickingEntity.id]);
    return res;
  }

  deleteStockPicking() async {
    final db = await database;
    db.delete('tenger_stock_picking');
  }

  // ====================== STOCK MOVE LINE  =========================

  Future<List<StockMoveLineEntity>> getStockMoveLine() async {
    final db = await database;
    var butch = db.batch();
    var res =
        await db.query('tenger_stock_move_line', orderBy: "check_qty ASC");
    List<StockMoveLineEntity> stockMoveLineItems = res.isNotEmpty
        ? res
            .map((stockMoveLineItems) =>
                StockMoveLineEntity.fromMap(stockMoveLineItems))
            .toList()
        : [];
    // print('end ymr neg yum hevlene ${res}');
    // print('end ymr neg yum hevlene ${stockMoveLineItems}');
    await butch.commit(noResult: true);
    return stockMoveLineItems;
    // return null;
  }

  newStockMoveLine(StockMoveLineEntity stockMoveLineEntity) async {
    final db = await database;
    var res =
        await db.insert('tenger_stock_move_line', stockMoveLineEntity.toMap());
    var batch = db.batch();
    await batch.commit(noResult: true);
    return res;
  }

  updateStockMoveLine(StockMoveLineEntity stockMoveLineEntity) async {
    final db = await database;
    var res = await db.update(
        'tenger_stock_move_line', stockMoveLineEntity.toMap(),
        where: 'id = ?', whereArgs: [stockMoveLineEntity.id]);
    print('end yu bolj bn hary ${res}');
    return res;
  }

  deleteStockMoveLine() async {
    final db = await database;
    db.delete('tenger_stock_move_line');
  }

  // ====================== STOCK PICKING TYPE LINE  =========================
  Future<List<StockPickingTypeEntity>> getStockPickingType() async {
    final db = await database;
    var res = await db.query('tenger_stock_picking_type');
    List<StockPickingTypeEntity> stockPickingTypeItems = res.isNotEmpty
        ? res
            .map((stockPickingTypeItems) =>
                StockPickingTypeEntity.fromMap(stockPickingTypeItems))
            .toList()
        : [];
    var batch = db.batch();
    await batch.commit(noResult: true);
    return stockPickingTypeItems;
    // return null;
  }

  newStockPickingType(StockPickingTypeEntity stockMoveLineEntity) async {
    final db = await database;
    var res = await db.insert(
        'tenger_stock_picking_type', stockMoveLineEntity.toMap());
    var batch = db.batch();
    await batch.commit(noResult: true);
    return res;
  }

  updateStockPickingType(StockPickingTypeEntity stockMoveLineEntity) async {
    final db = await database;
    var res = await db.update(
        'tenger_stock_picking_type', stockMoveLineEntity.toMap(),
        where: 'id = ?', whereArgs: [stockMoveLineEntity.id]);
    return res;
  }

  deleteStockPickingType() async {
    final db = await database;
    db.delete('tenger_stock_picking_type');
  }

  // ====================== INVENTORY  =========================

  Future<List<StockInventoryEntity>> getInventory() async {
    final db = await database;

    var res = await db.query('tenger_inventory', orderBy: "id DESC");
    List<StockInventoryEntity> inventoryItem = res.isNotEmpty
        ? res
            .map((inventoryItems) =>
                StockInventoryEntity.fromMap(inventoryItems))
            .toList()
        : [];
    var batch = db.batch();
    await batch.commit(noResult: true);
    return inventoryItem;
    // return null;
  }

  newInventory(StockInventoryEntity inventory) async {
    final db = await database;
    var butch = db.batch();
    var res = await db.insert('tenger_inventory', inventory.toMap());
    await butch.commit(noResult: true);
    return res;
  }

  updateInventory(StockInventoryEntity inventoryResponseEntity) async {
    final db = await database;
    var res = await db.update(
        'tenger_inventory', inventoryResponseEntity.toMap(),
        where: 'id = ?', whereArgs: [inventoryResponseEntity]);
    return res;
  }

  deleteInventory() async {
    final db = await database;
    db.delete('tenger_inventory');
  }
  // ====================== INVENTORY LINE  =========================

  Future<List<StockInventoryLineEntity>> getInventoryLine() async {
    final db = await database;
    var butch = db.batch();
    var res =
        await db.query('tenger_inventory_line', orderBy: "product_qty ASC");
    List<StockInventoryLineEntity> inventoryLineItem = res.isNotEmpty
        ? res
            .map((inventoryLineItems) =>
                StockInventoryLineEntity.fromMap(inventoryLineItems))
            .toList()
        : [];
    await butch.commit(noResult: true);
    return inventoryLineItem;
    // return null;
  }

  newInventoryLine(StockInventoryLineEntity inventoryLine) async {
    final db = await database;
    var res = await db.insert('tenger_inventory_line', inventoryLine.toMap());
    var batch = db.batch();
    await batch.commit(noResult: true);
    return res;
  }

  updateInventoryLine(StockInventoryLineEntity inventoryLineEntity) async {
    final db = await database;
    var res = await db.update(
        'tenger_inventory_line', inventoryLineEntity.toMap(),
        where: 'id = ?', whereArgs: [inventoryLineEntity.id]);
    return res;
  }

  deleteInventoryLine() async {
    final db = await database;
    db.delete('tenger_inventory_line');
  }

//====================== RELATION FUNCTIONS =========================

  Future<PartnerEntity> partnerName(int id) async {
    final db = await _databaseService.database;
    final List<Map<String, dynamic>> maps =
        await db.query('tenger_partner', where: 'id = ?', whereArgs: [id]);
    return PartnerEntity.fromMap(maps[0]);
  }

  Future<StockMeasureEntity> measureName(int id) async {
    final db = await _databaseService.database;
    final List<Map<String, dynamic>> maps = await db
        .query('tenger_stock_measure', where: 'id = ?', whereArgs: [id]);
    return StockMeasureEntity.fromMap(maps[0]);
  }

  Future<CompanyEntity> companyName(int id) async {
    final db = await _databaseService.database;
    final List<Map<String, dynamic>> maps =
        await db.query('tenger_company', where: 'id = ?', whereArgs: [id]);
    return CompanyEntity.fromMap(maps[0]);
  }

  Future<StockProductRegisterEntity> productName(int id) async {
    final db = await _databaseService.database;
    final List<Map<String, dynamic>> maps = await db
        .query('tenger_product_register', where: 'id = ?', whereArgs: [id]);
    return StockProductRegisterEntity.fromMap(maps[0]);
  }

  Future<StockLocationEntity> stockLoacationName(int id) async {
    final db = await _databaseService.database;
    final List<Map<String, dynamic>> maps = await db
        .query('tenger_stock_location', where: 'id = ?', whereArgs: [id]);
    return StockLocationEntity.fromMap(maps[0]);
  }

  Future<ResUserEntity> userName(int id) async {
    final db = await _databaseService.database;
    final List<Map<String, dynamic>> maps =
        await db.query('tenger_res_user', where: 'id = ?', whereArgs: [id]);
    return ResUserEntity.fromMap(maps[0]);
  }

  Future<StockPickingTypeEntity> pickingTypeName(int id) async {
    final db = await _databaseService.database;
    final List<Map<String, dynamic>> maps = await db
        .query('tenger_stock_picking_type', where: 'id = ?', whereArgs: [id]);
    return StockPickingTypeEntity.fromMap(maps[0]);
  }

  syncExistingTables(Database db, bool hasInit) {}
}
