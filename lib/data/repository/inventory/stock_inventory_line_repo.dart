import 'package:flutter/cupertino.dart';
import 'package:abico_warehouse/data/db_provider.dart';
import 'package:abico_warehouse/data/service/inventory/stock_inventory_line_api_client.dart';
import 'package:abico_warehouse/models/dto/inventory/stock_inventory_line_response_dto.dart';
import 'package:abico_warehouse/models/entity/stock_entity/inventory/stock_inventory_line_entity.dart';

class StockInventoryLineRepository {
  final StockInventoryLineApiClient stockInventoryLineApiClient;

  StockInventoryLineRepository({@required this.stockInventoryLineApiClient});

  Future<StockInventoryLineResponseDto> getStockInventoryLineList({
    String ip,
  }) async {
    StockInventoryLineResponseDto stockPickingLineDto =
        await stockInventoryLineApiClient.getStockInventoryLineList(ip);

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
