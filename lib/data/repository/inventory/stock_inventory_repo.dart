// ignore_for_file: avoid_print, non_constant_identifier_names, unused_local_variable, missing_return

import 'package:flutter/cupertino.dart';
import 'package:abico_warehouse/data/db_provider.dart';
import 'package:abico_warehouse/data/service/inventory/stock_inventory_api_client.dart';
import 'package:abico_warehouse/models/dto/inventory/stock_inventory_response_dto.dart';
import 'package:abico_warehouse/models/entity/stock_entity/inventory/stock_inventory_entity.dart';

class StockInventoryRepository {
  final StockInventoryApiClient stockInventoryApiClient;

  StockInventoryRepository({@required this.stockInventoryApiClient});

  Future<StockInventoryResponseDto> getStockInventoryList({
    String ip,
  }) async {
    StockInventoryResponseDto stockPickingLineDto =
        await stockInventoryApiClient.getStockInventoryList(ip);

    if (stockPickingLineDto != null) {
      await DBProvider.db.deleteInventory();
      for (int i = 0; i < stockPickingLineDto.results.length; i++) {
        await DBProvider.db.newInventory(StockInventoryEntity(
          id: stockPickingLineDto.results[i].id,
          accountingDate:
              stockPickingLineDto.results[i].accountingDate.toString(),
          name: stockPickingLineDto.results[i].name,
          state: stockPickingLineDto.results[i].state,
          locationIds: stockPickingLineDto.results[i].locationIds,
        ));
      }

      return stockInventoryApiClient.getStockInventoryList(
        ip,
      );
    }
  }
}
