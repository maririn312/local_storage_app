// ignore_for_file: avoid_print, non_constant_identifier_names, unused_local_variable, missing_return

import 'package:flutter/cupertino.dart';
import 'package:abico_warehouse/data/service/inventory/stock_inventory_api_client.dart';
import 'package:abico_warehouse/models/dto/inventory/stock_inventory_response_dto.dart';

class StockInventoryRepository {
  final StockInventoryApiClient stockInventoryApiClient;

  StockInventoryRepository({@required this.stockInventoryApiClient});

  Future<StockInventoryResponseDto> getStockInventory() async {
    return stockInventoryApiClient.getStockInventory();
  }
}
