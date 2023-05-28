import 'package:flutter/cupertino.dart';
import 'package:local_storage_app/data/db_provider.dart';
import 'package:local_storage_app/data/service/inventory/stock_inventory_line_api_client.dart';
import 'package:local_storage_app/models/dto/inventory/stock_inventory_line_response_dto.dart';
import 'package:local_storage_app/models/entity/stock_entity/inventory/stock_inventory_line_entity.dart';

class StockInventoryLineRepository {
  final StockInventoryLineApiClient stockInventoryLineApiClient;

  StockInventoryLineRepository({@required this.stockInventoryLineApiClient});

  Future<StockInventoryLineResponseDto> getStockInventoryLineList({
    String inventory_id,
    String ip,
  }) async {
    StockInventoryLineResponseDto stockPickingLineDto =
        await stockInventoryLineApiClient.getStockInventoryLineList(
            ip, inventory_id);

    if (stockPickingLineDto != null) {
      await DBProvider.db.deleteInventoryLine();

      List<StockInventoryLineEntity> entities = stockPickingLineDto.results
          .map((result) => StockInventoryLineEntity(
                id: result.id,
                theoreticalQty: result.theoreticalQty.toDouble(),
                barcode: result.barcode,
                productName: result.productName,
              ))
          .toList();

      await DBProvider.db.batchInsertInventoryLines(entities);
    }

    return stockPickingLineDto;
  }
}
