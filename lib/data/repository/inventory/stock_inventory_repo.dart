import 'package:flutter/cupertino.dart';
import 'package:local_storage_app/data/db_provider.dart';
import 'package:local_storage_app/data/service/inventory/stock_inventory_api_client.dart';
import 'package:local_storage_app/models/dto/inventory/stock_inventory_response_dto.dart';
import 'package:local_storage_app/models/entity/stock_entity/inventory/stock_inventory_entity.dart';

class StockInventoryRepository {
  final StockInventoryApiClient stockInventoryApiClient;

  StockInventoryRepository({@required this.stockInventoryApiClient});

  // ignore: missing_return
  Future<StockInventoryResponseDto> getStockInventoryList() async {
    StockInventoryResponseDto stockPickingLineDto =
        await stockInventoryApiClient.getStockInventoryList();

    if (stockPickingLineDto != null) {
      await DBProvider.db.deleteInventory();

      List<StockInventoryEntity> inventoryEntities = stockPickingLineDto.results
          .map((result) => StockInventoryEntity(
                id: result.id,
                accountingDate: result.accountingDate.toString(),
                name: result.name,
                state: result.state,
                locationIds: result.locationIds,
              ))
          .toList();

      await DBProvider.db.batchInsertInventory(inventoryEntities);

      return stockInventoryApiClient.getStockInventoryList();
    }
  }
}
